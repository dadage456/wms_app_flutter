<template>
	<view class="gui-sg-slider" 
	@touchstart="touchstart" 
	@touchmove.stop.prevent="touchmove" 
	@touchend="touchend" 
	ref="gracesgslider" 
	id="gracesgslider" 
	:style="{height:barHeight+'rpx'}">
		<view class="gui-sg-slider-line" 
		:style="{
			height:bglineSize+'rpx', backgroundColor:bglineColor, 
			marginTop:((barHeight - bglineSize) / 2)+'rpx', 
			borderRadius:borderRadius}"></view>
		<view class="gui-sg-slider-a-line" 
		:style="{
			width:(left+25)+'px', 
			top:((barHeight - bglineSize) / 2)+'rpx', 
			backgroundColor:bglineAColor, 
			height:bglineSize+'rpx', 
			borderRadius:borderRadius}"></view>
		<text class="gui-sg-slider-bar gui-block-text"
		:style="{
			width:barWidth+'rpx', height:barHeight+'rpx', 
			'line-height':barHeight+'rpx', 
			backgroundImage:barBgColor, 
			color:barColor, left:left+'px', 
			fontSize:barTextSize, 
			borderRadius:borderRadius}">{{barText}}</text>
	</view>
</template>
<script>
// #ifdef APP-NVUE
const dom = weex.requireModule('dom');
// #endif
export default{
	name  : "gui-single-slider",
	props : {
		barHeight    : {type:Number,  default:32},
		barWidth     : {type:Number,  default:168},
		barColor     : {type:String,  default:'#FFFFFF'},
		barBgColor   : {type:String,  default:'linear-gradient(to right, #3688FF,#3688FF)'},
		bglineSize   : {type:Number,  default:2},
		bglineColor  : {type:String,  default:'rgba(54,136,255,0.5)'},
		bglineAColor : {type:String,  default:'#3688FF'},
		barText      : {type:String,  default:''},
		barTextSize  : {type:String,  default:'20rpx'},
		borderRadius : {type:String,  default:'32rpx'},
		canSlide     : {type:Boolean, default:true}
	},
	data() {
		return {
			left       : 0,
			startLeft  : 0,
			width      : 0,
			barWidthPX : 30
		}
	},
	mounted:function(){
		this.init();
	},
	methods:{
		init : function(){
			// #ifdef APP-NVUE
			var el = this.$refs.gracesgslider;
			dom.getComponentRect(el, (res) => {
				if(!res.result || res.size.width < 10){
					setTimeout(()=>{this.init();}, 100);
					return;
				}
				this.startLeft  = res.size.left;
				this.width      = res.size.width;
				this.barWidthPX = uni.upx2px(this.barWidth);
			});
			// #endif
			// #ifndef APP-NVUE
			uni.createSelectorQuery().in(this).select('#gracesgslider').fields(
				{size: true, rect:true}, (res) => {
					if(res == null){
						setTimeout(()=>{this.init();}, 100);
						return;
					}
					this.startLeft  = res.left;
					this.width      = res.width;
					this.barWidthPX = uni.upx2px(this.barWidth);
				}
			).exec();
			// #endif
		},
		touchstart : function (e) {
			if(!this.canSlide){return ;}
			var touch = e.touches[0] || e.changedTouches[0];
			this.changeBar(touch.pageX);
		},
		touchmove : function (e) {
			if(!this.canSlide){return ;}
			var touch = e.touches[0] || e.changedTouches[0];
			this.changeBar(touch.pageX);
		},
		touchend : function (e) {
			if(!this.canSlide){return ;}
			var touch = e.touches[0] || e.changedTouches[0];
			this.changeBar(touch.pageX, true);
		},
		changeBar : function(x){
			var left = x - this.startLeft;
			if(left <= 0){
				this.left = 0;
				this.$emit('change', 0);
			}else if(left + this.barWidthPX > this.width){
				left = this.width - this.barWidthPX;
				this.left = left;
				this.$emit('change', 100);
			}else{
				this.left = left;
				var scale = this.left / (this.width - this.barWidthPX);
				this.$emit('change', Math.round(scale * 100));
			}
		},
		setProgress : function (value){
			if(this.width < 1){ setTimeout(()=>{this.setProgress(value), 300}); return ;}
			if(value < 0){value = 0;}
			if(value > 100){value = 100;}
			this.left = ( value / 100 ) * (this.width - this.barWidthPX);
		}
	}
}
</script>
<style scoped>
.gui-sg-slider{overflow:hidden; position:relative;}
.gui-sg-slider-a-line{position:absolute; left:0; top:0;}
.gui-sg-slider-bar{position:absolute; left:0; top:0; border-radius:50rpx; font-size:20rpx; text-align:center; color:#323232; overflow:hidden;}
</style>