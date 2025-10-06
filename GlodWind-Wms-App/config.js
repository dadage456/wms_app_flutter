// 应用全局配置
const config = {
	/* baseUrl: 'http://192.168.8.100:8086', */
	/* baseUrl: 'http://10.12.50.171:8086', */
	baseUrl: 'http://10.12.8.123:8086',
	/* baseUrl: 'http://192.168.0.103:8086', */
	/* baseUrl: 'http://192.168.8.100:8086', */
	// 应用信息
	appInfo: {
		// 应用名称
		name: "goldwind-wms",
		// 应用版本
		version: "1.1.14",
		// 应用logo
		logo: "/static/images/favicon.ico",
		// 官方网站
		site_url: "https://www.goldwind.com",
		// 政策协议
		agreements: [{
				title: "隐私政策",
				url: ""
			},
			{
				title: "用户服务协议",
				url: ""
			}
		]
	}
}
export default config