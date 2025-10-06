<template>
	<gui-popup ref="guipopupfornk"
	position="bottom" :canCloseByShade="canCloseByShade">
		<view style="background-color:#F6F7F8;" 
		@tap.stop.prevent="stopfun">
			<text class="gui-keyboard-res gui-block-text" v-if="showInputRes" 
			:style="{color:resultColor, fontSize:resultSize}">{{resVal}}</text>
			<view class="gui-keyboard gui-flex gui-rows gui-space-between">
				<view class="gui-keyboard-left gui-flex gui-rows gui-wrap gui-space-between">
					<text v-for="(item, index) in [1,2,3,4,5,6,7,8,9]" :key="index" 
					class="gui-keyboard-keys gui-block-text" 
					:data-keynumber="item" 
					:style="{
						backgroundColor:tapIndex == item ? tapBgColor : '#FFFFFF', 
						color : tapIndex == item ? '#FFFFFF' : '#2B2E3D'
					}" 
					@tap.stop="inputNow">{{item}}</text>
					<text class="gui-keyboard-keys gui-block-text" 
					:style="{
						width: isPoint ? '259rpx':'538rpx',
						backgroundColor:tapIndex == 0 ? tapBgColor : '#FFFFFF',
						color : tapIndex == 0 ? '#FFFFFF' : '#2B2E3D'
					}" 
					data-keynumber="0" @tap.stop="inputNow">0</text>
					<text v-if="isPoint" class="gui-keyboard-keys" 
					:style="{
						width:'259rpx',
						backgroundColor:tapIndex == '.' ? tapBgColor : '#FFFFFF',
						color : tapIndex == '.' ? '#FFFFFF' : '#2B2E3D'
					}" 
					data-keynumber="." @tap.stop="inputNow">.</text>
				</view>
				<view class="gui-keyboard-right gui-flex gui-columns gui-align-items-center">
					<text class="gui-keyboard-keys gui-icons gui-block-text" 
					:style="{
						backgroundColor : tapIndex == -3 ? tapBgColor : '#FFFFFF',
						color : tapIndex == -3 ? '#FFFFFF' : '#2B2E3D'
					}" 
					:data-keynumber="-3" @tap.stop="deleteNow">&#xe623;</text>
					<text class="gui-keyboard-keys gui-keyboard-done gui-block-text" 
					:style="{backgroundColor:tapBgColor}" @tap.stop="done">{{doneBtnName}}</text>
				</view>
			</view>
		</view>
	</gui-popup>
</template>
<script>
export default{
	name  : "gui-number-keyboard",
	props : {
		canCloseByShade : { type : Boolean, default : false},
		doneBtnName     : { type : String,  default : "完成" },
		isPoint         : { type : Boolean, default : true },
		value           : { type : String,  default : ''},
		showInputRes    : { type : Boolean, default : true},
		resultColor     : { type : String,  default : '#2B2E3D'},
		resultSize      : { type : String,  default : '32rpx'},
		tapBgColor      : { type : String,  default : '#008AFF'},
	},
	methods:{
		open  : function(){
			this.$refs.guipopupfornk.open();
		},
		close : function(){
			this.$refs.guipopupfornk.close();
		},
		stopfun : function(e){
			e.stopPropagation();
			return ;
		},
		inputNow : function (e){
			var k = e.currentTarget.dataset.keynumber;
			this.resVal += k+'';
			this.tapIndex = k;
			this.$emit('keyboardInput', k);
			this.removeClass();
		},
		deleteNow : function (e){
			var k = e.currentTarget.dataset.keynumber;
			this.tapIndex = k;
			this.resVal = this.resVal.substring(0, this.resVal.length - 1);
			this.$emit('keyboardDelete');
			this.removeClass();
		},
		done : function(){
			this.$emit('keyboardDone');
		},
		setVal : function (val) {
			this.resVal = val;
		},
		removeClass : function () {
			setTimeout(()=>{this.tapIndex = -1;}, 100);
		},
	},
	data() {
		return {
			resVal   : '',
			tapIndex : -1
		}
	},
	created:function(){
		this.resVal = this.value+'';
	},
	watch:{
		value : function (val) {
			this.resVal = val+'';
		}
	}
}
</script>
<style>
.gui-keyboard{background-color:#F6F7F8; width:750rpx; padding:20rpx 0;}
.gui-keyboard-body{flex-direction:row; justify-content:space-between; padding:10px 0;}
.gui-keyboard-left{width:560rpx;}
.gui-keyboard-right{width:188rpx;}
.gui-keyboard-keys{width:166rpx; height:100rpx; margin:10rpx; background-color:#FFFFFF; text-align:center; line-height:100rpx; border-radius:8rpx; font-weight:700; font-size:50rpx;}
.gui-keyboard-done{height:340rpx; line-height:340rpx; font-size:36rpx; font-weight:400; color:#FFFFFF;}
.gui-keyboard-res{line-height:60rpx; text-align:center; font-size:32rpx; font-weight:bold; padding-top:20rpx;}
.keydown{background-color:#3688FF; color:#FFFFFF;}
</style>