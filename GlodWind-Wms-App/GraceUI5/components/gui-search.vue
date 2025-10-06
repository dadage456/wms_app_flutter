<template>
	<view class="gui-flex gui-rows gui-nowrap gui-align-items-center" 
	:style="{
		height:height, 
		backgroundColor:background,
		borderRadius:borderRadius
		}">
		<text class="gui-search-icon gui-icons gui-block-text gui-text-center" @tap.stop="tapme" 
		:style="{
			color:iconColor, 
			fontSize:iconFontSize, 
			lineHeight:height, width:iconWidth
		}">&#xe604;</text>
		
		<input 
		type="text" 
		:placeholder-class="placeholderClass" 
		class="gui-search-input gui-flex1" 
		:placeholder="placeholder" 
		v-model="inputVal" 
		v-if="!disabled" :focus="focus" 
		:style="{
			height:inputHeight, 
			lineHeight:inputHeight, 
			fontSize:inputFontSize, 
			color:inputColor
		}" 
		@input="inputting" @confirm="confirm" />
		
		<text class="gui-search-input gui-flex1 gui-block-text" 
		v-if="disabled" @tap.stop="tapme" 
		:style="{
			height:inputHeight, 
			lineHeight:inputHeight, 
			fontSize:inputFontSize, 
			color:disableColor}">{{placeholder}}</text>
		<text class="gui-search-icon gui-icons gui-block-text gui-text-center" 
		v-if="inputVal.length > 0 && clearBtn" @tap.stop="clearKwd" 
		:style="{
			color:iconColor, 
			fontSize:iconFontSize, 
			lineHeight:height, 
			width:iconWidth}">&#xe78a;</text>
	</view>
</template>
<script>
export default{
	name  : "gui-search",
	props : {
		height:{type:String, default:'66rpx'},
		background:{type:String, default:'#FFFFFF'},
		fontSize:{type:String, default:'28rpx'},
		iconWidth:{type:String, default:'70rpx'},
		iconColor:{type:String, default:'#A5A7B2'},
		iconFontSize:{type:String, default:'30rpx'},
		inputHeight:{type:String, default:'30rpx'},
		inputFontSize:{type:String, default:'26rpx'},
		inputColor:{type:String, default:'#323232'},
		placeholder:{type:String, default:'关键字'},
		placeholderClass:{type:String, default:''},
		disableColor:{type:String, default:'#666666'},
		kwd:{type:String, default:''},
		borderRadius:{type:String, default:'66rpx'},
		disabled:{type:Boolean, default:false},
		focus:{type:Boolean, default:false},
		clearBtn:{type:Boolean, default:true}
	},
	data() {
		return {
			inputVal : ''
		}
	},
	created: function (){
		this.inputVal = this.kwd;
	},
	watch:{
		kwd : function(val, vo){
			this.inputVal = val;
		}
	},
	methods:{
		clearKwd : function () {
			this.inputVal = '';
			this.$emit('clear', '');
		},
		inputting : function(e){
			this.$emit('inputting', e.detail.value);
		},
		confirm : function (e) {
			this.$emit('confirm', e.detail.value);
			uni.hideKeyboard();
		},
		tapme : function () {
			this.$emit('tapme')
		}
	}
}
</script>
<style scoped>
.gui-search-input{width:100rpx; margin:0 10rpx; border-width:0rpx; padding:0; background-color:rgba(255,255,255,0);}
</style>