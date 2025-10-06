<template name="gui-im-input">
	<view>
		<view class="gui-im-footer" 
		:style="{paddingBottom:paddingB}">
			<view class="gui-im-menus graceIMFonts icon-voice" 
			hover-class="gui-tap" v-if="voiceBtnShow" 
			@tap="showRec"></view>
			<view class="gui-im-menus graceIMFonts icon-photograph" 
			 hover-class="gui-tap" 
			@tap="chooseImg"></view>
			<view class="gui-im-input">
				<textarea type="text" 
				v-model="inputMsg" 
				:fixed="true" 
				@confirm="sendTextMsg" 
				:cursor-spacing="35"></textarea>
			</view>
			<view class="gui-items" 
			style="padding:0 12rpx; margin-right:10rpx;" 
			hover-class="gui-tap" @tap="sendTextMsg">发送</view>
		</view>
		<!-- 语音输入 -->
		<view class="gui-im-record" v-if="recShow">
			<view class="gui-im-record-txt">
				{{recTxt}}<text v-if="recing">已录音 : {{recLength}} s</text>
			</view>
			<view class="gui-im-record-btn" 
			@tap="rec" :class="[recing ? 'gui-im-recording' : '']"></view>
			<view class="gui-im-send-voice" 
			v-if="tmpVoice != ''">
				<text @tap="sendVoiceMsg">发送语音</text>
			</view>
			<view class="gui-im-record-close graceIMFonts icon-close" 
			@tap="closeRec" v-if="!recing"></view>
		</view>
	</view>
