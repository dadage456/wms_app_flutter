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

// 根据库位以及物料获取库存
export function getLSMtlRepertoryByStoresiteNo(storeSite, matCode) {
	const data = {
		storeSite,
		matCode
	}
	return request({
		url: '/system/terminal/getLSMtlRepertoryByStoresiteNo',
		method: 'get',
		params: data
	})
}

// 采集提交
export function CommitUpShelves(upShelvesInfos, itemListInfos, filter) {
	const data = {
		upShelvesInfos,
		itemListInfos,
		filter
	}
	return request({
		url: '/system/terminal/commitUp',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}

// 根据库位以及物料获取库存
export function CommitRCInTaskItem(intaskitemids, roomTag, isCanel) {
	const data = {
		intaskitemids,
		roomTag,
		isCanel
	}
	return request({
		url: '/system/terminal/commitRCInTaskItem',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}

// 采集提交
export function CommitMtlSender(mtlSenderInfos) {
	const data = {
		mtlSenderInfos
	}
	return request({
		url: '/system/terminal/commitMtlSender',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}

// 根据库位以及物料获取库存
export function getMtlQtyByMtlCode(mtlCode, siteNo) {
	const data = {
		mtlCode,
		siteNo
	}
	return request({
		url: '/system/terminal/getMtlQtyByMtlCode',
		method: 'get',
		params: data
	})
}

// 根据库位以及物料获取库存
export function GetRepertoryByBarCode(barcode, currStep, PageIndex, PageSize) {
	const data = {
		barcode,
		currStep,
		PageIndex,
		PageSize
	}
	return request({
		url: '/system/terminal/getRepertoryByBarCode',
		method: 'get',
		params: data
	})
}

// 根据入库任务ID 获取已经接收的入库任务明细
export function getInTaskPalletNoByUserID(data) {
	return request({
		url: '/system/terminal/getInTaskPalletNoByUserID',
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

export function CommitRCInTaskPalletNo(inTaskId, palletNo, roomTag, isCanel) {
	const data = {
		inTaskId,
		palletNo,
		roomTag,
		isCanel
	}
	return request({
		url: '/system/terminal/commitRCInTaskPalletNo',
		method: 'POST',
		params: data
	})
}

// 根据入库任务ID 获取已经接收的入库任务明细
export function getLatestNotice() {
	return request({
		url: '/system/terminal/getLatestNotice',
		method: 'get'
	})
}

// 根据入库任务ID 获取已经接收的入库任务明细
export function getMorNotice() {
	return request({
		url: '/system/terminal/getMorNotice',
		method: 'get'
	})
}

export function getNoticeDetail(noticeId) {
	const data = {
		noticeId
	}
	return request({
		url: '/system/terminal/getNoticeDetail',
		method: 'get',
		params: data
	})
}

export function GetRepertoryBySiteNoMatCode(storesiteno, matcode, batchno) {
	const data = {
		storesiteno,
		matcode,
		batchno
	}
	return request({
		url: '/system/terminal/GetRepertoryBySiteNoMatCode',
		method: 'get',
		params: data
	})
}

export function GetRepertoryByStoresiteNoTransfer(sourceStoresiteNo, targetStoresiteNo) {
	const data = {
		sourceStoresiteNo,
		targetStoresiteNo
	}
	return request({
		url: '/system/terminal/GetRepertoryByStoresiteNoTransfer',
		method: 'get',
		params: data
	})
}
// 采集提交
export function CommitTransfer(transferInfos, filter) {
	const data = {
		transferInfos,
		filter
	}
	return request({
		url: '/system/terminal/commitTransfer',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}
// 获取尚未完成的已经收入库单据
export function selectPdaCollExceptList(data) {
	return request({
		url: '/system/terminal/selectPdaCollExceptList',
		method: 'get',
		params: data
	})
}

// 获取尚未完成的已经收入库单据
export function selectTaskMessageList(data) {
	return request({
		url: '/system/terminal/selectTaskMessageList',
		method: 'get',
		params: data
	})
}

// 获取尚未完成的已经收入库单据
export function selectSysMessageCount(data) {
	return request({
		url: '/system/terminal/selectSysMessageCount',
		method: 'get',
		params: data
	})
}


export function reprocessDconnect(dcConnectid) {
	const data = {
		dcConnectid
	}
	return request({
		url: '/system/terminal/reprocessDconnect',
		method: 'get',
		params: data
	})
}

export function messageConfim(messageId) {
	const data = {
		messageId
	}
	return request({
		url: '/system/terminal/messageConfim',
		method: 'get',
		params: data
	})
}


// 获取尚未完成的已经收入库单据
export function selectPdaCollExceptDetailList(data) {
	return request({
		url: '/system/terminal/selectPdaCollExceptDetailList',
		method: 'get',
		params: data
	})
}

// 获取尚未完成的已经收入库单据
export function selectSapInteExceptList(data) {
	return request({
		url: '/system/terminal/selectSapInteExceptList',
		method: 'get',
		params: data
	})
}

// 查询用户个人信息
export function pushcld(clientid) {
	const data = {
		clientid
	}
  return request({
    url: '/system/push/pushMess',
    method: 'get',
	params: data
  })
  }
