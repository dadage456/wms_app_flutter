<template>
	<view style="margin-top:50rpx; ">
		<view>
			<text class="gui-h6 demo-desc-title">{{title}}</text>
		</view>
		<view class="gui-margin-top gui-bg-gray demo-desc-content gui-border-radius">
			<text class="gui-text">{{desc}}</text>
		</view>
	</view>
</template>
<script>
export default{
	props:{
		title:{type:String, default:'演示说明'},
		desc:{type:String, default:''}
	}
}
</script>
<style>
.demo-desc-title{color:rgba(69, 90, 100, 0.6); line-height:50rpx;}
.demo-desc-content{padding:20rpx;}
</style>