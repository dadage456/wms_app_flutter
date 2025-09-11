import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../models/outbound_collect_models.dart';

/// 出库采集扫码组件
class OutboundCollectScanWidget extends StatefulWidget {
  final ScanStep currentScanStep;
  final String? currentSiteCode;
  final BarcodeContent? currentBarcodeContent;
  final InventoryInfo? currentInventory;
  final Function(String code) onScanCode;
  final Function(int quantity) onConfirmQuantity;
  final VoidCallback onResetScan;

  const OutboundCollectScanWidget({
    Key? key,
    required this.currentScanStep,
    this.currentSiteCode,
    this.currentBarcodeContent,
    this.currentInventory,
    required this.onScanCode,
    required this.onConfirmQuantity,
    required this.onResetScan,
  }) : super(key: key);

  @override
  State<OutboundCollectScanWidget> createState() =>
      _OutboundCollectScanWidgetState();
}

class _OutboundCollectScanWidgetState extends State<OutboundCollectScanWidget> {
  final TextEditingController _scanController = TextEditingController();
  final TextEditingController _quantityController = TextEditingController();
  final FocusNode _scanFocusNode = FocusNode();
  final FocusNode _quantityFocusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    // 自动聚焦到扫码输入框
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _focusOnCurrentStep();
    });
  }

  @override
  void didUpdateWidget(OutboundCollectScanWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentScanStep != widget.currentScanStep) {
      _focusOnCurrentStep();
    }
  }

  @override
  void dispose() {
    _scanController.dispose();
    _quantityController.dispose();
    _scanFocusNode.dispose();
    _quantityFocusNode.dispose();
    super.dispose();
  }

  void _focusOnCurrentStep() {
    switch (widget.currentScanStep) {
      case ScanStep.site:
      case ScanStep.material:
        _scanController.clear();
        _scanFocusNode.requestFocus();
        break;
      case ScanStep.quantity:
        _quantityController.clear();
        _quantityFocusNode.requestFocus();
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            spreadRadius: 1,
            blurRadius: 3,
            offset: const Offset(0, -1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 步骤指示器
          _buildStepIndicator(),
          const SizedBox(height: 16),

          // 当前步骤内容
          _buildCurrentStepContent(),

          // 重置按钮
          if (widget.currentScanStep != ScanStep.site)
            Padding(
              padding: const EdgeInsets.only(top: 12),
              child: Center(
                child: TextButton.icon(
                  onPressed: widget.onResetScan,
                  icon: const Icon(Icons.refresh),
                  label: const Text('重新开始'),
                  style: TextButton.styleFrom(foregroundColor: Colors.orange),
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _buildStepIndicator() {
    return Row(
      children: [
        _buildStepItem(
          step: ScanStep.site,
          title: '扫描库位',
          icon: Icons.location_on,
          isActive: widget.currentScanStep == ScanStep.site,
          isCompleted: widget.currentSiteCode != null,
        ),
        _buildStepConnector(isCompleted: widget.currentSiteCode != null),
        _buildStepItem(
          step: ScanStep.material,
          title: '扫描物料',
          icon: Icons.qr_code,
          isActive: widget.currentScanStep == ScanStep.material,
          isCompleted: widget.currentBarcodeContent != null,
        ),
        _buildStepConnector(isCompleted: widget.currentBarcodeContent != null),
        _buildStepItem(
          step: ScanStep.quantity,
          title: '确认数量',
          icon: Icons.confirmation_number,
          isActive: widget.currentScanStep == ScanStep.quantity,
          isCompleted: false,
        ),
      ],
    );
  }

  Widget _buildStepItem({
    required ScanStep step,
    required String title,
    required IconData icon,
    required bool isActive,
    required bool isCompleted,
  }) {
    Color color;
    if (isCompleted) {
      color = Colors.green;
    } else if (isActive) {
      color = Colors.blue;
    } else {
      color = Colors.grey;
    }

    return Expanded(
      child: Column(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isCompleted
                  ? Colors.green
                  : (isActive ? Colors.blue : Colors.grey[300]),
              shape: BoxShape.circle,
            ),
            child: Icon(
              isCompleted ? Icons.check : icon,
              color: isCompleted || isActive ? Colors.white : Colors.grey[600],
              size: 20,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            title,
            style: TextStyle(
              fontSize: 12,
              color: color,
              fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildStepConnector({required bool isCompleted}) {
    return Container(
      width: 30,
      height: 2,
      color: isCompleted ? Colors.green : Colors.grey[300],
      margin: const EdgeInsets.only(bottom: 20),
    );
  }

  Widget _buildCurrentStepContent() {
    switch (widget.currentScanStep) {
      case ScanStep.site:
        return _buildScanSiteContent();
      case ScanStep.material:
        return _buildScanMaterialContent();
      case ScanStep.quantity:
        return _buildQuantityContent();
    }
  }

  Widget _buildScanSiteContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '请扫描库位条码',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _scanController,
          focusNode: _scanFocusNode,
          decoration: const InputDecoration(
            hintText: '请扫描或输入库位编号',
            prefixIcon: Icon(Icons.location_on),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              widget.onScanCode(value);
            }
          },
        ),
        if (widget.currentSiteCode != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.green[50],
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  const Icon(Icons.check_circle, color: Colors.green),
                  const SizedBox(width: 8),
                  Text(
                    '库位: ${widget.currentSiteCode}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildScanMaterialContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '请扫描物料二维码',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: _scanController,
          focusNode: _scanFocusNode,
          decoration: const InputDecoration(
            hintText: '请扫描物料二维码',
            prefixIcon: Icon(Icons.qr_code),
            border: OutlineInputBorder(),
          ),
          onSubmitted: (value) {
            if (value.isNotEmpty) {
              widget.onScanCode(value);
            }
          },
        ),
        if (widget.currentBarcodeContent != null)
          Padding(
            padding: const EdgeInsets.only(top: 8),
            child: Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue[50],
                border: Border.all(color: Colors.blue),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(Icons.check_circle, color: Colors.blue),
                      const SizedBox(width: 8),
                      const Text(
                        '物料信息',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text('物料编码: ${widget.currentBarcodeContent!.matCode}'),
                  if (widget.currentBarcodeContent!.batchNo != null)
                    Text('批次号: ${widget.currentBarcodeContent!.batchNo}'),
                  if (widget.currentBarcodeContent!.sn != null)
                    Text('序列号: ${widget.currentBarcodeContent!.sn}'),
                ],
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildQuantityContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          '请输入采集数量',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),

        // 库存信息
        if (widget.currentInventory != null)
          Container(
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.orange[50],
              border: Border.all(color: Colors.orange),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  '库存信息',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 4),
                // Text('可用库存: ${widget.currentInventory!.availableQty}'),
                // Text('总库存: ${widget.currentInventory!.totalQty}'),
                Text('可用库存: '),
                Text('总库存: '),
              ],
            ),
          ),

        // 数量输入
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: _quantityController,
                focusNode: _quantityFocusNode,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                decoration: const InputDecoration(
                  hintText: '请输入数量',
                  prefixIcon: Icon(Icons.confirmation_number),
                  border: OutlineInputBorder(),
                ),
                onSubmitted: (value) {
                  _confirmQuantity();
                },
              ),
            ),
            const SizedBox(width: 12),
            ElevatedButton(
              onPressed: _confirmQuantity,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              child: const Text('确认'),
            ),
          ],
        ),
      ],
    );
  }

  void _confirmQuantity() {
    final quantityText = _quantityController.text.trim();
    if (quantityText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入数量'), backgroundColor: Colors.red),
      );
      return;
    }

    final quantity = int.tryParse(quantityText);
    if (quantity == null || quantity <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('请输入有效的数量'), backgroundColor: Colors.red),
      );
      return;
    }

    widget.onConfirmQuantity(quantity);
  }
}
