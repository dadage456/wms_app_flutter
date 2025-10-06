<template>
	<view 
	class="gui-editor-show gui-border-box" 
	:style="{
		paddingLeft:padding+'rpx', 
		paddingRight:padding+'rpx', 
		width:'750rpx'
	}">
		<view 
		v-for="(item, index) in article" :key="index">
		
			<!-- 文本 -->
			<text class="gui-block-text" 
			:decode="true" 
			:selectable="true" 
			:user-select="true" 
			:style="textStyle" 
			v-if="item.type == 'txt'">{{item.content}}</text>
			
			<!-- 居中 -->
			<text class="gui-block-text gui-text-center" 
			:selectable="true" 
			:user-select="true" 
			:decode="true" 
			:style="centerStyle" 
			v-if="item.type == 'center'">{{item.content}}</text>
			
			<!-- 图片 -->
			<view class="gui-img-in" 
			v-else-if="item.type == 'img'" 
			:data-url="item.content" @tap="showImgs">
				<gui-image :src="item.content" :height="0" 
				:borderRadius="imgRadius"
				:width="(750-padding*2)"></gui-image>
			</view>
			
			<!-- 引用 源码 -->
			<text class="gui-block-text" 
			:selectable="true" 
			:user-select="true" 
			:style="quoteStyle" 
			:decode="true" 
			v-else-if="
			item.type == 'quote' || item.type == 'pre'
			">{{item.content}}</text>
			
			<!-- 加粗 -->
			<text class="gui-block-text gui-bold" 
			:selectable="true" 
			:user-select="true" 
			:style="strongStyle" 
			:decode="true" 
			v-else-if="item.type == 'strong'">{{item.content}}</text>
			
			<!-- 链接 -->
			<view v-else-if="item.type == 'link'">
				<gui-link :url="item.content" :title="item.content"></gui-link>
			</view>
			
			<!-- 分割符 -->
			<text class="gui-block-text gui-text-center" 
			:selectable="true" 
			:user-select="true" 
			:style="splineStyle" 
			v-else-if="item.type == 'spline'">● ● ●</text>
			
			<!-- h1 -->
			<text class="gui-block-text gui-h1" 
			:decode="true" 
			:selectable="true" 
			:user-select="true" 
			v-else-if="item.type == 'h1'">{{item.content}}</text>
			
			<!-- h2 -->
			<text class="gui-block-text gui-h2" 
			:selectable="true" 
			:user-select="true" 
			:decode="true" 
			v-else-if="item.type == 'h2'">{{item.content}}</text>
			
			<!-- h3 -->
			<text class="gui-block-text gui-h3" 
			:selectable="true" 
			:user-select="true" 
			:decode="true" 
			v-else-if="item.type == 'h3'">{{item.content}}</text>
			
			<!-- h4 -->
			<text class="gui-block-text gui-h4" 
			:selectable="true" 
			:user-select="true" 
			:decode="true" 
			v-else-if="item.type == 'h4'">{{item.content}}</text>
			
			<!-- h5 -->
			<text class="gui-block-text gui-h5" 
			:selectable="true" 
			:user-select="true" 
			:decode="true" 
			v-else-if="item.type == 'h5'">{{item.content}}</text>
			
			<!-- h6 -->
			<text class="gui-block-text gui-h6" 
			:selectable="true" 
			:user-select="true" 
			:decode="true" 
			v-else-if="item.type == 'h6'">{{item.content}}</text>
			
			<!-- 视频 -->
			<view v-if="item.type == 'video'">
				<video 
				:style="{width:(750-padding*2)+'rpx'}"
				:src="item.content" 
				controls></video>
			</view>
			
			<!-- 间距 -->
			<view :style="{height:itemMargin}"></view>
		</view>
	</view>
</template>
<script>
export default{
	name  : "gui-article-info",
	props : {
		article      : {
			type     : Array,  
			default  : function(){return new Array();}
		},
		itemMargin   : {
			type     : String, 
			default  : '20rpx',
		},
		padding      : {
			type     : Number, 
			default  : 30,
		},
		textStyle    : {
			type     : String, 
			default  : 'line-height:58rpx; font-size:30rpx; color:#2B2E3D; text-align:justify;'
		},
		centerStyle  : {
			type     : String, 
			default  : 'line-height:58rpx; font-size:30rpx; color:#2B2E3D;'
		},
		imgRadius    : {
			type     : String, 
			default  : '6rpx',
		},
		quoteStyle   : {
			type     : String, 
			default  : 'line-height:58rpx; font-size:30rpx; color:#2B2E3D; padding:20rpx; background-color:#F8F8F8;'
		},
		strongStyle  : {
			type     : String, 
			default  : 'line-height:58rpx; font-size:30rpx; color:#2B2E3D;'
		},
		splineStyle  : {
			type     : String, 
			default  : 'line-height:58rpx; font-size:30rpx; color:rgba(69, 90, 100, 0.6);'
		}
	},
	methods: {
		showImgs:function(e){
			var currentUrl = e.currentTarget.dataset.url;
			var imgs       = [];
			var items      = this.article;
			for(let i = 0; i < items.length; i++){
				if(items[i].type ==  'img'){
					imgs.push(items[i].content);
				}
			}
			uni.previewImage({
				urls:imgs,
				current:currentUrl
			})
		}
	}
}
</script>
<style scoped>
/* #ifndef APP-NVUE */
.gui-block-text{word-break: break-all;}
/* #endif */
</style>