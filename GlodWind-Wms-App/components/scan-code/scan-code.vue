<template>
	<view class="content"></view>
</template>

<script>
export default {
	data() {
		return {
			activity: null,
			receiver: null,
			intentFilter: null
		};
	},
	created: function (option) {
		this.initScan();
		this.startScan();
	},
	onHide: function () {
		this.stopScan();
	},
	destroyed: function () {
		//页面退出时一定要卸载监听,否则下次进来时会重复，造成扫一次出2个以上的结果/
		this.stopScan();
	},
	methods: {
		initScan() {
			let _this = this;
			this.activity = plus.android.runtimeMainActivity(); //获取activity
			var IntentFilter = plus.android.importClass('android.content.IntentFilter');
			this.intentFilter = new IntentFilter();
			this.intentFilter.addAction('com.scanner.broadcast'); // 换你的广播动作
			this.receiver = plus.android.implements('io.dcloud.feature.internal.reflect.BroadcastReceiver', {
				onReceive: function (context, intent) {
					console.log('intent', intent);
					plus.android.importClass(intent);
					let content = intent.getStringExtra('data'); // 换你的广播标签

					uni.$emit('scancodedate', content);

					_this.queryCode(code);
				}
			});
		},
		startScan() {
			this.activity.registerReceiver(this.receiver, this.intentFilter);
		},
		stopScan() {
			this.activity.unregisterReceiver(this.receiver);
		},
		queryCode: function (code) {
			//防重复
			if (_codeQueryTag) return false;
			_codeQueryTag = true;
			setTimeout(function () {
				_codeQueryTag = false;
			}, 150);
			var id = code;
			console.log('id:', id);
			uni.$emit('scancodedate', {
				code: id
			});
		}
	}
};
</script>

<style></style>
