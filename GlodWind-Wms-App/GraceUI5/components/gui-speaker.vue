<template>
	<view class="gui-flex gui-rows gui-nowrap gui-align-items-center">
		<view>
			<slot name="icon"></slot>
		</view>
		<view class="gui-flex1">
			<swiper :style="styles"
			:vertical="vertical" @change="change" autoplay="true" :circular="true" 
			:interval="interval" :current="current" class="gui-speaker-in">
				<swiper-item  
				v-for="(item, index) in items" :key="index">
					<navigator :style="styles" 
					:url="item.url" :open-type="item.opentype">
						<text :style="styles" 
						class="gui-block-text gui-ellipsis">{{item.title}}</text>
					</navigator>
				</swiper-item>
			</swiper>
		</view>
	</view>
</template>
<script>
export default{
	name  : "gui-speaker",
	props : {
		items     : {type:Array, default:function () {return [];}},
		current   : {type:Number, default:0},
		vertical  : {type:Boolean, default:false},
		interval  : {type:Number, default:5000},
		styles    : {type:String, default:'overflow:hidden; height:60rpx; line-height:60rpx; font-size:28rpx;'}
	},
	data() {
		return {
		}
	},
	methods:{
		change:function (index) {
			this.$emit('change', index.detail.current);
		}
	}
}
</script>
<style scoped>
</style>