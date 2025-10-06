<template>
	<view v-if="show">
		<!-- 居中 -->
		<view 
		class="gui-popup gui-flex gui-columns gui-justify-content-center gui-align-items-center" 
		:class="[out ? 'gui-fade-out' : 'gui-fade-in']" 
		ref="guipopup" 
		@tap.stop="closebysd" @touchmove.stop.prevent="stopfun" 
		:style="{
			backgroundColor:bgColor, 
			zIndex:zIndex, 
			top:top+'px',
			animationDuration:duration+'ms'
		}" 
		v-if="position == 'center'">
			<view class="gui-popup-content gui-popup-center"
			 @tap.stop="stopfun" ref="guiPopupCenter" 
			:class="[out ? 'gui-scale-out' : 'gui-scale-in']" 
			:style="{width:width, animationDuration:duration+'ms'}"><slot></slot></view>
		</view>
		<!-- 顶部 -->
		<view class="gui-popup gui-flex gui-columns" 
		:style="{
			backgroundColor:bgColor, 
			zIndex:zIndex, top:top+'px',
			animationDuration:duration+'ms'
		}" 
		v-if="position == 'top'" 
		:class="[out ? 'gui-fade-out' : 'gui-fade-in']" ref="guipopup" 
		@tap.stop="closebysd" @touchmove.stop.prevent="stopfun">
			<view 
			class="gui-popup-content gui-popup-top" 
			@tap.stop="stopfun" ref="guiPopupTop" 
			:class="[out ? 'gui-top-out' : 'gui-top-in']" 
			:style="{animationDuration:duration+'ms'}">
				<slot></slot>
			</view>
		</view>
		<!-- 底部 -->
		<view class="gui-popup gui-flex gui-columns gui-justify-content-end" 
		:style="{
			backgroundColor:bgColor, 
			zIndex:zIndex, 
			top:top+'px',
			animationDuration:duration+'ms'
		}" 
		v-if="position == 'bottom'" 
		:class="[out ? 'gui-fade-out' : 'gui-fade-in']" ref="guipopup" 
		@tap.stop="closebysd" @touchmove.stop.prevent="stopfun">
			<view 
			class="gui-popup-content gui-popup-bottom" 
			@tap.stop="stopfun" ref="guiPopupBottom" 
			:class="[out ? 'gui-bottom-out' : 'gui-bottom-in']" 
			:style="{animationDuration:duration+'ms'}">
				<slot></slot>
			</view>
		</view>
		<!-- 左侧 -->
		<view class="gui-popup gui-flex gui-columns" 
		v-if="position == 'left'"
		:class="[out ? 'gui-fade-out' : 'gui-fade-in']" 
		ref="guipopup" 
		@tap.stop="closebysd" @touchmove.stop.prevent="stopfun" 
		:style="{
			backgroundColor:bgColor, 
			zIndex:zIndex, 
			top:top+'px',
			animationDuration:duration+'ms'
		}">
			<view class="gui-popup-content gui-flex1 gui-flex gui-columns gui-popup-left" 
			@tap.stop="stopfun" ref="guiPopupLeft" 
			:class="[out ? 'gui-left-out' : 'gui-left-in']" 
			:style="{width:width, animationDuration:duration+'ms'}">
				<slot></slot>
			</view>
		</view>
		<!-- 右侧 -->
		<view class="gui-popup gui-flex gui-columns gui-align-items-end" 
		v-if="position == 'right'"
		:class="[out ? 'gui-fade-out' : 'gui-fade-in']" 
		ref="guipopup" 
		@tap.stop="closebysd" @touchmove.stop.prevent="stopfun" 
		:style="{
			backgroundColor:bgColor, 
			zIndex:zIndex, 
			top:top+'px',
			animationDuration:duration+'ms'
		}">
			<view class="gui-popup-content gui-flex1 gui-flex gui-columns gui-popup-right" 
			@tap.stop="stopfun" ref="guiPopupRight" 
			:class="[out ? 'gui-right-out' : 'gui-right-in']" 
			:style="{width:width, animationDuration:duration+'ms'}">
				<slot></slot>
			</view>
		</view>
	</view>
