<template>
	<view class="gui-flex gui-rows gui-nowrap gui-justify-content-center gui-segmented-control" 
	:style="{borderRadius:borderRadius}">
		<text v-for="(item, index) in items" :key="index" 
		:class="['gui-segmented-control-item','gui-block-text',
		index == currentIn ? 'gui-segmented-current':'',
		index == currentIn ? 'gui-fade-in':'']" 
		:style="{borderRadius:borderRadius}" 
		@tap.stop="changeSC" :data-index="index">{{item}}</text>
	</view>
</template>
<script>
export default{
	name  : "gui-segmented-control",
	props : {
		items : {
			type : Array,
			default : function () { return new Array();}
		},
		current : { type : Number, default : 0},
		borderRadius:{type:String, default:'6rpx'}
	},
	data() {
		return {
			currentIn: 0
		}
	},
	created: function(){
		this.currentIn = this.current;
	},
	watch:{
		current : function (val) {
			this.currentIn = val;
		}
	},
	methods:{
		changeSC:function (e) {
			var index = Number(e.currentTarget.dataset.index);
			this.currentIn = index;
			this.$emit('change', index);
		}
	}
}
</script>
<style scoped>
.gui-segmented-control-item{width:50rpx; flex:1; text-align:center;}
</style>