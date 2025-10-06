<template>
	<view class="gui-totop gui-fade-in" 
	hover-class="gui-tap" 
	v-if="show" 
	@tap="totop" 
	:style="{
		bottom:bottom,right:right,
		backgroundColor:background,zIndex:zIndex,
		borderRadius:borderRadius
	}">
		<text class="gui-icons gui-block-text gui-totop-text"
		:style="{
			color:color,
			fontSize:fontSize
		}">&#xe637;</text>
	</view>
</template>
<script>
export default{
	name  : "gui-totop",
	props : {
		top        : { type : Number, default : 0 },
		color      : { type : String, default : "#008AFF" },
		bottom     : { type : String, default : "80rpx" },
		right      : { type : String, default : "30rpx" },
		background : { type : String, default : "#FFFFFF"},
		borderRadius  : { type : String, default : "6rpx" },
		zIndex     : { type : Number, default : 9},
		fontSize   : { type : String, default : "44rpx" }
	},
	data() {
		return {
			show  : false,
			timer : null
		}
	},
	watch:{
		top : function(topVal){
			if(this.timer != null){clearTimeout(this.timer);}
			this.timer = setTimeout(()=>{
				this.show = topVal > 100 ? true : false;
			}, 80);
		}
	},
	methods:{
		totop : function(){
			// #ifndef APP-NVUE
			uni.pageScrollTo({
				scrollTop:0,
				duration:100
			})
			// #endif
			this.$emit('totop');
		}
	}
}
</script>
<style scoped>
.gui-totop{width:80rpx; height:80rpx; position:fixed;}
.gui-totop-text{width:80rpx; height:80rpx; line-height:80rpx; font-size:38rpx; text-align:center;}
</style>