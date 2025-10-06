import upload from '@/utils/upload'
import request from '@/utils/request'

// 获取尚未完成的已经收入库单据
export function getOutaskList(data) {
	return request({
		url: '/system/terminal/outList',
		method: 'get',
		params: data
	})
}

// 根据入库任务ID 获取已经接收的入库任务明细
export function getOutTaskitemList(data) {
	return request({
		url: '/system/terminal/outTaskitemList',
		method: 'get',
		params: data
	})
}

// 根据入库任务ID 获取已经接收的入库任务明细
export function getOutTaskCollitemList(data) {
	return request({
		url: '/system/terminal/getOutTaskItem',
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
export function getMtlRepertoryByStoresiteNo(storesiteno, matcode, erpStoreroom, batchno, sn) {
	const data = {
		storesiteno,
		matcode,
		erpStoreroom,
		batchno,
		sn
	}
	return request({
		url: '/system/terminal/getRepertoryByStoresiteNo',
		method: 'get',
		params: data
	})
}

// 根据库位以及物料获取库存
export function getMtlRepertoryByStoresiteNosn(storesiteno, matcode, erpStoreroom, batchno, sn) {
	const data = {
		storesiteno,
		matcode,
		erpStoreroom,
		batchno,
		sn
	}
	return request({
		url: '/system/terminal/getRepertoryByStoresiteNoSn',
		method: 'get',
		params: data
	})
}


// 根据库位以及物料获取库存
export function getMtlRepertoryByStoresiteNoErp(storesiteno, matcode) {
	const data = {
		storesiteno,
		matcode
	}
	return request({
		url: '/system/terminal/getRepertoryByStoresiteNoErp',
		method: 'get',
		params: data
	})
}
// 采集提交
export function commitDownShelves(downShelvesInfos, itemListInfos) {
	const data = {
		downShelvesInfos,
		itemListInfos
	}
	return request({
		url: '/system/terminal/commitDownShelves',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}

// 根据库位以及物料获取库存
export function CommitRCOutTaskItem(outtaskitemids, roomTag, isCanel) {
	const data = {
		outtaskitemids,
		roomTag,
		isCanel
	}
	return request({
		url: '/system/terminal/commitRCOutTaskItem',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
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

// 根据库房编码 库位编码校验库位
export function GetRoomMatControl(taskId) {
	const data = {
		taskId
	}
	
	return request({
		url: '/system/terminal/getRoomMatControl',
		method: 'get',
		params: data
	})
}

// 根据库房编码 库位编码校验库位
export function GetInOutLocation(locationType) {
	const data = {
		locationType
	}
	return request({
		url: '/system/terminal/getInOutLocation',
		method: 'get',
		params: data
	})
}

export function CommitASWHDownShelves(downShelvesInfos, itemListInfos, invCheckInfos) {
	const data = {
		downShelvesInfos,
		itemListInfos,
		invCheckInfos
	}
	return request({
		url: '/system/terminal/commitASWHDownShelves',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}

// 根据提交托盘上架内容,写指令到WCS
export function CommitDownWmsToWcs(taskId, taskNo, trayNo, startAddr, endAddr, singleFlag) {
	const data = {
		taskId,
		taskNo,
		trayNo,
		startAddr,
		endAddr,
		singleFlag
	}
	return request({
		url: '/system/terminal/commitDownWmsToWcs',
		method: 'get',
		params: data
	})
}
// 根据提交托盘上架内容,写指令到WCS
export function commitInvDownWmsToWcs(taskId, taskNo, trayNo, startAddr, endAddr, singleFlag) {
	const data = {
		taskId,
		taskNo,
		trayNo,
		startAddr,
		endAddr,
		singleFlag
	}
	return request({
		url: '/system/terminal/commitInvDownWmsToWcs',
		method: 'get',
		params: data
	})
}

// 根据提交托盘上架内容,写指令到WCS
export function CommitEmptyTrayWmsToWcs(taskId, taskNo, trayNo, startAddr, endAddr, singleFlag) {
	const data = {
		taskId,
		taskNo,
		trayNo,
		startAddr,
		endAddr,
		singleFlag
	}
	return request({
		url: '/system/terminal/commitEmptyTrayWmsToWcs',
		method: 'get',
		params: data
	})
}

// 获取盘库任务
export function getInventoryTask(data) {
	return request({
		url: '/system/terminal/getInventoryTask',
		method: 'get',
		params: data
	})
}

// 获取盘库任务
export function commitInventoryTask(taskcomment, userId, isCanel) {
	const data = {
		taskcomment,
		userId,
		isCanel
	}
	return request({
		url: '/system/terminal/commitInventoryTask',
		method: 'get',
		params: data
	})
}

// 获取盘库任务明细
export function getInventoryTaskItem(data) {
	return request({
		url: '/system/terminal/getInventoryTaskItem',
		method: 'get',
		params: data
	})
}

export function commitInventoryInfos(inventoryInfos, taskComment) {
	const data = {
		inventoryInfos,
		taskComment
	}
	return request({
		url: '/system/terminal/commitInventoryInfos',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}

// 根据提交托盘上架内容,写指令到WCS
export function CommitResetWmsToWcs(taskId, taskNo, trayNo, startAddr, endAddr) {
	const data = {
		taskId,
		taskNo,
		trayNo,
		startAddr,
		endAddr
	}
	return request({
		url: '/system/terminal/commitResetWmsToWcs',
		method: 'get',
		params: data
	})
}

export function CommitInvResetWmsToWcs(taskId, taskNo, trayNo, startAddr, endAddr) {
	const data = {
		taskId,
		taskNo,
		trayNo,
		startAddr,
		endAddr
	}
	return request({
		url: '/system/terminal/commitInvResetWmsToWcs',
		method: 'get',
		params: data
	})
}

// 根据提交托盘上架内容,写指令到WCS
export function getPalletSiteNo(taskNo) {
	const data = {
		taskNo
	}
	return request({
		url: '/system/terminal/getPalletSiteNo',
		method: 'get',
		params: data
	})
}
export function CommitExceptShelves(exceptShelvesInfos) {
	const data = {
		exceptShelvesInfos
	}
	return request({
		url: '/system/terminal/commitExceptShelves',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}

export function commitTrayDownShelves(downShelvesInfos, itemListInfos) {
	const data = {
		downShelvesInfos,
		itemListInfos
	}
	return request({
		url: '/system/terminal/commitTrayDownShelves',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}

export function commitFinishOutTaskItem(outtaskitemid) {
	const data = {
		outtaskitemid
	}
	return request({
		url: '/system/terminal/commitFinishOutTaskItem',
		method: 'POST',
		params: data
	})

}


// 获取盘库任务明细
export function GetOutTaskPalletNoByUserID(data) {
	return request({
		url: '/system/terminal/getOutTaskPalletNoByUserID',
		method: 'get',
		params: data
	})
}


export function CommitRCOutTaskPalletNo(outTaskId, palletNo, roomTag, isCanel) {
	const data = {
		outTaskId,
		palletNo,
		roomTag,
		isCanel
	}
	return request({
		url: '/system/terminal/commitRCOutTaskPalletNo',
		method: 'POST',
		params: data
	})
}

export function getOutTaskPalletNo(data) {
	return request({
		url: '/system/terminal/getOutTaskPalletNo',
		method: 'get',
		params: data
	})
}

export function CommitASWHPalletNoDownShelves(downShelvesInfos, itemListInfos) {
	const data = {
		downShelvesInfos,
		itemListInfos
	}
	return request({
		url: '/system/terminal/commitASWHPalletNoDownShelves',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}