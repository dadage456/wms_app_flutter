<template>
	<view class="gui-banner">
		<image 
		:src="img" 
		mode="aspectFill" class="gui-banner-img"></image>
		<view class="gui-banner-in gui-flex gui-columns gui-justify-content-center">
			<text class="gui-block-text gui-h3 gui-color-white gui-bold gui-text-center">{{title}}</text>
			<text class="gui-block-text gui-text-small gui-color-white gui-text-center" style="margin-top:8rpx;">{{desc}}</text>
		</view>
	</view>
</template>
<script>
export default{
	name  : "gui-demo-banner",
	props : {
		title:{type:String, default:''},
		img:{type:String, default:''},
		desc:{type:String, default:'漂亮 丰富 高效的跨平台 UI 框架'}
	}
}
</script>
<style scoped>
.gui-banner{height:228rpx; border-radius:10rpx; font-size:0; position:relative; margin-top:15rpx;}
.gui-banner-img{width:690rpx; height:228rpx; border-radius:10rpx; opacity:0.92;}
.gui-banner-in{height:228rpx; border-radius:10rpx; position:absolute; z-index:1; left:0; top:0;}
.gui-h3{font-size:38rpx;}
.gui-text-center{width:690rpx;}
</style>