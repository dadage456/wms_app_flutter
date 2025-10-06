<template>
	<view class="gui-img" 
	:style="{
		width:width+'rpx', 
		height:height == 0 ? imgHeight+'rpx' : height+'rpx' ,
		borderRadius:borderRadius 
	}">
		<image 
		:src="src" 
		@load="imgLoad" 
		:mode="mode" 
		@error="error" 
		:style="{
			width:width+'rpx', 
			height:imgHeight+'rpx', 
			borderRadius:borderRadius, 
			opacity:opacity
		}"></image>
		<text 
		class="gui-img-loading gui-icons" 
		:class="[animate?'gui-fade-out':'']" v-if="isLoading" 
		:style="{
			width:width+'rpx', 
			height:height == 0 ? imgHeight+'rpx' : height+'rpx', 
			lineHeight:height == 0 ? imgHeight+'rpx' : height+'rpx', 
			borderRadius:borderRadius}">&#xe63a;</text>
		<text class="gui-img-loading gui-icons" :class="[animate?'gui-fade-out':'']" v-if="failed"
		:style="{
			width:width+'rpx', 
			height:height == 0 ? imgHeight+'rpx' : height+'rpx', 
			lineHeight:height == 0 ? imgHeight+'rpx' : height+'rpx', 
			borderRadius:borderRadius}">&#xe65b;</text>
	</view>
</template>
<script>
export default{
	name  : "gui-image",
	props : {
		src   : {type:String, default:''},
		width : {type:Number, default:300},
		height: {type:Number, default:0},
		timer : {type:Number,default:200},
		borderRadius:{type:String, default:'0rpx'},
		mode : {type:String, default:"widthFix"}
	},
	data() {
		return {
			isLoading : true,
			imgHeight : 180,
			opacity   : 0,
			animate   : false,
			failed    : false
		}
	},
	methods:{
		imgLoad : function (e) {
			var scale      = e.detail.width / e.detail.height;
			if(this.mode == "widthFix"){
				this.imgHeight = this.width / scale;
			}else{
				this.imgHeight = this.height;
			}
			this.animate = true;
			setTimeout(() => {this.isLoading = false; this.opacity = 1;}, this.timer);
		},
		error : function(){
			this.isLoading = false;
			this.failed    = true;
		}
	}
}
</script>
<style scoped>
.gui-img{width:500rpx; height:500rpx; overflow:hidden; font-size:0; position:relative;}
.gui-img-loading{position:absolute; left:0; top:0; background-color:#F8F8F8; font-size:58rpx; color:#D9D9D9; text-align:center;}
</style>