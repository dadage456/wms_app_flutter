import upload from '@/utils/upload'
import request from '@/utils/request'

// 获取到货接收已接收未完成单据
export function getArriveSignList(data) {
	return request({
		url: '/system/terminal/arriveSignList',
		method: 'get',
		params: data
	})
}

// 获取到货接收已接收未完成单据
export function getArriveUnSignList(data) {
	return request({
		url: '/system/terminal/arriveUnSignList',
		method: 'get',
		params: data
	})
}

// 接收单据
export function receArriveSign(arrivalsBillid) {
	const data = {
		arrivalsBillid
	}
	return request({
		url: '/system/terminal/receArriveSign',
		method: 'get',
		params: data
	})
}
// 撤销单据
export function cancleArriveSign(arrivalsBillid) {
	const data = {
		arrivalsBillid
	}
	return request({
		url: '/system/terminal/cancleArriveSign',
		method: 'get',
		params: data
	})
}
// 根据到货单ID获取到货单据明细信息
export function getArriveSignDetailList(data) {
	return request({
		url: '/system/terminal/arriveSignDetailList',
		method: 'get',
		params: data
	})
}

// 根据到货单ID获取到货单据明细信息
export function getPmMaterialInfoByQR(QRstring) {
	const data = {
		QRstring
	}
	return request({
		url: '/system/terminal/materialInfo',
		method: 'get',
		params: data
	})
}

// 采集提交
export function CommitSignShelves(upShelvesInfos, itemListInfos, filter) {
	const data = {
		upShelvesInfos,
		itemListInfos,
		filter
	}
	return request({
		url: '/system/terminal/commitSign',
		method: 'POST',
		header: {
			"content-type": "application/json;charset=UTF-8"
		},
		data: JSON.stringify(data)
	})
}