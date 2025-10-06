
module.exports = {
	
	// api 基础 url
	apiBaseUrl        : 'https://www.*****.com/api/',
	
	// 调试模式 [ false 关闭调试输出，项目发包时请设置此项为 false ]
	debug             : true,
	
	// 本地 Token 数据键名称
	localTokenKeyName : 'reqToken',
	
	// 用户登录 Token 数据键名称
	userTokenKeyName  : 'uToken',
	
	// token 有效期, 单位 秒 ，要与后端保持一致
	expiredTime       : 3600,
	
	// post 方式 header[content-type] 默认值
	postHeaderDefault : 'application/x-www-form-urlencoded',
	
	// 从服务器获取 token 函数
	// 因后端语言不同、思路不同，请跟据自己的 api 情况完成 token 获取函数
	// 一个示例，实际开发请跟据自己情况复写此函数	
	getToken : (resolve, reject) => {
		
		// 接口请求秘钥 与后端开发人员协商格式及获取
		// 如 : 
		var appKey = 'AppKey2021&&';
		
		// 发起请求
		uni.request({
			// token 授权 api 服务器地址
			url      : "https://www.******.com/api/srequest/makeToken",
			// 请求秘钥
			data     : { 'appKey' : appKey },
			// 请求方式 POST
			method   : "POST",
			// headers
			header   : {'content-type' : 'application/x-www-form-urlencoded'},
			// 返回值类型
			dataType : "json",
			// 请求成功
			success  : (res) => {
				var data = res.data;
				if(data.status == 'ok'){
					resolve(data.data);
				}else{
					reject();
				}
			},
			// 请求失败
			fail     : (e) => { reject();}
		});
	}
	
}