</template>
<script>
// #ifdef APP-NVUE
const animation = weex.requireModule('animation');
var graceJS = require('@/GraceUI5/js/grace.js');
// #endif
export default{
	name  : "gui-popup",
	props : {
		bgColor         : { type : String,  default : 'rgba(0, 0, 0, 0.7)'},
		position        : { type : String,  default : 'center'},
		width           : { type : String,  default : '580rpx'},
		canCloseByShade : { type : Boolean, default : true },
		zIndex          : { type : Number,  default : 99999},
		top             : { type : Number,  default : 0},
		duration        : { type : Number,  default : 280}
	},
	data(){
		return {
			show : false,
			out  : false
		}
	},
	methods:{
		open    : function(){
			this.out  = false;
			this.show = true;
			// #ifdef APP-NVUE
			this.weexAnimateIn();
			// #endif
			this.$emit('open'); 
		},
		closebysd : function () {
			if(this.canCloseByShade){this.close();}
		},
		close   : function(){
			this.out = true;
			// #ifdef APP-NVUE
			this.weexAnimateOut();
			// #endif
			setTimeout(()=>{
				this.show = false;
				this.$emit('close'); 
			},350);
		},
		stopfun : function(e){e.stopPropagation(); return null;},
		
		// #ifdef APP-NVUE
		weexAnimateIn : function(){
			graceJS.getRefs('guipopup', this, 0, (guipopupref)=>{
				animation.transition(guipopupref, {
					styles: { opacity : 1},
					duration: this.duration, //ms
					timingFunction: 'ease',
					delay: 0 //ms
				});
			});
			
			if(this.position == 'center'){
				graceJS.getRefs('guiPopupCenter', this, 0, (guipopupref)=>{
					animation.transition(guipopupref, {
						styles: { transform:'scale(1)'},
						duration: this.duration, //ms
						timingFunction: 'ease',
						delay: 0 //ms
					});
				});
			}else if(this.position == 'top'){
				graceJS.getRefs('guiPopupTop', this, 0, (guipopupref)=>{
					animation.transition(guipopupref, {
						styles: {transform:'translateY(0px)'},
						duration: this.duration, //ms
						timingFunction: 'ease',
						delay: 0 //ms
					});
				});
			}else if(this.position == 'bottom'){
				graceJS.getRefs('guiPopupBottom', this, 0, (guipopupref)=>{
					animation.transition(guipopupref, {
						styles: {transform:'translateY(0px)'},
						duration: this.duration, //ms
						timingFunction: 'ease',
						delay: 0 //ms
					});
				});
			}else if(this.position == 'left'){
				graceJS.getRefs('guiPopupLeft', this, 0, (guipopupref)=>{
					animation.transition(guipopupref, {
						styles: {transform:'translateX(0px)'},
						duration: this.duration, //ms
						timingFunction: 'ease',
						delay: 0 //ms
					});
				});
			}else{
				graceJS.getRefs('guiPopupRight', this, 0, (guipopupref)=>{
					animation.transition(guipopupref, {
						styles: {transform:'translateX(0px)'},
						duration: this.duration, //ms
						timingFunction: 'ease',
						delay: 0 //ms
					});
				});
			}
			
		},
		weexAnimateOut : function(){
			graceJS.getRefs('guipopup', this, 0, (guipopupref)=>{
				animation.transition(guipopupref, {
					styles: { opacity : 0},
					duration: this.duration, //ms
					timingFunction: 'ease',
					delay: 0 //ms
				});
			});
			
			if(this.position == 'center'){
				graceJS.getRefs('guiPopupCenter', this, 0, (guipopupref)=>{
					animation.transition(guipopupref, {
						styles: { transform:'scale(0.3)' },
						duration: this.duration, //ms
						timingFunction: 'ease',
						delay: 0 //ms
					});
				});
			}else if(this.position == 'top'){
				graceJS.getRefs('guiPopupTop', this, 0, (guipopupref)=>{
					animation.transition(guipopupref, {
						styles: {transform:'translateY(-600px)'},
						duration: this.duration, //ms
						timingFunction: 'ease',
						delay: 0 //ms
					});
				});
			}else if(this.position == 'bottom'){
				graceJS.getRefs('guiPopupBottom', this, 0, (guipopupref)=>{
					animation.transition(guipopupref, {
						styles: {transform:'translateY(600px)'},
						duration: this.duration, //ms
						timingFunction: 'ease',
						delay: 0 //ms
					});
				});
			}else if(this.position == 'left'){
				graceJS.getRefs('guiPopupLeft', this, 0, (guipopupref)=>{
					animation.transition(guipopupref, {
						styles: {transform:'translateX(-500px)'},
						duration: this.duration, //ms
						timingFunction: 'ease',
						delay: 0 //ms
					});
				});
			}else{
				graceJS.getRefs('guiPopupRight', this, 0, (guipopupref)=>{
					animation.transition(guipopupref, {
						styles: {transform:'translateX(600px)'},
						duration: this.duration, //ms
						timingFunction: 'ease',
						delay: 0 //ms
					});
				});
			}
		},
		// #endif
	}
}
</script>
<style>
.gui-popup{width:750rpx; position:fixed; z-index:99999; left:0; top:0; bottom:0; flex:1;}
.gui-popup-content{overflow:hidden;}
.gui-fade-out{opacity:0;}
.gui-popup-center{transform:scale(0.3,0.3);}
.gui-popup-top{transform:translateY(-1000px);}
.gui-popup-bottom{transform:translateY(600px);}
.gui-popup-left{transform:translateX(-600px);}
.gui-popup-right{transform:translateX(600px);}
/* #ifndef APP-NVUE */
.gui-popup{height:100%;}
/* #endif */
</style>