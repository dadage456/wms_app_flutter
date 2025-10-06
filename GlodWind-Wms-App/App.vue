<!--本文件由FirstUI授权予赵*河（会员ID：29  2 8，身份证尾号：   0  44013）专用，请尊重知识产权，勿私下传播，违者追究法律责任。-->
<script>
export default {
	onLaunch: function () {
		// #ifdef APP-PLUS
		//锁定屏幕
		plus.screen.lockOrientation('portrait-primary');
		const dom = weex.requireModule('dom');
		dom.addRule('fontFace', {
			fontFamily: 'graceIconfont',
			src: "url('/static/grace.ttf')"
		});
		// #endif
		console.log('App Launch');
		plus.push.addEventListener(
			'click',
			(msg) => {
				setTimeout(function () {
					uni.navigateTo({
						url: 'pages/exceptColl/pdacollExcept'
					});
				}, 1000);
			},
			false
		);
		//监听在线消息事件
		plus.push.addEventListener(
			'receive',
			(msg) => {
				setTimeout(() => {
					//如果是在线收到推送消息，需要创建一条推送  cover: false 是否覆盖上一条推送消息
					if (msg.type == 'receive') {
						var options = { cover: false, title: msg.payload.title };
						let url = 'pages/exceptColl/pdacollExcept';
						plus.push.createMessage(msg.payload.content, url, options); //创建一条推送消息
					}
				}, 2500);
			},
			false
		);
	},
	onShow: function () {
		console.log('App Show');
	},
	onHide: function () {
		console.log('App Hide');
	}
};
</script>

<style>
/*每个页面公共css */
@import './common/fui-app.css';
/* #ifndef APP-NVUE */
@import './components/firstui/fui-theme/fui-theme.css';
/* #endif */

/* 加载框架核心样式 */
@import './GraceUI5/css/graceUI.css';
/* 加载主题样式 */
@import './GraceUI5/skin/black.css';
/* 加载图标字体 - 条件编译模式 */
/* #ifdef APP-NVUE */
.gui-icons {
	font-family: graceIconfont;
}
/* #endif */
</style>
