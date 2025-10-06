<template>
	<gui-popup ref="guipopupformodal" 
	:width="width" 
	:canCloseByShade="canCloseByShade" 
	:zIndex="zIndex" 
	@close="eClose">
		<view 
		:style="bodyStyle" 
		@tap.stop.prevent="stopfun" 
		class="gui-relative">
			<view>
				<text class="gui-block-text gui-text-center" v-if="isTitle"
				:style="titleStyle">{{title}}</text>
			</view>
			<view><slot name="content"></slot></view>
			<view><slot name="btns"></slot></view>
			<text 
			class="gui-popup-close gui-block-text gui-absolute-rt gui-icons"
			:style="closeBtnStyle" 
			@tap.stop.prevent="close" 
			v-if="isCloseBtn">&#xe7a5;</text>
		</view>
	</gui-popup>
</template>
<script>
export default{
	name  : "gui-modal",
	props : {
		width           : { type  : String,  default : '580rpx'},
		bodyStyle       : { type  : String,  default : 'background-color:#FFFFFF; border-radius:6rpx;' },
		isCloseBtn      : { type  : Boolean, default : true },
		closeBtnStyle   : { type  : String,  default : 'color:#2B2E3D; font-size:28rpx;' },
		isTitle         : { type  : Boolean, default : true },
		title           : { type  : String,  default : 'title' },
		titleStyle      : { type  : String,  default : 'line-height:100rpx; font-size:28rpx; font-weight:700; color:#2B2E3D;' },
		canCloseByShade : { type  : Boolean, default : true },
		zIndex          : { type  : Number,  default : 99 }
	},
	methods:{
		open  : function(){
			this.$refs.guipopupformodal.open();
			this.$emit('open');
		},
		close : function(){
			this.$refs.guipopupformodal.close();
			this.$emit('close');
		},
		stopfun : function(e){
			e.stopPropagation();
			return null;
		},
		eClose : function(){
			this.$emit('close');
		}
	}
}
</script>
<style scoped>
.gui-popup-close{width:80rpx; height:80rpx; line-height:80rpx; text-align:center;}
</style>