<template>
	<gui-popup ref="guipopupforacsheet" 
	position="bottom" :canCloseByShade="canCloseByShade">
		<view  
		:style="{'margin-bottom':'25rpx','margin-left':((750-width)/2)+'rpx'}"
		@tap.stop.prevent="stopfun">
			<view class="gui-bg-white"
			:style="{width:width+'rpx', height:(height+100)+'rpx', borderRadius:borderRadius}">
				<text class="gui-action-sheet-title gui-block-text gui-border-b" 
				:style="{color:titleColor}">{{title}}</text>
				<scroll-view scroll-y="true" class="gui-border-box" 
				:style="{width:width+'rpx', height:height+'rpx', paddingTop:'20rpx', paddingBottom:'20rpx'}">
					<text class="gui-text-center gui-block-text gui-border-b" 
					v-for="(item, index) in items" :key="index" 
					@tap.stop="selected" :data-index="index" 
					:style="{ color:listColor, lineHeight:listLineHeight, fontSize:listFontSize}">{{item}}</text>
					<text class="gui-text-center gui-block-text" 
					:style="{color:cancelBtnColor, lineHeight:listLineHeight, fontSize:listFontSize, marginTop:'10rpx'}" 
					v-if="isCancelBtn" @tap.stop="cancel">{{cancelBtnName}}</text>
				</scroll-view>
			</view>
			<!-- iphone 底部操作按钮躲避 -->
			<gui-iphone-bottom></gui-iphone-bottom>
		</view>
	</gui-popup>
</template>
<script>
export default{
	name  : "gui-action-sheet",
	props : {
		width           : { type : Number,  default : 680},
		height          : { type : Number,  default : 500},
		borderRadius    : { type : String,  default : '10rpx'},
		title           : { type : String,  default : ''},
		titleColor      : { type : String,  default : '#2B2E3D'},
		items           : { type : Array,   default : function(){return [];}},
		listColor       : { type : String,  default : '#008AFF'},
		listLineHeight  : { type : String,  default : '95rpx'},
		listFontSize    : { type : String,  default : '28rpx'},
		isCancelBtn     : { type : Boolean, default : true},
		cancelBtnName   : { type : String,  default : '取消'},
		cancelBtnColor  : { type : String,  default : 'rgba(69, 90, 100, 0.6)'},
		canCloseByShade : { type : Boolean, default : false}
	},
	methods:{
		open  : function(){
			this.$refs.guipopupforacsheet.open();
		},
		close : function(){
			this.$refs.guipopupforacsheet.close();
		},
		stopfun : function(e){
			e.stopPropagation();
			return null;
		},
		cancel : function () {
			this.$emit('cancel');
			this.close();
		},
		selected:function (e) {
			this.$emit('selected', e.currentTarget.dataset.index);
			this.close();
		},
	}
}
</script>
<style scoped>
.gui-action-sheet-title{text-align:center; font-size:26rpx; line-height:100rpx; height:100rpx; font-weight:bold;}
</style>
