fun1() {
	return new Promise((resolve, reject) => {
		uni.request({
			url: 'xxxx'，
			method: 'xxx',
			success: (res) => {
				resolve(res.data); //请求成功后，需要返回的数据
			},
			fail: (err) => {
				reject(err)
			}
		});
	})
}​