<template>
	<text :class="[
		bgClass, 'gui-block-text', 'gui-tags', 'gui-ellipsis', 'gui-border', 
		tapping ? 'gui-tag-opacity':'']" 
		:style="{
		width:width == 0 ? '' : width+'rpx',
		color:color,
		paddingLeft:padding+'rpx',
		paddingRight:padding+'rpx',
		lineHeight:(size*lineHeight)+'rpx',
		height:(size*lineHeight)+'rpx', 
		fontSize:size+'rpx',
		borderRadius:borderRadius+'rpx',
		marginRight:margin+'rpx',
		marginBottom:margin+'rpx',
		borderColor:borderColor
		}" @tap="tapme">{{text}}</text>
</template>
<script>
export default{
	name  : "gui-tags",
	props : {
		width        : {type:Number, default:0},
		text         : {type:String, default:''},
		size         : {type:Number, default:26},
		lineHeight   : {type:Number, default:1.8},
		padding      : {type:Number, default:15},
		margin       : {type:Number, default:15},
		bgClass      : {type:String, default:'gui-bg-blue'},
		color        : {type:String, default:'#FFFFFF'},
		borderRadius : {type:Number, default:6},
		data         : {type:Array, default:function(){return [];}},
		borderColor  : {type:String, default:'#FFFFFF'}
	},
	data() {
		return {
			tapping : false
		}
	},
	methods:{
		tapme : function(){
			this.tapping = true;
			setTimeout(()=>{this.tapping = false}, 200);
			this.$emit('tapme', this.data);
		}
	}
}
</script>
<style scoped>
.gui-tags{text-align:center;}
.gui-tag-opacity{opacity:0.88;}
</style>