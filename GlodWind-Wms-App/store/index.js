// 本文件由FirstUI授权予赵*河（会员ID：2 92  8，身份证尾号：0 440 1   3）专用，请尊重知识产权，勿私下传播，违者追究法律责任。
import Vue from 'vue'
import Vuex from 'vuex'
Vue.use(Vuex)

import config from '@/config'
import storage from '@/utils/storage'
import constant from '@/utils/constant'
import {
	login,
	logout,
	getInfo
} from '@/api/login'
import {
	getToken,
	setToken,
	removeToken
} from '@/utils/auth'
const baseUrl = config.baseUrl

const store = new Vuex.Store({


	state: {
		token: getToken(),
		name: storage.get(constant.name),
		userid: storage.get(constant.userid),
		avatar: storage.get(constant.avatar),
		roles: storage.get(constant.roles),
		permissions: storage.get(constant.permissions)
	},

	mutations: {
		SET_TOKEN: (state, token) => {
			state.token = token
		},
		SET_NAME: (state, name) => {
			state.name = name
			storage.set(constant.name, name)
		},
		SET_ID: (state, userid) => {
			state.userid = userid
			storage.set(constant.userid, userid)
		},
		SET_AVATAR: (state, avatar) => {
			state.avatar = avatar
			storage.set(constant.avatar, avatar)
		},
		SET_ROLES: (state, roles) => {
			state.roles = roles
			storage.set(constant.roles, roles)
		},
		SET_PERMISSIONS: (state, permissions) => {
			state.permissions = permissions
			storage.set(constant.permissions, permissions)
		}
	},
	getters: {
		token: state => state.user.token,
		avatar: state => state.user.avatar,
		name: state => state.user.name,
		roles: state => state.user.roles,
		permissions: state => state.user.permissions
	},

	actions: {
		// 登录
		Login({
			commit
		}, userInfo) {
			const username = userInfo.username.trim()
			const password = userInfo.password
			const code = userInfo.code
			const uuid = userInfo.uuid
			const clientid = userInfo.clientid
			return new Promise((resolve, reject) => {
				login(username, password, code, uuid, clientid).then(res => {
					setToken(res.token)
					commit('SET_TOKEN', res.token)
					resolve()
				}).catch(error => {
					reject(error)
				})
			})
		},

		// 获取用户信息
		GetInfo({
			commit,
			state
		}) {
			return new Promise((resolve, reject) => {
				getInfo().then(res => {
					const user = res.user
					const avatar = (user == null || user.avatar == "" || user.avatar == null) ? require("@/static/images/profile.jpg") : baseUrl + user.avatar
					const username = (user == null || user.userName == "" || user.userName == null) ? "" : user.userName
					const userid = (user == null || user.userId == "" || user.userId == null) ? "" : user.userId
					if (res.roles && res.roles.length > 0) {
						commit('SET_ROLES', res.roles)
						commit('SET_PERMISSIONS', res.permissions)
					} else {
						commit('SET_ROLES', ['ROLE_DEFAULT'])
					}
					commit('SET_NAME', username)
					commit('SET_ID', userid)
					commit('SET_AVATAR', avatar)
					resolve(res)
				}).catch(error => {
					reject(error)
				})
			})
		},

		// 退出系统
		LogOut({
			commit,
			state
		}) {
			return new Promise((resolve, reject) => {
				logout(state.token).then(() => {
					commit('SET_TOKEN', '')
					commit('SET_ROLES', [])
					commit('SET_PERMISSIONS', [])
					removeToken()
					storage.clean()
					resolve()
				}).catch(error => {
					reject(error)
				})
			})
		}
	}




	
})

export default store