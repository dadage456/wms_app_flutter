# LoginA 登录模板A

<div class="fui-doc__card">
  <div class="fui-doc__title">概述</div>
 
 登录模板，FirstUI物料内容，售卖产品，需要可前往 [物料商城](https://firstui.cn/store)购买，会员最低9折。
 
</div>


### 支持平台

|App-vue		|App-Nvue		|微信小程序		|支付宝小程序	|百度小程序		|字节小程序		|QQ小程序		|H5				|
|:------------:	|:------------:	|:------------:	|:------------:	|:------------:	|:------------:	|:------------:	|:------------:	|
|✓				|✓				|✓				|✓				|✓				|✓				|✓				|✓				|

### 模板部分截图

| ![LoginA](/img/template/loginA/1.png)	|![LoginA](/img/template/loginA/2.png)	|![LoginA](/img/template/loginA/3.png)	|![LoginA](/img/template/loginA/4.png)	|
|:------------:							|:------------:							|:------------:							|:------------:							|

### 项目主要内容

<div class="fui-sub__text">一级目录结构</div>

```
.
├─ common/
├─ components/
├─ pages/
├─ static/
├─ store/
├─ App.vue
├─ index.html
├─ main.js
├─ manifest.json
├─ pages.json
└─ README.md
```

### 页面内容目录结构

<div class="fui-sub__text">项目包含验证码登录、密码登录、注册、选择国家或地区、输入验证码、重置密码、设置密码等页面</div>

```
pages/
├─ account/
│  ├─ login/login.nvue
│  ├─ loginPwd/loginPwd.nvue
│  └─ reg/reg.nvue
├─ common/
│  ├─ area/area.nvue
│  └─ captcha/captcha.nvue
└─ set/
   ├─ resetPwd/resetPwd.nvue
   └─ setPwd/setPwd.nvue
```


### 组件内容目录结构

<div class="fui-sub__text">如果对组件不熟悉请查看对应组件文档使用</div>

``` js
components/
├─ firstui/ 
   ├─ fui-button   /*【Button 按钮】*/
   ├─ fui-divider  /*【Divider 分割线】*/
   ├─ fui-icon  /*【Icon 图标】*/
   ├─ fui-index-list  /*【IndexList 索引列表】*/
   ├─ fui-input  /*【Input 输入框】*/
   ├─ fui-loadmore  /*【LoadMore 加载更多】*/
   ├─ fui-search-bar  /*【SearchBar 搜索栏】*/
   ├─ fui-single-input  /*【SingleInput 单输入框】*/
   └─ fui-theme  /*【自定义主题】*/

```

### 开始使用

<div class="fui-sub__desc">以下为引入使用需要注意的地方，请仔细阅读，避免引入自己项目中和示例展示效果有差异</div>

1、在App.vue下全局引入样式文件

``` css
<style>
	/*每个页面公共css */
	@import './common/fui-app.css';
	/* #ifndef APP-NVUE */
	@import './components/firstui/fui-theme/fui-theme.css';
	/* #endif */
</style>
```

2、main.js 中引入fui-app.js（this.fui 等api）以及vuex， 代码如下：
``` js
import App from './App'
import fui from './common/fui-app'
import store from './store'

// #ifndef VUE3
import Vue from 'vue'
Vue.config.productionTip = false
Vue.prototype.$store = store
App.mpType = 'app'
Vue.prototype.fui = fui
const app = new Vue({
	store,
	...App
})
app.$mount()
// #endif

// #ifdef VUE3
import {
	createSSRApp
} from 'vue'
export function createApp() {
	const app = createSSRApp(App)
	app.use(store)
	app.config.globalProperties.fui = fui;
	return {
		app
	}
}
// #endif
```

3.组件引入配置，在pages.json文件中配置：

``` js
"easycom": {
	"autoscan": true,
	"custom": {
		"fui-(.*)": "@/components/firstui/fui-$1/fui-$1.vue"
	}
}
```

<div class="fui-sub__text">注意：以上内容结合本项目目录结构进行配置，如果引入自己项目中确保文件路径引入正确</div>

### 注意事项

::: tip Nvue使用注意
- APP-Nvue不支持使用自定义主题，修改组件颜色需要通过组件props属性
- this.fui.xx等api不可用，如：this.fui.href  换成 uni.navigateTo 等
<div class="fui-sub__text">使用建议：如果不需要开发App，可直接将页面文件后缀名改为.vue</div>
:::

::: danger 支付宝小程序项目配置需勾选以下选项：
- 启用 component2
- 启用小程序基础库 2.0 构建
:::

其他如微信小程序，尽量使用较新版本的调试基础库。

### 微信扫码预览

<table><thead><tr><th style="text-align: center;"><img src="/img/template/loginA/qrcode.png" alt="FirstUI示例 微信小程序" title="扫码查看" style="width:200px;height:200px"></th></tr></thead> <tbody><tr><td style="text-align: center;">FirstUI示例 微信小程序</td></tr></tbody></table>
