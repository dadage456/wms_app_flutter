package com.example.wms_app

import android.annotation.SuppressLint
import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.content.IntentFilter
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.EventChannel

class MainActivity : FlutterActivity() {

    private val CHANNEL = "com.example.wms_app/scanner"
    private var eventSink: EventChannel.EventSink? = null
    private var isReceiverRegistered = false

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        EventChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setStreamHandler(object : EventChannel.StreamHandler {
                override fun onListen(arguments: Any?, events: EventChannel.EventSink?) {
                    eventSink = events
                    registerScannerReceiver()
                }

                override fun onCancel(arguments: Any?) {
                    eventSink = null
                    unregisterScannerReceiver()
                }
            })
    }

    private fun extractCode(intent: Intent): String? {
        // 常见字符串键（不同 PDA 厂商）
        val strKeys = listOf(
            "data", "barcode", "barCode", "scan_data",
            "SCAN_BARCODE1", "SCAN_BARCODE2", "scan_result", "code"
        )
        for (k in strKeys) {
            val v = intent.getStringExtra(k)
            if (!v.isNullOrEmpty()) return v
        }
        // 字节数组回退
        val byteKeys = listOf("dataBytes", "barcode_bytes", "barCodeBytes", "scan_bytes")
        for (k in byteKeys) {
            val bytes = intent.getByteArrayExtra(k)
            if (bytes != null && bytes.isNotEmpty()) {
                try {
                    return String(bytes, charset("UTF-8"))
                } catch (_: Exception) {
                    try {
                        return String(bytes, charset("GBK"))
                    } catch (_: Exception) {
                        // ignore
                    }
                }
            }
        }
        return null
    }

    private val scannerReceiver = object : BroadcastReceiver() {
        override fun onReceive(context: Context?, intent: Intent?) {
            if (intent == null) return
            if (intent.action == "com.scanner.broadcast") {
                val code = extractCode(intent)
                if (!code.isNullOrEmpty()) {
                    runOnUiThread {
                        eventSink?.success(code)
                    }
                }
            }
        }
    }

    @SuppressLint("UnspecifiedRegisterReceiverFlag")
    private fun registerScannerReceiver() {
        if (!isReceiverRegistered) {
            val filter = IntentFilter("com.scanner.broadcast")
            // 如有需要可设置优先级
            // filter.priority = IntentFilter.SYSTEM_HIGH_PRIORITY
            registerReceiver(scannerReceiver, filter)
            isReceiverRegistered = true
        }
    }

    private fun unregisterScannerReceiver() {
        if (isReceiverRegistered) {
            try {
                unregisterReceiver(scannerReceiver)
            } catch (_: Exception) {
            } finally {
                isReceiverRegistered = false
            }
        }
    }

    override fun onDestroy() {
        unregisterScannerReceiver()
        super.onDestroy()
    }
}