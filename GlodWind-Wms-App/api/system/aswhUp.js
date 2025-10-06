import upload from '@/utils/upload'
import request from '@/utils/request'

// 获取尚未完成的已经收入库单据
export function getIntaskList(data) {
	return request({
		url: '/system/terminal/intaskList',
		method: 'get',
		params: data
	})
}

// 根据入库任务ID 获取已经接收的入库任务明细
export function getIntaskitemList(data) {
	return request({
		url: '/system/terminal/intaskitemList',
		method: 'get',
		params: data
	})
}
// 根据库房编码 库位编码校验库位
export function getStoreSiteByRoom(storeRoomNo, storeSiteNo) {
	const data = {
		storeRoomNo,
		storeSiteNo
	}
	return request({
		url: '/system/terminal/getStoreSite',
		method: 'get',
		params: data
	})
}
// 根据库位以及物料获取库存
export function getMtlRepertoryByStoresiteNo(storeSite, matCode) {
	const data = {
		storeSite,
		matCode
	}
	return request({
		url: '/system/terminal/getMtlRepertory',
		method: 'get',
		params: data
	})
}
// 采集提交
export function CommitUpShelves(upShelvesInfos, itemListInfos, taskNo, trayNo, filter, currentWeight, currentCapacity) {
	const data = {
		upShelvesInfos,
		itemListInfos,
		taskNo,
		trayNo,
		filter,
		currentWeight,
		currentCapacity
	}
	return request({
		url: '/system/terminal/commitUpTray',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}

// 根据库房编码 库位编码校验库位
export function CheckBindingTray(trayNo) {
	const data = {
		trayNo
	}
	return request({
		url: '/system/terminal/checkTray',
		method: 'get',
		params: data
	})
}

// 根据库房编码 库位编码校验库位
export function CheckBindingTrayByTaskId(taskId, trayNo, taskType) {
	const data = {
		taskId,
		trayNo,
		taskType
	}
	return request({
		url: '/system/terminal/checkBindingTray',
		method: 'get',
		params: data
	})
}

// 根据库房编码 库位编码校验库位
export function GetMatControl(matCode) {
	const data = {
		matCode
	}
	return request({
		url: '/system/terminal/getMatControl',
		method: 'get',
		params: data
	})
}

// 根据提交托盘上架内容,写指令到WCS
export function CommitUpWmsToWcs(taskId, taskNo, trayNo, startAddr, endAddr) {
	const data = {
		taskId,
		taskNo,
		trayNo,
		startAddr,
		endAddr
	}
	return request({
		url: '/system/terminal/commitUpWmsToWcs',
		method: 'get',
		params: data
	})
}

// 根据提交托盘上架内容,写指令到WCS
export function getPalletItemByTaskID(palletNo) {
	const data = {
		palletNo
	}
	return request({
		url: '/system/terminal/getPalletItemByTaskID',
		method: 'get',
		params: data
	})
}

// 根据提交托盘上架内容,写指令到WCS
export function getWmsToWcsByTaskID(taskComment, taskId, TaskType, queryStr) {
	const data = {
		taskComment,
		taskId,
		TaskType,
		queryStr
	}
	return request({
		url: '/system/terminal/getWmsToWcsByTaskID',
		method: 'get',
		params: data
	})
}

// 根据入库任务ID 获取已经接收的入库任务明细
export function getInTaskPalletNo(data) {
	return request({
		url: '/system/terminal/getInTaskPalletNo',
		method: 'get',
		params: data
	})
}

// 采集提交
export function CommitTrayUpShelves(trayInfos, itemListInfos, taskNo) {
	const data = {
		trayInfos,
		itemListInfos,
		taskNo
	}
	return request({
		url: '/system/terminal/commitTrayUpShelves',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}