</template>
<script>
var bgAudioMannager = uni.getBackgroundAudioManager();
export default {
	name  : "gui-im-input",
	props : { },
	data() {
		return {
			paddingB        : '0',
			uploading       : false,
			recShow         : false,
			recTxt          : "请点击绿色按钮开始录音",
			inputMsg        : "",
			recorderManager : null,
			recing          : false,
			recLength       : 1,
			recTimer        : null,
			tmpVoice        : '',
			voiceLen        : 0,
			voiceBtnShow    : false,
			// 播放相关
			player          : null,
			playTxt         : "试听语音"
		}
	},
	created : function(){
		// #ifndef H5
		this.voiceBtnShow    = true;
		this.recorderManager = uni.getRecorderManager();
		this.recorderManager.onStop((res) => {
			this.tmpVoice    = res.tempFilePath;
			this.recing      = false;
			this.recTxt       =  "... 已录音 "+this.recLength+
			"s, 点击绿色按钮重新录音 ...";
			clearInterval(this.recTimer);
		});
		this.recorderManager.onError(() => {
			uni.showToast({ title: '录音失败', icon: 'none' });
			this.recing = false;
			this.recTxt   = "请点击绿色按钮开始录音",
			clearInterval(this.recTimer);
		});
		// #endif
		// #ifdef MP
		try {
		    var res = uni.getSystemInfoSync();
			res.model = res.model.replace(' ', '');
			res.model = res.model.toLowerCase();
			var res1  = res.model.indexOf('iphonex');
			if(res1 > 5){res1 = -1;}
			var res2   = res.model.indexOf('iphone1');
			if(res2 > 5){res2 = -1;}
			if(res1 != -1 || res2 != -1){
				this.paddingB = uni.upx2px(50)+'px';
			}
		} catch (e){return null;}
		// #endif
	},
	methods:{
		// 录音
		rec : function(){
			if (this.recing){
				this.recorderManager.stop();
				this.recing = false;
				this.recTxt   =  "... 已录音 "+this.recLength
				+"s, 点击绿色按钮重新录音 ...";
				clearInterval(this.recTimer);
			} else {
				this.recorderManager.start({duration:60000, format:'mp3' });
				this.recing     = true;
				this.recTxt     =  "... 正在录音 ...";
				this.recLength  = 1;
				this.recTimer   = setInterval(()=>{this.recLength++;}, 1000);
			}
		},
		// 发送录音
		sendVoiceMsg : function(){
			if (this.tmpVoice == '') {
				uni.showToast({ title: "请先录制一段语音", icon: "none" });
				return;
			}
			// 关闭界面
			this.recShow = false;
			this.$emit('sendVoice', this.tmpVoice, this.recLength);
			this.tmpVoice  = '';
			this.recLength = 0;
			this.recTxt    = "请点击绿色按钮开始录音";
		},
		// 展示录音界面
		showRec : function(){this.recShow  = true;},
		// 关闭录音界面
		closeRec: function (){this.recShow = false;},
		// 发送文本消息
		sendTextMsg: function () {
			if (this.inputMsg < 1) {return false;}
			this.$emit('sendText', this.inputMsg);
			this.inputMsg = '';
		},
		// 选择图片
		chooseImg : function(){
			uni.chooseImage({
				count      : 1,
				sizeType   : ['compressed'],
				sourceType : ['album', 'camera'],
				success    : (res)=>{
					const tempFilePaths = res.tempFilePaths;
					this.$emit('chooseImage', tempFilePaths[0]);
				}
			});
		}
	}
}
</script>
<style scoped>
.gui-im-footer{background:#FFFFFF; width:100%; position:fixed; left:0; bottom:0; height:100rpx; display:flex; flex-wrap:nowrap; overflow:hidden; box-shadow:1px 1px 6px #999999; align-items:center;}
.gui-im-footer .gui-items{width:auto; line-height:88rpx; flex-shrink:0; font-size:28rpx; color:#2B2E3D;}
.gui-im-menus{width:80rpx; height:80rpx; flex-shrink:0; line-height:80rpx; text-align:center;}
.gui-im-input{width:600rpx; margin:10rpx; padding:10rpx 16rpx; background:#F4F5F6; border-radius:6rpx; height:60rpx;}
.gui-im-input textarea{width:100%; background:#F4F5F6; color:#2B2E3D; height:40rpx; line-height:40rpx; font-size:28rpx; margin-top:10rpx;}
.gui-im-record{width:100%; position:fixed; left:0; bottom:0; background:#FFFFFF; padding:30px 0; padding-bottom:100rpx; z-index:11; box-shadow:1px 1px 6px #999999;}
.gui-im-record-close{width:100rpx; height:100rpx; position:absolute; top:0px; right:0px; z-index:100; text-align:center; line-height:100rpx; color:#888888; font-size:38rpx !important;}
.gui-im-record-txt{text-align:center; font-size:26rpx; line-height:30px; padding-bottom:10px; color:#CCCCCC;}
.gui-im-record-btn{width:60px; height:60px; margin:0 auto; border:5px solid #F1F2F3; border-radius:100%; background:#00B26A;}
.gui-im-recording{background:#FF0000; animation:fade linear 2s infinite;}
@keyframes fade{from{opacity:0.1;} 50%{opacity:1;} to{opacity:0.1;}}
.gui-im-record-txt text{color:#00B26A; padding:0 12px;}
.gui-im-send-voice{margin-top:12px; font-size:28rpx; color:#00BA62; text-align:center;}
.gui-im-send-voice text{margin:0 15px; color:#00BA62;}

@font-face{font-family:"graceIMFonts"; src:url('data:font/truetype;charset=utf-8;base64,d09GMgABAAAAAASoAAsAAAAACpAAAARbAAEAAAAAAAAAAAAAAAAAAAAAAAAAAAAAHEIGVgCDMgqILIZ4ATYCJAMUCwwABCAFhG0HSxsHCcgOJQUABgUAAMBk8EB6fW8yk/3Z7Cd4BLPXQW6vA9B99wc4f67lvzL5jC8R2YVkAS+XAsN4QPB1pPqF+wfHUj8K/8Hyvu1BXjGyLDq25lGBDagb1ySRuNkEfcvRGr5iXEVcDQGYRBOJS2OXykbwRoFqQYpmTZc48HZYUBEkgaF3BBypENvQMbT12hNgq/b24g35wgANXYLX6jelSITc52EvKqRlDzJKWljFuYDbcSCBTAAFYkGgZxZuhipT05hBv+dOLYCJgYb2POx50vPyFxW2DZaiQzqT/8MDDYlCgHCAGk+KrY0reB4m8aDB8yQeJDwv50HBiwrZtGh0ur0JhAGiEhCdYIisoERHonui2lcmOM2zJHp7m6a+suXpoNZng9tfDG17vkyohugi+3dbns4wdwWyFuTaGyL2DH1o+v/RweMTg2Y6LqngIEk2qXNSr6zPX9naOrilZVBb25D29qFN+/Nh99riT7Z3vdsad6xlyKkr1tWNZ09eGz6kkbRWS7iliav7hBVp1hm64Q4O3rMhcFCzzBa4ywoa3MgWtHtjyNAmVUhYR3kdd6O7DasHDfpeN2jwb7vbQFjoV6Fa7o6VK9v0qChdVrZdRURhRbwW3rqlUHWLS5mMreMeM3nRSDO2TbYUy16uGosg002pTpZwphre5b7iZKa3S1VPqnNboCS+PE4Hmd9c9SJ2Lk+1zG3JjnAsPmH0XBpvDWJl+WX186e6zIWKSG6z0np0qthYRZSdTEQULL34fb9uJZ66RKiru0eP4K4lSXcWecR/xPf20/WbFi0Bz/8qJrcUz0VLHq9jd7SqyEjVyoWKSFZYZV4TL99QQihCuiGEghgP3sLyqYFyCAlv/7hDnEsCyWXFCOnjZkAVINnlhrLtTEJFJEusvRjRsGVZpxpGRH+psDBFlC1MRCRsj0k9bjZvPtcjYrOpiXamCVUROssu7hLWO2VNhdl5+yxFRU/Z8/pcBwNGkpu2yNAKAPaY/CNXAvak/CmXAfaM/CYXH8o/w6M7d+aODar8ZrgUAB2fJ5zRauxBhbTgeNSSWHrgShOOqa8crbp6d0qSt09n10Gh0T6LTOBwDfjzrxh7EEUmBAZBFmh4EAUSg0SkwmaCjotCcGBQAyYZlBzvIgCKG0I5gXTGAAS+nIKGN9dB4ssnUmH/QCeY/+DAV0gwGSICzugiWUw3GxZgjmER8V1IESyTCDvz1YvrsdSmc9Qu18jNmDqVIIrLznUnS7CJaRH7ONuleMYIItQyUDFcD+u6hWxqqVhg0TJjdnpMzpSgJ4oWLAN8aYCC4WBgRBA8XSAUBCxMiLIww9fz+vVgJNrQ4aARXT/8zWAoTpTVI+KIJjYBskRjJuralEon7UjEw2iEgCC3QgsDRDF1YXQes0DYwZupYAQY0cgZIjbpxNDJSFJNdPU6Yx5LT5ueeAZdaEIKJXThwGPGdM60RcRz0WJbUY1TF8sb8IrH8sVdigkAAA==') format('truetype');}
.graceIMFonts{font-family:"graceIMFonts" !important; font-style:normal; color:#2B2E3D; font-size:56rpx;}
.icon-voice:before{content:"\e63a";}
.icon-photograph:before{content:"\e619";}
.icon-close:before{content:"\e625";}
.icon-kbd{content:"\e73b";}
</style>