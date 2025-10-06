<template>
	<view class="graceSlideToUnlock gui-border-box" 
	:style="{
	backgroundColor:bgColor, width:width+'rpx', 
	padding:padding+'rpx', height:(size+padding*2)+'rpx'
	}">
		<text class="graceSlideToUnlock-text gui-block-text gui-icons" 
		:class="[moving?'gui-fade':'']" 
		:style="{
			width:(width - padding* 2) +'rpx', 
			lineHeight:size+'rpx', 
			color:disabled?blockActiveColor:'#898989',
			top : padding+'rpx'}">{{disabled?msgUnlock:msg}} &#xe601;&#xe601;</text>
		<movable-area class="movable-area" 
		:style="{
			width:(width - padding* 2) +'rpx', 
			height:size+'rpx', borderRadius:borderRadius,
			top : padding+'rpx'}">
			<movable-view direction="horizontal" 
			@change="change" :x="moveX" :disabled="disabled" 
			:style="{width:size+'rpx', height:size+'rpx'}">
				<text class="graceSlideToUnlock-block gui-icons gui-block-text gui-color-white" 
				v-if="!disabled" 
				:style="{
					backgroundColor:disabled ? blockActiveColor : blockColor, 
					borderRadius:borderRadius, width:size+'rpx', height:size+'rpx', 
					lineHeight:size+'rpx', color:iconColor, fontSize:iconSize}">&#xe641;</text>
				<text class="graceSlideToUnlock-block gui-icons gui-block-text gui-color-white" 
				v-if="disabled" :style="{
					backgroundColor:disabled ? blockActiveColor : blockColor, 
					borderRadius:borderRadius, width:size+'rpx', height:size+'rpx', 
					lineHeight:size+'rpx', color:iconColor, fontSize:iconSize}">&#xe86a;</text>
			</movable-view>
		</movable-area>
	</view>
</template>
<script>
export default{
	name  : "gui-slide-to-unlock",
	props : {
		width            : {type : Number, default:690 },
		padding          : {type : Number, default:6},
		size             : {type : Number, default:68},
		bgColor          : {type : String, default:'#F6F7F8'},
		blockColor       : {type : String, default:'#008AFF'},
		blockActiveColor : {type : String, default:'#39B55A'},
		iconSize         : {type : String, default:'30rpx'},
		iconColor        : {type : String, default:'#FFFFFF'},
		borderRadius     : {type : String, default:'6rpx'},
		msg              : {type : String, default:'请向右滑动滑块解锁'},
		msgUnlock        : {type : String, default:'解锁成功'}
	},
	data() {
		return {
			maxWidth  : 300,
			moveX     : 0,
			disabled  : false,
			locktimer : null,
			moving    : false
		}
	},
	created:function(){
		this.maxWidth = uni.upx2px(this.width - this.padding * 2 - this.size - 2);
		this.moveX    = uni.upx2px(this.padding); 
	},
	methods:{
		change:function(e){
			if(this.disabled){return ;}
			this.moving    = true;
			if(this.locktimer != null){clearTimeout(this.locktimer);}
			this.locktimer = setTimeout(() => {
				if(e.detail.x >= this.maxWidth){
					this.moveX    = this.width;
					this.disabled = true;
					this.moving   = false;
					this.$emit('unlock');
				}else{
					this.moveX = uni.upx2px(this.padding) + Math.random();
					this.moving   = false;
				}
			}, 300);
		}
	}
}
</script>
<style scoped>
.graceSlideToUnlock{position:relative;}
.movable-area{position:absolute; left:0; top:0; z-index:2;}
.graceSlideToUnlock-block{text-align:center; opacity:0.88;}
.graceSlideToUnlock-text{text-align:center; color:#FFFFFF; font-size:24rpx; position:absolute; left:0; top:0; z-index:1;}
/* #ifndef APP-NVUE */
@keyframes gui-fade{0%{opacity:1;} 50%{opacity:0;} 100%{opacity:1;}}
.gui-fade{animation:gui-fade 2s ease-in infinite;}
/* #endif */
</style>
