import {
	baseUrl
} from '@/common/config.js';

export default function AppUpdate() {
	const appleId = 2021004105638058
	let _this = this
	let platform = uni.getSystemInfoSync().platform
	//1. 获取当前版本号
	let curversion = 100;
	plus.runtime.getProperty(plus.runtime.appid, function(widgetInfo) {
		curversion = widgetInfo.version;
		console.log("当前版本", curversion);
	});


	uni.showModal({
		title: '紧急升级通知',
		content: '亲爱的用户，为了提供更好的使用体验与功能改进，我们进行了系统升级。请立即完成强制升级，否则将无法正常使用APP。感谢您的配合与支持！',
		confirmText: '立即更新',
		showCancel: false,
		success: function(res) {
			if (res.confirm) {
				uni.showToast({
					icon: 'none',
					mask: true,
					title: '有新的版本发布，程序已启动自动更新。',
					duration: 5000
				});
				//设置 最新版本apk的下载链接 这是固定的
				let downloadApkUrl = 'http://ashuai.work:10000/appSrc/pdd.apk'
				console.log(downloadApkUrl);
				plus.runtime.openURL(downloadApkUrl);
			}
		}
	})
})
}