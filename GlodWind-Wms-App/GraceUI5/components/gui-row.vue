<template>
	<view 
	:class="classesRuntime" 
	:style="styleRuntime">
		<slot></slot>
	</view>
</template>
<script>
export default{
	name  : "gui-column",
	props:{
		wrap               : {type:Boolean, default:false},
		mainAxisAlignment  : {type:String, default:'flex-start'},
		crossAxisAlignment : {type:String, default:'flex-start'},
		customStyle        : {type:String, default:''},
		customClasses      : {type:Array,  default:function(){return [];}}
	},
	data() {
		return {
			styleRuntime : '',
			classesRuntime : []
		}
	},
	methods:{
		makeStyle : function(){
			var styleRuntime = 'justify-content:'+this.mainAxisAlignment+'; ';
			styleRuntime += 'align-items:'+this.crossAxisAlignment+'; ';
			styleRuntime += this.customStyle;
			this.styleRuntime = styleRuntime;
		},
		makeClasses : function(){
			var classes = ['gui-flex', 'gui-rows'];
			if(this.wrap){
				classes.push('gui-wrap');
			}else{
				classes.push('gui-nowrap');
			}
			classes = classes.concat(this.customClasses);
			this.classesRuntime = classes;
		}
	},
	mounted:function(){
		this.makeStyle();
		this.makeClasses();
	},
	watch:{
		mainAxisAlignment  : function(){this.makeStyle();},
		crossAxisAlignment : function(){this.makeStyle();},
		customStyle        : function(){this.makeStyle();},
		customClasses        : function(){this.makeClasses();},
		wrap               : function(){this.makeClasses();}
	}
}
</script>
<style scoped>
</style>