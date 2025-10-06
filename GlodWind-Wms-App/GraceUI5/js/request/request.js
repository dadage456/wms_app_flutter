
// 加载配置
var GraceRequestConfig = require('@/GraceUI5/js/request/config.js');
var md5                = require('@/GraceUI5/js/md5.js');

// 核心工具定义
module.exports = {
	
	// token 数据记录
	token    : '',
	
	// 连接接服务器获得请求 token
	getTokenFromApi : function (resolve, reject) {
		new Promise(GraceRequestConfig.getToken).then((res)=>{
			this.token = res;
			// 将 token 保存在本地并记录获取时间
			uni.setStorageSync(GraceRequestConfig.localTokenKeyName, this.token);
			// 记录时间
			var dateObj = new Date();
			var cTime   = dateObj.getTime();
			cTime      += '';
			uni.setStorageSync('GraceRequestTokenTime', cTime);
			resolve();
		}).catch(()=>{
			this.debug('api 获取 token 失败');
			this.token = '';
			reject();
		});
	},
	
	// 获取 token
	getToken : function(resolve, reject){
		// 首先尝试从本地获取
		var token = uni.getStorageSync(GraceRequestConfig.localTokenKeyName);
		// 本地不存在 token 数据
		if(!token || token == ''){
			new Promise(this.getTokenFromApi.bind(this)).then((res)=>{
				resolve();
			}).catch(()=>{reject();});
		}
		// 存在 token 数据
		else{
			// 检查 token 有效期
			var expiredTime = GraceRequestConfig.expiredTime;
			expiredTime    *= 1000;
			var tokenTime   = Number(uni.getStorageSync('GraceRequestTokenTime'));
			tokenTime      += expiredTime;
			var dateObj     = new Date();
			var cTime       = dateObj.getTime();
			// 有效期内
			if(tokenTime > cTime){
				this.token = token;
				resolve();
			}
			// 获取新的 token
			else{
				new Promise(this.getTokenFromApi.bind(this)).then((res)=>{
					resolve();
				}).catch(()=>{
					reject();
				});
			}
		}
	},
	
	// 设置默认值补齐
	requestInit : function(sets, withLoginToken){
		if(!sets.data){sets.data         = {};}
		if(!sets.header){sets.header     = {};}
		if(!sets.timeout){sets.timeout   = 60000;}
		if(!sets.dataType){sets.dataType = 'json';}
		sets.header.token = this.token;
		if(withLoginToken){
			var loginToken = this.checkLogin();
			if(loginToken){sets.header.logintoken = loginToken;}
		}
		return sets;
	},
	
	// 服务端 token 错误处理
	tokenErrorHandle : function (res) {
		console.log(res);
		if(res.data && res.data == 'token error'){
			uni.removeStorageSync(GraceRequestConfig.localTokenKeyName);
		}
	},
	
	// GET 请求 异步
	get : function(url, sets, success, fail, complete, withLoginToken){
		if(!sets){sets = {};}
		if(!success){success = function(res){}}
		if(!fail){fail = function(e){}}
		if(!complete){complete = function(res){}}
		if(!withLoginToken){withLoginToken = false;}
		new Promise(this.getToken.bind(this)).then(()=>{
			if(GraceRequestConfig.apiBaseUrl != ''){url = GraceRequestConfig.apiBaseUrl + url;}
			sets = this.requestInit(sets, withLoginToken);
			uni.request({
				url      : url,
				data     : sets.data,
				timeout  : sets.timeout,
				dataType : sets.dataType,
				header   : sets.header,
				method   : 'GET',
				success  : (res)=>{
					this.debug(res);
					success(res.data);
					this.tokenErrorHandle(res.data);
				},
				fail     : (error)=>{fail(error.errMsg);},
				complete : (res) =>{complete(res);}
			});
		}).catch((e)=>{
			console.log(e);
			this.tokenError();
		});
	},
	
	// GET 请求 同步
	getSync : async function(url, sets, withLoginToken) {
		let res, error;
		if(!withLoginToken){withLoginToken = false;}
		return new Promise(this.getToken.bind(this)).then(async ()=>{
			if(GraceRequestConfig.apiBaseUrl != ''){url = GraceRequestConfig.apiBaseUrl + url;}
			sets = this.requestInit(sets, withLoginToken);
			var [error, res] = await uni.request({
				url      : url,
				data     : sets.data,
				timeout  : sets.timeout,
				dataType : sets.dataType,
				header   : sets.header,
				method   : 'GET'
			});
			if(error != null){ return false; }
			this.debug(res);
			this.tokenErrorHandle(res.data);
			return res.data;
		}).catch((e)=>{
			console.log(e);
			this.tokenError();
			return ['', e];
		});
	},
	
	// POST 请求 异步
	post : function(url, sets, success, fail, complete, isSign, withLoginToken){
		if(!sets){sets = {};}
		if(!success){success = function(res){}}
		if(!fail){fail = function(e){}}
		if(!complete){complete = function(res){}}
		if(!withLoginToken){withLoginToken = false;}
		
		new Promise(this.getToken.bind(this)).then(()=>{
			if(GraceRequestConfig.apiBaseUrl != ''){url = GraceRequestConfig.apiBaseUrl + url;}
			sets = this.requestInit(sets, withLoginToken);
			if(!sets.header['content-type']){
				sets.header['content-type'] = GraceRequestConfig.postHeaderDefault;
			}
			if(isSign == true){
				sets.data = this.sign(sets.data);
			}else if(isSign == 'value'){
				sets.data = this.signValue(sets.data);
			}
			uni.request({
				url      : url,
				data     : sets.data,
				timeout  : sets.timeout,
				dataType : sets.dataType,
				header   : sets.header,
				method   : 'POST',
				success  : (res)=>{
					this.debug(res);
					success(res.data);
					this.tokenErrorHandle(res.data);
				},
				fail     : (error)=>{fail(error.errMsg);},
				complete : (res) =>{complete(res);}
			});
		}).catch((e)=>{
			console.log(e);
			this.tokenError();
		});
	},
	
	// POST 请求 同步
	postSync : async function(url, sets, isSign, withLoginToken) {
		let res, error;
		if(!withLoginToken){withLoginToken = false;}
		return new Promise(this.getToken.bind(this)).then(async ()=>{
			if(GraceRequestConfig.apiBaseUrl != ''){url = GraceRequestConfig.apiBaseUrl + url;}
			sets = this.requestInit(sets, withLoginToken);
			if(!sets.header['content-type']){
				sets.header['content-type'] = GraceRequestConfig.postHeaderDefault;
			}
			if(isSign == true){
				sets.data = this.sign(sets.data);
			}else if(isSign == 'value'){
				sets.data = this.signValue(sets.data);
			}
			var [error, res] = await uni.request({
				url      : url,
				data     : sets.data,
				timeout  : sets.timeout,
				dataType : sets.dataType,
				header   : sets.header,
				method   : 'POST'
			});
			if(error != null){ return false; }
			this.tokenErrorHandle(res.data);
			return res.data;
		}).catch((e)=>{
			console.log(e);
			this.tokenError();
			return ['', e];
		});
	},
	
	// 文件上传
	upload : function(url, filePath, fileType, sets, success, fail, complete, withLoginToken){
		if(!sets){sets = {};}
		if(!success){success = function(res){}}
		if(!fail){fail = function(e){}}
		if(!complete){complete = function(res){}}
		if(!withLoginToken){withLoginToken = false;}
		new Promise(this.getToken.bind(this)).then(()=>{
			if(GraceRequestConfig.apiBaseUrl != ''){url = GraceRequestConfig.apiBaseUrl + url;}
			// 初始化 sets
			if(!sets.name){sets.name = 'file';}
			if(!sets.header){sets.header     = {};}
			if(!sets.formData){sets.formData = {};}
			sets.header.token = this.token;
			if(withLoginToken){
				var loginToken = this.checkLogin();
				if(loginToken){sets.header.loginToken = loginToken;}
			}
			// 开始上传
			uni.uploadFile({
				url         : url,
				filePath    : filePath,
				name        : sets.name,
				formData    : sets.formData,
				header      : sets.header,
				success     : (res)=>{
					success(res.data);
					this.tokenErrorHandle(res.data);
				},
				fail        : (error)=>{fail(error);},
				complete    : (res) =>{complete(res);}
			});
		}).catch((e)=>{
			console.log(e);
			this.tokenError();
		});
	},
	
	// debug 函数
	debug : function (content) {
		if(!GraceRequestConfig.debug){return ;}
		console.log(content);
	},
	
	// token 错误
	tokenError : function () {
		uni.showToast({title:"请求失败，请重启应用重试", icon:"none"});
	},
	
	// 签名算法
	sign : function (data) {
		var keys = []; 
		Object.keys(data).sort().map((key) => {keys.push(key);});
		keys.push(this.token);
		var sign  = md5.md5(keys.join('-'));
		data.gracesign = sign;
		return data;
	},
	
	// signValue
	signValue : function(data){
		var vals = [];
		Object.keys(data).sort().map((key) => {vals.push(data[key]);});
		vals.push(this.token);
		var sign  = md5.md5(vals.join('-'));
		data.gracesign = sign;
		return data;
	},
	
	// 登录检查
	// 登录后在本地保存一个 token
	checkLogin : function (notLoginDo) {
		var loginToken = uni.getStorageSync(GraceRequestConfig.userTokenKeyName);
		if(!loginToken || loginToken == ''){
			loginToken = '';
			if(notLoginDo){
				uni.showToast({title:"请登录", icon:"none", mask:true});
				setTimeout(()=>{notLoginDo();}, 1500);
			}
			return false;
		}
		return loginToken;
	},
	
	// 跳转到登录页面
	gotoLogin : function (path, opentype) {
		if(!path){path = '../login/login';}
		if(!opentype){opentype = 'redirect';}
		switch(opentype){
			case  'redirect' : 
			uni.redirectTo({url:path});
			break;
			case  'navigate' : 
			uni.navigateTo({url:path});
			break;
			case  'switchTab' : 
			uni.switchTab({url:path});
			break;
		}
	},
	
	// 记录 用户 token 到本地
	// 格式 loginToken-uid
	writeLoginToken : function (token, uid) {
		var loginToken = token+'-'+uid;
		uni.setStorageSync(GraceRequestConfig.userTokenKeyName, loginToken);
		return ;
	}
	
}
