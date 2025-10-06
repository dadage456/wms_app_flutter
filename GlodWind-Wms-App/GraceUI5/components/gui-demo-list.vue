<template>
	<view>
		<view class="demo-list"
		v-for="(item, idx) in pageList" :key="idx">
			<view class="gui-flex gui-rows">
				<text class="demo-title gui-color-gray gui-h5">{{item.title}}</text>
				<text class="gui-text-small gui-text-small-ml gui-color-gray">{{item.desc}}</text>
			</view>
			<navigator class="demo-list-cell gui-flex gui-rows gui-space-between gui-bg-gray gui-border-radius" 
			v-for="(nav, index) in item.pages" :key="index" :url="nav[1]">
				<text class="demo-list-cell-title">{{(index+1)}}. {{nav[0]}}</text>
				<text class="demo-list-cell-arrow gui-icons gui-color-gray-light">&#xe601;</text>
			</navigator>
		</view>
	</view>
</template>
<script>
export default{
	props:{
		pageList:{type:Array, default:function(){return [];}}
	}
}
</script>
<style scoped>
.demo-list{margin-top:60rpx;}
.demo-title{line-height:50rpx;}
.demo-list-cell{padding-left:25rpx; padding-right:20rpx; padding-top:20rpx; padding-bottom:20rpx; margin-top:25rpx;}
.demo-list-cell-title{line-height:50rpx; font-size:26rpx;}
.demo-list-cell-arrow{line-height:50rpx; font-size:36rpx;}
.gui-text-small-ml{margin-left:20rpx; margin-top:8rpx; line-height:38rpx;}
</style>