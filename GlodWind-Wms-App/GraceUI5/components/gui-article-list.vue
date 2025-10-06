<template>
	<view class="gui-article-list">
		<view class="gui-article-list-item" hover-class="gui-tap" 
		:style="itemStyle" 
		v-for="(item, index) in articles" :key="index" 
		@tap="newstap(item.id)">
			<view>
				<text class="gui-article-list-title gui-block-text" 
				:style="titleStyle">{{item.title}}</text>
			</view>
			<view class="gui-article-list-img1" 
			v-if="item.imgs.length == 1">
				<gui-image :src="item.imgs[0]" :width="440" :height="280"></gui-image>
			</view>
			<view class="gui-flex gui-rows gui-nowrap gui-space-between" 
			v-if="item.imgs.length == 2">
				<view class="gui-article-list-img2-in">
					<gui-image :src="item.imgs[0]" :width="335" :height="200"></gui-image>
				</view>
				<view class="gui-article-list-img2-in">
					<gui-image :src="item.imgs[1]" :width="335" :height="200"></gui-image>
				</view>
			</view>
			<view class="gui-flex gui-rows gui-nowrap gui-space-between" 
			v-if="item.imgs.length >= 3">
				<view class="gui-article-list-img3-in">
					<gui-image :src="item.imgs[0]" :width="220" :height="150"></gui-image>
				</view>
				<view class="gui-article-list-img3-in">
					<gui-image :src="item.imgs[1]" :width="220" :height="150"></gui-image>
				</view>
				<view class="gui-article-list-img3-in">
					<gui-image :src="item.imgs[2]" :width="220" :height="150"></gui-image>
				</view>
			</view>
			<view class="gui-article-list-footer gui-flex gui-rows gui-space-between gui-align-items-center">
				<text class="gui-article-list-footer-items gui-ellipsis gui-color-gray gui-block-text gui-icons">&#xe69e; {{item.author}}</text>
				<text class="gui-article-list-footer-items gui-ellipsis gui-color-gray gui-block-text gui-icons gui-text-center">&#xe609; {{item.views}}</text>
				<text class="gui-article-list-footer-items gui-ellipsis gui-color-gray gui-block-text gui-icons gui-text-right">&#xe64c; {{item.createTime}}</text>
			</view>
		</view>
	</view>
</template>
<script>
export default{
	name  : "gui-article-list",
	props : {
		articles   : { type : Array , default : function(){return [];}},
		titleStyle : { type : String, default : 'lineHeight:44rpx;font-size:32rpx;color:#2B2E3D;'},
		itemStyle  : { type : String, default : 'background-color:#FFFFFF;'}
	},
	methods : {
		newstap : function(id){
			this.$emit('newstap', id);
		}
	}
}
</script>
<style scoped>
.gui-article-list{}
.gui-article-list-item{margin-bottom:30rpx; padding:20rpx 30rpx;}
.gui-article-list-title{overflow:hidden;}
.gui-article-list-img1{margin-top:22rpx;}
.gui-article-list-img2-in{width:335rpx; height:200rpx; margin-top:22rpx;}
.gui-article-list-img3-in{width:220rpx; height:150rpx; margin-top:22rpx;}
.gui-article-list-footer{margin-top:20rpx;}
.gui-article-list-footer-items{width:220rpx; height:50rpx; line-height:50rpx; font-size:26rpx; overflow:hidden;}
</style>