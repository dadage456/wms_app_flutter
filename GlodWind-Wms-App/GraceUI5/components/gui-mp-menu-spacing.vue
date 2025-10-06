<template>
	<view class="gui-wx-menu-spacing" :style="{width:width+'px'}"></view>
</template>
<script>
export default{
	name  : "gui-mp-menu-spacing",
	props : {},
	data() {
		return {
			width: 0
		}
	},
	created:function(){
		// #ifdef MP
			// #ifndef MP-ALIPAY
			let system         = uni.getSystemInfoSync();
			let menuButtonInfo = uni.getMenuButtonBoundingClientRect();
			this.width         = menuButtonInfo.width + (system.screenWidth - menuButtonInfo.right);
			// #endif
		// #endif
	}
}
</script>
<style scoped>
.gui-wx-menu-spacing{width:80px; height:20px;}
</style>
