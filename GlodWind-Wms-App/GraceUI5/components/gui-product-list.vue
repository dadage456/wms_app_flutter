<template>
	<view class="gui-flex gui-rows gui-wrap gui-space-between">
		<view class="gui-product" hover-class="gui-tap" 
		v-for="(item, index) in products" :key="index" 
		@tap="gotoInfo(index, item)"
		:style="{
			width  : (375 - margin*2)+'rpx',
			marginLeft  : margin+'rpx',
			marginRight : margin+'rpx'}">
			<view>
				<gui-image :src="item.img" :width="(375 - margin*2)" :height="imgHeight"></gui-image>
			</view>
			<view class="gui-product-lines">
				<text class="gui-product-name">{{item.name}}</text>
			</view>
			<view class="gui-product-lines gui-flex gui-rows gui-nowrap gui-align-items-center">
				<text class="gui-color-red gui-text-small">￥</text>
				<text class="gui-h5 gui-color-red">{{item.price}}</text>
				<text class="gui-text-small gui-color-gray gui-line-through gui-price-margin">{{item.priceMarket}}</text>
				<text class="gui-text-small gui-color-gray gui-price-margin">{{item.selledNum}}人购买</text>
			</view>
		</view>
	</view>
</template>
<script>
export default{
	name  : "gui-product-list",
	props : {
		products    : {type : Array,  default : function(){return [];}},
		margin      : {type : Number, default : 15},
		imgHeight   : {type : Number, default : 345},
	},
	methods:{
		gotoInfo : function (idx, item) {
			this.$emit('gotoInfo', idx, item);
		}
	}
}
</script>
<style>
.gui-product{margin-bottom:38rpx;}
.gui-product-lines{margin-top:10rpx;}
.gui-product-name{font-size:26rpx; line-height:32rpx;}
.gui-price-margin{margin:0 10rpx;}
</style>
