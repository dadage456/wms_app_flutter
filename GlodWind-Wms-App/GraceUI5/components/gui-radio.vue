<template>
	<view class="gui-flex gui-rows gui-nowrap gui-align-items-center" 
	:style="{justifyContent:justifyContent}" 
	@tap.stop="changeStatus">
		<view 
		:style="{
			width:(size+5)+'rpx',
			height:(size+5)+'rpx', 
			overflow:'hidden',
			backgroundColor:status?checkedColor:'',
			borderRadius:(size)+'rpx' 
		}">
			<text v-if="status" 
			class="gui-radio-btn gui-icons gui-block-text gui-text-center"
			:style="{
				fontSize:(size-12)+'rpx', 
				lineHeight:(size+8)+'rpx', 
				color : '#FFFFFF',
			}">&#xe60f;</text>
			<text v-else
			class="gui-radio-btn gui-icons gui-block-text gui-text-center" 
			:style="{
				fontSize:(size)+'rpx',
				lineHeight:(size+5)+'rpx', 
				color : color
			}">&#xe762;</text>
		</view>
		<view class="gui-radio-lable"><slot></slot></view>
	</view>
</template>
<script>
export default {
	name  : "gui-radio",
	props : {
		size : {
			type : Number,
			default : 38
		},
		color : {
			type : String,
			default : '#EEEEEE'
		},
		checked : {
			type : Boolean,
			default : false
		},
		checkedColor : {
			type : String,
			default : '#008AFF'
		},
		parameter : {
			type : Array,
			default : function () {
				return []
			}
		},
		justifyContent:{type:String, default:'flex-start'}
	},
	data() {
		return {
			status : false
		}
	},
	watch: {
		checked : function (val, old) {
			this.status = val;
		}
	},
	created : function(){
		this.status = this.checked;
	},
	methods:{
		changeStatus : function(){
			this.status = !this.status;
			this.$emit('change', [this.status, this.parameter]);
		}
	}
}
</script>
<style scoped>
.gui-radio-btn{color:#999999;}
.gui-radio-lable{margin-left:15rpx;}
</style>