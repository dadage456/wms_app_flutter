<template name="graceSpread">
	<view class="gui-spread" 
	:class="[isShrink ? 'gui-transition-all' : '']" 
	:style="{height:reHeight}">
		<view :style="{paddingBottom: !isBtn && isShrink ? '80rpx' : '0rpx'}">
			<slot></slot>
		</view>
		<text v-if="isBtn" @tap="spreadContent" 
		:style="{color:btnColor, fontSize:btnTxtSize, zIndex:zIndex, width:width}"
		class="gui-icons gui-block-text gui-spread-btn">&#xe69d; {{btnTxt}}</text>
		
		<text v-if="!isBtn && isShrink" @tap="shrinkContent" 
		:style="{color:btnColor, fontSize:btnTxtSize, zIndex:zIndex, width:width}"
		class="gui-icons gui-block-text gui-spread-btn">&#xe638; {{shrinkBtnTxt}}</text>
	</view>
</template>
<script>
export default {
	name  : "gui-spread",
	props : {
		width       : { type : String, default : "690rpx" },
		height      : { type : String, default : "600rpx" },
		btnTxt      : { type : String, default : "展开阅读全文" },
		btnColor    : { type : String, default : "#999999" },
		btnTxtSize  : { type : String, default : "28rpx" },
		zIndex      : { type : Number, default : 1 },
		isShrink    : { type : Boolean,default : false},
		shrinkBtnTxt: { type : String, default : "收缩文章"}
	},
	data() {
		return {
			reHeight: "600px",
			isBtn : true
		}
	},
	created:function(){
		this.reHeight = this.height;
	},
	methods: {
		spreadContent : function () {
			// #ifdef MP-BAIDU
			this.reHeight = '';
			// #endif
			// #ifndef MP-BAIDU
			this.reHeight = 'auto';
			// #endif
			// #ifdef APP-NVUE
			this.reHeight = '';
			// #endif
			this.isBtn    = false;
		},
		shrinkContent : function () {
			this.reHeight = this.height;
			this.isBtn    = true;
		}
	},
}
</script>
<style scoped>
.gui-spread{overflow:hidden; position:relative;}
.gui-spread-btn{height:80rpx; line-height:80rpx; background-color:rgba(255,255,255,0.9); position:absolute; z-index:999999; left:0; bottom:0; text-align:center;}
</style>
