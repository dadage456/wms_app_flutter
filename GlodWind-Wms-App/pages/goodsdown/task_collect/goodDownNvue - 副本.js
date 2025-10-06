<template>
	<view class="fui-wrap">
		<fui-nav-bar isFixed title="平库下架采集" @leftClick="page_back">
			<fui-icon name="arrowleft"></fui-icon>
		</fui-nav-bar>
		<view style="padding-top: 105rpx">
			<fui-input
				borderTop
				topLeft
				topRight
				borderBottom
				v-model="scanningContent.text"
				:placeholder="placeholder"
				:focus="focus"
				type="digit"
				clearable
				@confirm="search"
			></fui-input>
		</view>
		<fui-row marginBottom="5rpx">
			<fui-col :span="12">
				<fui-card title="库位:" :tag="storeSite"></fui-card>
			</fui-col>
			<fui-col :span="12">
				<fui-card title="库存:" :tag="repqty"></fui-card>
			</fui-col>
		</fui-row>

		<fui-row marginBottom="1rpx">
			<fui-col :span="12">
				<fui-card title="物料:" :tag="BarcodeContent.matcode"></fui-card>
			</fui-col>
			<fui-col :span="12">
				<fui-card title="采集数量:" :tag="collectQty"></fui-card>
			</fui-col>
		</fui-row>
		<fui-row marginBottom="1rpx">
			<fui-col :span="12">
				<fui-card title="名称:" :tag="BarcodeContent.matname"></fui-card>
			</fui-col>
			<fui-col :span="12">
				<fui-card title="批次:" :tag="BarcodeContent.batchno"></fui-card>
			</fui-col>
		</fui-row>
		<fui-row marginBottom="1rpx">
			<fui-col :span="24">
				<fui-card title="序列:" :tag="BarcodeContent.sn"></fui-card>
			</fui-col>
		</fui-row>

		<view class="fui-page__bd">
			<fui-tabs :tabs="tabs" center :current="curTab" selectedColor="#FA2209" @change="onChangeTab"></fui-tabs>
		</view>

		<view :class="{ table_hide: curTab == 1 }">
			<!--如果需要初始化时触发 @selectionChange 事件，将属性 initEmitChange 设为true-->
			<fui-table-weex
				ref="table"
				fixed
				height="665"
				stripe
				selection
				align="left"
				ellipsis
				is-drag
				full
				:itemList="detailListView"
				:header="column1"
				@select="handleCheckItem"
				@selectAll="handleCheckAll"
				@rowClick="rowClick1"
			></fui-table-weex>
		</view>
		<view :class="{ table_hide: curTab == 0 }">
			<!--如果需要初始化时触发 @selectionChange 事件，将属性 initEmitChange 设为true-->
			<fui-table-weex
				ref="table"
				fixed
				height="665"
				stripe
				align="left"
				selection
				isTotal
				ellipsis
				is-drag
				full
				:itemList="detailListViewColl"
				:header="column2"
				@select="handleCheckItem2"
				@selectAll="handleCheckAll2"
			></fui-table-weex>
		</view>

		<fui-bottom-navbar background="#F7F8FA" lineColor="#333" :items="options" left="8" @init="init" @click="onClick"></fui-bottom-navbar>
		<!--气泡框组件使用请查看具体文档-->
		<fui-bubble-box
			width="200"
			:size="28"
			direction="top"
			:show="show"
			:triangle="{ left: 100 }"
			:bottom="height"
			:right="10"
			:items="subItems"
			@click="subClick"
			@close="onClose"
		></fui-bubble-box>
		<scanCode></scanCode>
	</view>
</template>

<script>
import { toast, showConfirm, tansParams } from '@/utils/common';
import { GetDate, GetTaState, inArray, arrayIntersect, debounce, DatasTime, uuid } from '@/common/util.js';
import { getPmMaterialInfoByQR } from '@/api/system/arriveSign';
import { getIntaskitemList, getStoreSiteByRoom, CommitUpShelves } from '@/api/system/goodsUp';
import scanCode from '@/components/scan-code/scan-code.vue';
import {
	commitFinishOutTaskItem,
	getOutTaskCollitemList,
	GetRoomMatControl,
	GetMatControl,
	getMtlRepertoryByStoresiteNo,
	getMtlRepertoryByStoresiteNosn,
	commitDownShelves,
	getMtlRepertoryByStoresiteNoErp
} from '@/api/system/goodsDown';

import { login } from '@/api/login';
import storage from '@/utils/storage';

const tabs = [
	{
		name: `任务列表`,
		value: 'taskall'
	},
	{
		name: `正在采集`,
		value: 'extreing'
	}
];

var collectFlg = '';
var matFoundFlg = '';
/* var storeSite = ''; */
var booCheck = true; //是否校验批次
var erpStoreSite = '';
var batchFountFlg = '0';
var booCheckAagentCode = true; //校验供应商
//采集结果记录
var matCode = '';
var batchNo = '';
var sn = '';
var pdate = '';
var vdays = '';
var matControlFlag = '';
var strMsg = '';
var protype = '';
var storeRoom = ''; //库房编码
var taskNo = '';
var taskId = '';
var siteFlag = 'Y';
var batchFlag = 'Y';
var finishFlag = '';
var taskComment = '';
var workStation = '';
var strKey = '';
var RepQty = 0;
var roomMatControl = '';
var matSendControl = '0';
var mtlCheckMode = '';
var erpRoom = '';
var trayNo = '';
var erpStoreInv = '';
var resFlag = '';

export default {
	components: {
		scanCode
	},
	data() {
		return {
			//数据格式二
			options: [
				{
					text: '采集结果',
					color: '#E55D52'
				},
				{
					text: '提交',
					color: '#F37B1D'
				},
				{
					text: '更多',
					name: 'menu',
					size: 24,
					width: 1
				}
			],
			//二级菜单
			subItems: [
				{
					text: '异常采集'
				},
				{
					text: '报缺'
				}
			],
			height: 100,
			show: false,
			column1: [
				{ prop: 'matcode', label: '物料编码', width: 180 },
				{ prop: 'storesiteno', label: '库位', width: 200 },
				{ prop: 'hintqty', label: '任务数量', width: 130 },
				{ prop: 'collectedqty', label: '采集数量', width: 130, color: '#465CFF' },
				{ prop: 'repqty', label: '结余库存', width: 130 },
				{ prop: 'hintbatchno', label: '批次', width: 300 },
				{ prop: 'sn', label: '序列', width: 300 },
				{ prop: 'storeroomno', label: '库房' },
				{ prop: 'subinventoryCode', label: '子库' },
				{ prop: 'orderno', label: '出库单号', width: 200 },
				{ prop: 'matname', label: '物料名称', width: 200 },
				{ prop: 'matinnercode', label: '物料旧编码', width: 250 },
				{ prop: 'outtaskitemid', label: '任务id' },
				{ prop: 'data1', label: '任务序号' }
			],

			column2: [
				{ prop: 'matcode', label: '物料编码', width: 180 },
				{ prop: 'storesiteno', label: '库位', width: 200 },
				{ prop: 'hintqty', label: '任务数量', width: 130, color: '#465CFF' },
				{ prop: 'collectedqty', label: '采集数量', width: 130 },
				{ prop: 'repqty', label: '结余库存', width: 130 },
				{ prop: 'hintbatchno', label: '批次', width: 300 },
				{ prop: 'sn', label: '序列', width: 300 },
				{ prop: 'storeroomno', label: '库房' },
				{ prop: 'subinventoryCode', label: '子库' },
				{ prop: 'orderno', label: '出库单号', width: 100 },
				{ prop: 'matname', label: '物料名称', width: 100 },
				{ prop: 'matinnercode', label: '物料旧编码', width: 250 },
				{ prop: 'outtaskitemid', label: '任务id' },
				{ prop: 'data1', label: '任务序号' }
			],
			curTab: 0,
			tabs,
			inArray,
			checkedIds: [],
			Step: {
				_2DBarcode: '_2DBarcode',
				Site: 'Site',
				Quantity: 'Quantity'
			},
			MtlCheckMode: {
				Mtl: 'Mtl', // 检查物料
				MtlBatch: 'MtlBatch', // 物料+批号
				MtlSite: 'MtlSite', // 物料+库位
				MtlBatchSite: 'MtlBatchSite' // 物料+批号+库位
			},

			placeholder: '请扫描库位',
			//扫描内容
			scanningContent: { text: '' },
			checkedList: [],
			repqty: 0,
			storeSite: '', //采集的库位
			collectQty: 0,

			//查询条件
			outTaskItem: {
				outtaskno: '',
				storeroomno: '',
				forcesite: '',
				forcebatch: '',
				taskcomment: '',
				taskFinishFlag: '0',
				roomtag: '0',
				workstation: 'N',
				finshFlg: '0',
				sortType: '',
				sortColumn: '',
				searchKey: '',
				beatflag: 'N',
				collecter: this.$store.state.userid
			},
			//采集结果
			BarcodeContent: {
				matcode: '', //物料编码
				qty: '', //采集数量
				matname: '', //物料名称
				batchno: '', //批次
				sn: '', //序列
				pdate: '', //生产日期
				vdays: '', //保质期
				seqctrl: '', //控制方式
				id_old: '' //编码方式 新格式，就格式
			},
			//查询结果
			detailListView: [],
			//查询结果
			detailListViewColl: [],

			horizontal: 'left',
			vertical: 'bottom',
			direction: 'vertical',
			pattern: {
				color: '#7A7E83',
				backgroundColor: '#fff',
				selectedColor: '#007AFF',
				buttonColor: '#007AFF',
				iconColor: '#fff'
			},
			content: [
				{
					iconPath: '/static/images/paixu.png',
					selectedIconPath: '/static/images/paixu.png',
					text: '异常采集',
					active: false
				},
				{
					iconPath: '/static/images/paixu.png',
					selectedIconPath: '/static/images/paixu.png',
					text: '报缺',
					active: false
				}
			],

			dicMtlQty: new Map(), //key: outtaskitemid value: 0:开始采集数  1：本次数量
			dicSeq: new Map(), //key: outtaskitemid value: 0:开始采集数  1：本次数量
			dicInvMtlQty: new Map(),
			collectList: [],
			stocks: [],
			focus: false
		};
	},
	onLoad: function (options) {
		collectFlg = '';
		matFoundFlg = '';
		/* var storeSite = ''; */
		booCheck = true; //是否校验批次
		erpStoreSite = '';
		batchFountFlg = '0';
		booCheckAagentCode = true; //校验供应商
		//采集结果记录
		matCode = '';
		batchNo = '';
		sn = '';
		pdate = '';
		vdays = '';
		matControlFlag = '';
		strMsg = '';
		protype = '';
		storeRoom = ''; //库房编码
		taskNo = '';
		taskId = '';
		siteFlag = 'Y';
		batchFlag = 'Y';
		finishFlag = '';
		taskComment = '';
		workStation = '';
		strKey = '';
		RepQty = 0;
		roomMatControl = '';
		matSendControl = '0';
		mtlCheckMode = '';
		erpRoom = '';
		trayNo = '';
		erpStoreInv = '';
		resFlag = '';

		let collecter1 = this.$store.state.user;
		console.log(collecter1);
		var _this = this;
		let outTask = JSON.parse(decodeURIComponent(options.item));
		_this.outTaskItem.outtaskno = outTask.outtaskno;
		_this.outTaskItem.taskcomment = outTask.taskcomment;
		_this.outTaskItem.forcesite = outTask.forcesite;
		_this.outTaskItem.forcebatch = outTask.forcebatch;
		_this.outTaskItem.workstation = outTask.workstation;

		taskNo = outTask.outtaskno;
		taskId = outTask.outtaskid;
		siteFlag = 'Y';
		batchFlag = 'Y';
		taskComment = outTask.taskcomment;
		workStation = outTask.workstation;
		storeRoom = outTask.storeroomno;

		_this.getList();
		uni.$off('scancodedate'); // 每次进来先 移除全局自定义事件监听器
		uni.$on('scancodedate', function (content) {
			_this.PerformingBarcode_pre(content);
		});
	},

	onShow() {
		setTimeout(() => {
			try {
				console.log('进入onshow');
				let updateflag = uni.getStorageSync('up_updateflag');
				if (updateflag == '1') {
					console.log('进入onshow');
					let value22 = uni.getStorageSync('up_inTaskItemList');
					if (value22) {
						this.detailListView = value22;
						this.stocks = uni.getStorageSync('up_stocks');

						let valueSeq = uni.getStorageSync('up_dicSeq');
						this.dicSeq = new Map(JSON.parse(valueSeq));

						let valueQty = uni.getStorageSync('up_dicMtlQty');
						this.dicMtlQty = new Map(JSON.parse(valueQty));

						this.taskcollAdd(null, this.storeSite);

						uni.setStorage({
							key: 'up_updateflag',
							data: '0', //未修改
							success: function () {
								console.log('采集状态修改标志恢复');
							}
						});
					}
				}
			} catch (e) {
				uni.showModal({
					title: '采集异常',
					showCancel: false,
					content: e
				});
			}
		}, 100);
		var _this = this;
		uni.$off('scancodedate'); // 每次进来先 移除全局自定义事件监听器
		uni.$on('scancodedate', function (content) {
			_this.PerformingBarcode(content);
		});
	},
	onBackPress(options) {
		// 如果是返回按钮，才做执行
		if (options.from === 'backbutton') {
			if (this.stocks.length > 0) {
				uni.showModal({
					title: '提示',
					content: '当前采集记录尚未提交 确定退出采集吗？',
					success: (res) => {
						if (res.confirm) {
							uni.$off('scancodedate');
							uni.reLaunch({
								url: '/pages/goodsdown/goodsDown' // 你可以根据需要调整跳转的页面
							});
						}
					}
				});
				// 禁止默认返回
				return true;
			} else {
				uni.$off('scancodedate');
				uni.reLaunch({
					url: '/pages/goodsdown/goodsDown' // 你可以根据需要调整跳转的页面
				});
				return true;
			}
		}
	},

	methods: {
		initCurTab(options) {
			const app = this;
			if (options.dataType) {
				const indextab = app.tabs.findIndex((item) => item.value == options.dataType);
				app.curTab = indextab > -1 ? indextab : 0;
			}
		},
		onChangeTab(tab) {
			const app = this;
			app.curTab = tab.index;

			console.log(this.curTab);
		},

		//进入采集结果界面
		actionsClick(url, arrivalsBillid) {
			setTimeout(() => {
				uni.navigateTo({
					url: url
				});
			}, 100);
		},
		//进入采集结果界面
		async taskcollAdd(matcode1, storete1) {
			this.detailListViewColl = [];
			let coli = 0;
			let tmpStorete = '';
			if (storete1 != undefined && storete1 != null && storete1.length != 0) {
				for (coli = 0; coli < this.detailListView.length; coli++) {
					tmpStorete = this.detailListView[coli].storesiteno;
					if (storete1 == tmpStorete) {
						this.detailListViewColl.push(this.detailListView[coli]);
					}
				}
			}
			if (this.detailListViewColl.length <= 0) {
				this.curTab = 0;
			} else {
				this.curTab = 1;
			}
		},
		//已接收未完成单据加载
		getList() {
			uni.showLoading({
				title: '加载中'
			});

			getOutTaskCollitemList(this.outTaskItem).then((response) => {
				console.log('收到任务');
				if (response.msg && response.code != '200') {
					uni.showModal({
						title: '采集异常',
						showCancel: false,
						content: response.msg
					});
					return;
				}
				if (response.code == '200') {
					this.detailListView = response.data;
					console.log('列表加载');
					this.GetRoomMatControl(taskId).then((response5) => {
						console.log('获取MatControl');
						if (response5.msg && response5.code != '200') {
							uni.showModal({
								title: '采集异常',
								showCancel: false,
								content: response5.msg
							});
							return;
						}
						if (response5.code == '200') {
							let roomMtlInfo = response5.msg.split('!');
							if (roomMtlInfo[4] != '' && roomMtlInfo[4] != null && roomMtlInfo[4] != undefined) {
								roomMatControl = roomMtlInfo[4];
							} else {
								roomMatControl = '0';
							}

							if (siteFlag == 'Y' && batchFlag == 'Y') {
								mtlCheckMode = this.MtlCheckMode.MtlBatchSite;
							} else if (siteFlag == 'Y' && batchFlag != 'Y') {
								mtlCheckMode = this.MtlCheckMode.MtlSite;
							} else if (siteFlag != 'Y' && batchFlag == 'Y') {
								mtlCheckMode = this.MtlCheckMode.MtlBatch;
							} else {
								mtlCheckMode = this.MtlCheckMode.Mtl;
							}
						}
					});
					uni.setStorage({
						key: 'up_stocks',
						data: null, //未修改
						success: function () {
							console.log('采集结果初始化');
						}
					});
					uni.setStorage({
						key: 'up_updateflag',
						data: '0',
						success: function () {
							console.log('采集状态修改标志初始化');
						}
					});
					uni.setStorage({
						key: 'up_inTaskItemList',
						data: response.data,
						success: function () {
							console.log('采集任务初始化');
						}
					});
					console.log('开始关闭');
					setTimeout(function () {
						console.log('开始关闭2');
						uni.hideLoading();
						console.log('开始关闭3');
					}, 10);
					console.log('开始关闭4');
					if (this.detailListView.length <= 0) {
						uni.showModal({
							title: '采集异常',
							showCancel: false,
							content: '当前任务列表没有待处理任务5！'
						});
					}
				}
			});
		},
		async PerformingBarcode_pre(barcode2) {
			this.PerformingBarcode(barcode2);
		},
		search(event) {
			this.PerformingBarcode(event.detail.value);
		},
		//采集内容处理
		async PerformingBarcode(barcode) {
			try {
				var strSiteCode = '';
				var strBatch = '';
				var strMtlCode = '';
				if (barcode == undefined || barcode == null || barcode.length == 0) {
					this.$set(this.scanningContent, 'text', '');
					throw new Error('采集内容为空,请重新采集');
				}
				let currStep = '';
				//采集内容判断
				//物料编码
				if (barcode.includes('MC') > 0) {
					currStep = this.Step._2DBarcode;
					//库位判断
				} else if (barcode.includes('$KW$')) {
					currStep = this.Step.Site;
				}
				//数量
				else if (this.checkIntAndFloat(barcode)) {
					currStep = this.Step.Quantity;
				} else {
					this.$set(this.scanningContent, 'text', '');
					throw new Error('采集内容不合法！');
				}

				switch (currStep) {
					case this.Step._2DBarcode:
						var BarcodeContent2 = {};
						//物料条码分析
						let response = await this.getPmMaterialInfoByQR_await(barcode);
						if (response.code == '200') {
							BarcodeContent2 = response.data;
						}

						if (BarcodeContent2 == undefined || BarcodeContent2 == null || BarcodeContent2.length == 0) {
							this.$set(this.scanningContent, 'text', '');
							throw new Error('物料条码识别出现问题！');
						}

						//二维码新旧格式
						var newmarttask = BarcodeContent2.id_old;
						//物料控制模式 序列还是批次
						var matControl = BarcodeContent2.seqctrl;

						let response3 = await this.GetMatControl_await(BarcodeContent2.matcode);
						if (response3.code == '200') {
							let mtlInfo = response3.msg.split('!');
							if (mtlInfo[4] != '') {
								matSendControl = mtlInfo[4];
							} else {
								matSendControl = '0';
							}
						}

						if (newmarttask == '0') {
							if (matControl == '0') {
								if (BarcodeContent2.sn == undefined || BarcodeContent2.sn == null || BarcodeContent2.sn == '') {
									this.$set(this.scanningContent, 'text', '');
									throw new Error('物料【' + BarcodeContent2.matcode + '】序列号不能为空');
								}

								if (this.dicSeq.has(BarcodeContent2.matcode + '@' + BarcodeContent2.sn)) {
									matCode = '';
									this.$set(this.scanningContent, 'text', '');
									throw new Error('物料【' + BarcodeContent2.matcode + '】序列号【' + BarcodeContent2.sn + '】不允许重复采集，请确认');
								}

								this.BarcodeContent = BarcodeContent2;
								this.BarcodeContent.batchNo = BarcodeContent2.sn;
								this.BarcodeContent.qty = 1;

								batchNo = '';
								sn = '';
								batchNo = BarcodeContent2.sn;
								sn = BarcodeContent2.sn;
								this.collectQty = 1;

								let QuerySn = 'N';
								let collectStocks2 = this.stocks;

								for (let io = 0; io < collectStocks.length; io++) {
									let upStock2 = collectStocks2[io];
									if (upStock2.sn == BarcodeContent2.sn) {
										QuerySn = 'Y';
									}
								}
								if (QuerySn == 'Y') {
									this.$set(this.scanningContent, 'text', '');
									this.collectQty = 0;
									throw new Error(
										'采集物料【' + BarcodeContent2.matcode + '】序列号【' + BarcodeContent2.sn + '】库位【' + this.storeSite + '】已经采集,不允许重复采集!'
									);
								}
							}
							if (matControl == '1' || matControl == '2') {
								if ((matSendControl == '0' && roomMatControl == '0') || roomMatControl == '1') {
									//旧条码格式 做物料检查，不合格将返回
									/* this.CheckMat(barcodeContent.matcode, barcodeContent.batchno, this.storeSite); */
									/* CheckMat(barcode, BatchNo, storeSite) */
									{
										let barcode = BarcodeContent2.matcode;
										let BatchNo = BarcodeContent2.batchno;
										let storeSite = this.storeSite;

										batchFountFlg = '0';
										let tmpMat = '';
										let tmpSite = '';
										let tmpbatchNo = '';

										for (let i44 = 0; i44 < this.detailListView.length; i44++) {
											tmpMat = this.detailListView[i44].matcode;
											tmpSite = this.detailListView[i44].storesiteno;
											tmpbatchNo = this.detailListView[i44].hintbatchno;
											if (tmpMat == barcode && tmpSite == storeSite && tmpbatchNo == BatchNo) {
												erpRoom = this.detailListView[i44].subinventoryCode;
												batchFountFlg = '1';
												break;
											}
										}
										if (batchFountFlg == '0') {
											for (let i45 = 0; i45 < this.detailListView.length; i45++) {
												tmpMat = this.detailListView[i45].matcode;
												tmpSite = this.detailListView[i45].storesiteno;

												if (tmpMat == barcode && tmpSite == storeSite) {
													erpRoom = this.detailListView[i45].subinventoryCode;
													batchFountFlg = '1';
													break;
												}
											}
										}
									}
									if (batchFountFlg == '0') {
										this.BarcodeContent = null;
										this.$set(this.scanningContent, 'text', '');
										throw new Error('任务明细中物料【' + BarcodeContent2.matcode + '】不存在');
									}
								}
								/* CheckMtlSite */
								//开发函数
								{
									let MtlSiteFlag = 0;
									strSiteCode = this.storeSite;
									strBatch = BarcodeContent2.batchno;
									strMtlCode = BarcodeContent2.matcode;

									if (matControl != '0') {
										MtlSiteFlag = 1;
									}
									if (MtlSiteFlag == 0 && strMtlCode == '' && strMtlCode == null && strMtlCode == undefined) {
										MtlSiteFlag = 1;
									}
									//如果强制库位 库位为空 校验
									if (siteFlag == 'Y') {
										if (MtlSiteFlag == 0 && (strSiteCode == '' || strSiteCode == null || strSiteCode == undefined)) {
											MtlSiteFlag = 1;
										}
									}
									if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
										if (MtlSiteFlag == 0 && (strBatch == '' || strBatch == null || strBatch == undefined)) {
											MtlSiteFlag = 1;
										}
									}

									if (MtlSiteFlag == 0) {
										let tmpMat = '';
										let tmpSite = '';
										let tmpBatch = '';

										let matFind = 'N';
										//强制库位
										if (siteFlag == 'Y') {
											for (let ie = 0; ie < this.detailListView.length; ie++) {
												tmpMat = this.detailListView[ie].matcode;
												tmpSite = this.detailListView[ie].storesiteno;
												tmpBatch = this.detailListView[ie].hintbatchno;

												if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
													if (tmpMat == strMtlCode && tmpBatch == strBatch && tmpSite == strSiteCode) {
														erpRoom = this.detailListView[ie].subinventoryCode;
														matFind = 'Y';
														break;
													}
												} else {
													if (tmpMat == strMtlCode && tmpBatch == strBatch && tmpSite == strSiteCode) {
														erpRoom = this.detailListView[ie].subinventoryCode;
														matFind = 'Y';
														break;
													}
												}
											}

											for (let ie2 = 0; ie2 < this.detailListView.length; ie2++) {
												tmpMat = this.detailListView[ie2].matcode;
												tmpSite = this.detailListView[ie2].storesiteno;
												tmpBatch = this.detailListView[ie2].hintbatchno;

												if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
													if (tmpMat == strMtlCode && tmpBatch == strBatch && tmpSite == strSiteCode) {
														erpRoom = this.detailListView[ie2].subinventoryCode;
														matFind = 'Y';
														break;
													}
												} else {
													if (tmpMat == strMtlCode && tmpSite == strSiteCode) {
														erpRoom = this.detailListView[ie2].subinventoryCode;
														matFind = 'Y';
														break;
													}
												}
											}
											if (matFind == 'N') {
												if (batchFlag == 'Y') {
													this.$set(this.scanningContent, 'text', '');
													throw new Error('采集物料【' + strMtlCode + '】批次【' + strBatch + '】库位【' + strSiteCode + '】不在任务明细中，请核实');
												} else {
													this.$set(this.scanningContent, 'text', '');
													throw new Error('采集物料【' + strMtlCode + '】库位【' + strSiteCode + '】不在任务明细中，请核实');
												}
											}
										} else {
											for (let ie3 = 0; ie3 < this.detailListView.length; ie3++) {
												tmpMat = this.detailListView[ie3].matcode;
												tmpbatchNo = this.detailListView[ie3].hintbatchno;

												if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
													if (tmpMat == strMtlCode && tmpBatch == strBatch) {
														erpRoom = this.detailListView[ie3].subinventoryCode;
														matFind = 'Y';
														break;
													}
												} else {
													if (tmpMat == strMtlCode) {
														erpRoom = this.detailListView[ie3].subinventoryCode;
														matFind = 'Y';
														break;
													}
												}
											}
											if (matFind == 'N') {
												if (batchFlag == 'Y' && matControl == '0') {
													this.$set(this.scanningContent, 'text', '');
													throw new Error('采集物料【' + strMtlCode + '】批次【' + strBatch + '】不在任务明细中，请核实');
												}
												if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
													this.$set(this.scanningContent, 'text', '');
													throw new Error('采集物料【' + strMtlCode + '】批次【' + strBatch + '】不在任务明细中，请核实');
												} else {
													this.$set(this.scanningContent, 'text', '');
													throw new Error('采集物料【' + strMtlCode + '】不在任务明细中，请核实');
												}
											}
										}
									}
								}
								sn = '';
								batchNo = '';
								this.BarcodeContent = BarcodeContent2;
								batchNo = BarcodeContent2.sn;
							} else {
								this.$set(this.scanningContent, 'text', '');
								throw new Error('物料' + BarcodeContent2.matcode + '编码控制维护值维护不合法');
							}
						} else {
							if (matControl == '0') {
								sn = '';
								batchNo = '';

								if (BarcodeContent2.sn == undefined || BarcodeContent2.sn == null || BarcodeContent2.sn == '') {
									this.$set(this.scanningContent, 'text', '');
									throw new Error('物料【' + BarcodeContent2.matcode + '】的序列号为空，不允许采集，请确认');
								}
								batchNo = BarcodeContent2.batchno;

								if (batchNo == null || batchNo == '' || batchNo == undefined) {
									batchNo = barcodeContent.sn;
								}
								sn = BarcodeContent2.sn;

								this.BarcodeContent = BarcodeContent2;
								this.collectQty = 1;

								if (this.dicSeq.has(BarcodeContent2.matcode + '@' + BarcodeContent2.sn)) {
									matCode = '';
									this.collectQty = 0;
									this.$set(this.scanningContent, 'text', '');
									this.collectQty = null;
									throw new Error('物料【' + BarcodeContent2.matcode + '】序列号【' + BarcodeContent2.sn + '】不允许重复采集，请确认');
								}
							} else if (matControl == '1' || matControl == '2') {
								if (BarcodeContent2.batchno == undefined || BarcodeContent2.batchno == null || BarcodeContent2.batchno == '') {
									this.$set(this.scanningContent, 'text', '');
									throw new Error('物料【' + BarcodeContent2.matcode + '】批次号不能为空');
								}

								if ((matSendControl == '0' && roomMatControl == '0') || roomMatControl == '1') {
									/* this.CheckMat(BarcodeContent2.matcode, BarcodeContent2.batchno, this.storeSite); */
									/* CheckMat(barcode, BatchNo, storeSite) */
									{
										let barcode = BarcodeContent2.matcode;
										let BatchNo = BarcodeContent2.batchno;
										let storeSite = this.storeSite;

										batchFountFlg = '0';
										let tmpMat = '';
										let tmpSite = '';
										let tmpbatchNo = '';

										for (let i44 = 0; i44 < this.detailListView.length; i44++) {
											tmpMat = this.detailListView[i44].matcode;
											tmpSite = this.detailListView[i44].storesiteno;
											tmpbatchNo = this.detailListView[i44].hintbatchno;
											if (tmpMat == barcode && tmpSite == storeSite && tmpbatchNo == BatchNo) {
												erpRoom = this.detailListView[i44].subinventoryCode;
												batchFountFlg = '1';
												break;
											}
										}
										if (batchFountFlg == '0') {
											for (let i45 = 0; i45 < this.detailListView.length; i45++) {
												tmpMat = this.detailListView[i45].matcode;
												tmpSite = this.detailListView[i45].storesiteno;

												if (tmpMat == barcode && tmpSite == storeSite) {
													erpRoom = this.detailListView[i45].subinventoryCode;
													batchFountFlg = '1';
													break;
												}
											}
										}
									}
									if (batchFountFlg == '0') {
										this.BarcodeContent = null;
										this.$set(this.scanningContent, 'text', '');
										throw new Error('任务明细中物料【' + BarcodeContent2.matcode + '】不存在');
									}
									//CheckMtlSite 校验物料开始
									{
										let MtlSiteFlag = 0;
										strSiteCode = this.storeSite;
										strBatch = BarcodeContent2.batchno;
										strMtlCode = BarcodeContent2.matcode;

										if (matControl == '0') {
											MtlSiteFlag = 1;
										}
										if (MtlSiteFlag == 0 && strMtlCode == '' && strMtlCode == null && strMtlCode == undefined) {
											MtlSiteFlag = 1;
										}
										//如果强制库位 库位为空 校验
										if (siteFlag == 'Y') {
											if (MtlSiteFlag == 0 && (strSiteCode == '' || strSiteCode == null || strSiteCode == undefined)) {
												MtlSiteFlag = 1;
											}
										}
										if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
											if (MtlSiteFlag == 0 && (strBatch == '' || strBatch == null || strBatch == undefined)) {
												MtlSiteFlag = 1;
											}
										}

										if (MtlSiteFlag == 0) {
											let tmpMat = '';
											let tmpSite = '';
											let tmpBatch = '';

											let matFind = 'N';
											//强制库位
											if (siteFlag == 'Y') {
												for (let ie = 0; ie < this.detailListView.length; ie++) {
													tmpMat = this.detailListView[ie].matcode;
													tmpSite = this.detailListView[ie].storesiteno;
													tmpBatch = this.detailListView[ie].hintbatchno;

													if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
														if (tmpMat == strMtlCode && tmpBatch == strBatch && tmpSite == strSiteCode) {
															erpRoom = this.detailListView[ie].subinventoryCode;
															matFind = 'Y';
															break;
														}
													} else {
														if (tmpMat == strMtlCode && tmpBatch == strBatch && tmpSite == strSiteCode) {
															erpRoom = this.detailListView[ie].subinventoryCode;
															matFind = 'Y';
															break;
														}
													}
												}

												for (let ie2 = 0; ie2 < this.detailListView.length; ie2++) {
													tmpMat = this.detailListView[ie2].matcode;
													tmpSite = this.detailListView[ie2].storesiteno;
													tmpBatch = this.detailListView[ie2].hintbatchno;

													if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
														if (tmpMat == strMtlCode && tmpBatch == strBatch && tmpSite == strSiteCode) {
															erpRoom = this.detailListView[ie2].subinventoryCode;
															matFind = 'Y';
															break;
														}
													} else {
														if (tmpMat == strMtlCode && tmpSite == strSiteCode) {
															erpRoom = this.detailListView[ie2].subinventoryCode;
															matFind = 'Y';
															break;
														}
													}
												}
												if (matFind == 'N') {
													if (batchFlag == 'Y') {
														this.$set(this.scanningContent, 'text', '');
														throw new Error('采集物料【' + strMtlCode + '】批次【' + strBatch + '】库位【' + strSiteCode + '】不在任务明细中，请核实');
													} else {
														this.$set(this.scanningContent, 'text', '');
														throw new Error('采集物料【' + strMtlCode + '】库位【' + strSiteCode + '】不在任务明细中，请核实');
													}
												}
											} else {
												for (let ie3 = 0; ie3 < this.detailListView.length; ie3++) {
													tmpMat = this.detailListView[ie3].matcode;
													tmpbatchNo = this.detailListView[ie3].hintbatchno;

													if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
														if (tmpMat == strMtlCode && tmpBatch == strBatch) {
															erpRoom = this.detailListView[ie3].subinventoryCode;
															matFind = 'Y';
															break;
														}
													} else {
														if (tmpMat == strMtlCode) {
															erpRoom = this.detailListView[ie3].subinventoryCode;
															matFind = 'Y';
															break;
														}
													}
												}
												if (matFind == 'N') {
													if (batchFlag == 'Y' && matControl == '0') {
														this.$set(this.scanningContent, 'text', '');
														throw new Error('采集物料【' + strMtlCode + '】批次【' + strBatch + '】不在任务明细中，请核实');
													}
													if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
														this.$set(this.scanningContent, 'text', '');
														throw new Error('采集物料【' + strMtlCode + '】批次【' + strBatch + '】不在任务明细中，请核实');
													} else {
														this.$set(this.scanningContent, 'text', '');
														throw new Error('采集物料【' + strMtlCode + '】不在任务明细中，请核实');
													}
												}
											}
										}
									}
								}

								batchNo = BarcodeContent2.batchno == undefined || BarcodeContent2.batchno == '' || BarcodeContent2.batchno == null ? '' : BarcodeContent2.batchno;
								sn = '';
							} else {
								this.$set(this.scanningContent, 'text', '');
								throw new Error('物料' + BarcodeContent2.matcode + '编码控制维护值维护不合法');
							}

							matCode = BarcodeContent2.matcode;

							matControlFlag = matControl;

							this.BarcodeContent = BarcodeContent2;
						}
						this.$set(this.scanningContent, 'text', '');

						resFlag = '0';
						/*  this.checkInv(0, this.storeSite); */
						/*  checkInv(collectQty, storeSite) */
						{
							let collectQty1 = 0;
							let storeSite = this.storeSite;

							var RepertoryList = [];
							let strRepQty = '';

							if (matCode != null && matCode != '' && matCode != undefined && storeSite != null && storeSite != '' && storeSite != undefined) {
								if (matControlFlag == '1' || matControlFlag == '2') {
									let responsesto = await this.getMtlRepertoryByStoresiteNo_await(storeSite, matCode);
									if (responsesto.code == '200') {
										RepertoryList = responsesto.data;

										let repqtySum2 = null;
										for (let ai2 = 0; ai2 < RepertoryList.length; ai2++) {
											repqtySum2 += RepertoryList[ai2].repqty;
										}
										this.repqty = repqtySum2;

										if (repqtySum2 != null && repqtySum2 != '' && repqtySum2 != undefined) {
											RepQty = repqtySum2;
										}

										let drcheck = [];
										strKey = storeSite + matCode + batchNo;
										if (!(erpRoom == null || erpRoom == '' || erpRoom == undefined)) {
											let repqtySum3 = 0;
											for (let ai3 = 0; ai3 < RepertoryList.length; ai3++) {
												if (RepertoryList[ai3].erpStoreroom == erpRoom && RepertoryList[ai3].batchno == batchNo) {
													repqtySum3 += RepertoryList[ai3].repqty;
													drcheck.push(RepertoryList[ai3]);
												}
											}
											RepQty = repqtySum3;
										} else {
											let repqtySum4 = 0;
											for (let ai4 = 0; ai4 < RepertoryList.length; ai4++) {
												if (RepertoryList[ai4].batchno == batchNo) {
													repqtySum4 += RepertoryList[ai4].repqty;
													drcheck.push(RepertoryList[ai4]);
												}
											}
											RepQty = repqtySum4;
										}

										if (drcheck.length <= 0) {
											throw new Error('物料【' + matCode + '】批次【' + batchNo + '】在库位【' + this.storeSite + '】不存在，请确认');
										}

										if (RepertoryList <= 0) {
											throw new Error('物料【' + matCode + '】批次【' + batchNo + '】 在库位【' + this.storeSite + '】不存在，请确认');
										}
										//库存ERP子库
										erpStoreInv = RepertoryList[0].erpStoreroom;
										if (!(erpRoom == null || erpRoom == '' || erpRoom == undefined)) {
											if (!(erpStoreInv == erpRoom)) {
												throw new Error('当前物料明细指定子库【' + erpRoom + '】与当前库位的物料批次子库【' + erpStoreInv + '】存在不一致，请确认');
											}
										}
									}
								} else {
									let repqtySum31 = 0;
									let repqtySum41 = 0;
									let responsestosn = await this.getMtlRepertoryByStoresiteNosn_await(storeSite, matCode, null, null, null);
									if (responsestosn.code == '200') {
										RepertoryList = responsestosn.data;

										let repqtySum2 = RepertoryList[0].repqty;
										this.repqty = repqtySum2;

										if (repqtySum2 <= 0) {
											this.collectQty = 0;
											throw new Error('物料【' + matCode + '】批次【' + batchNo + '】序列【' + sn + '】 在库位【' + this.storeSite + '】不存在，请确认');
										}
										if (repqtySum2 != null && repqtySum2 != '' && repqtySum2 != undefined) {
											RepQty = repqtySum2;
										}

										strKey = storeSite + matCode + sn;
										let drcheck1 = [];

										if (!(erpRoom == null || erpRoom == '' || erpRoom == undefined)) {
											let responsestosnErp = await this.getMtlRepertoryByStoresiteNosn_await(storeSite, matCode, erpRoom, batchNo, sn);
											if (responsestosnErp.code == '200') {
												RepertoryList = responsestosnErp.data;
												repqtySum31 = RepertoryList[0].repqty;
											}
											RepQty = repqtySum31;
										} else {
											let responsestosnBatch = await this.getMtlRepertoryByStoresiteNosn_await(storeSite, matCode, null, batchNo, sn);
											if (responsestosnBatch.code == '200') {
												RepertoryList = responsestosnBatch.data;
												repqtySum41 = RepertoryList[0].repqty;
											}
											RepQty = repqtySum41;
										}

										if (repqtySum31 <= 0 && repqtySum41 <= 0) {
											this.collectQty = 0;
											throw new Error('物料【' + matCode + '】批次【' + batchNo + '】序列【' + sn + '】在库位【' + storeSite + '】不存在，请确认');
										}

										let responsestosnErp = await this.getMtlRepertoryByStoresiteNoErp_await(storeSite, matCode);
										if (responsestosnErp.code == '200') {
											RepertoryList = responsestosnErp.data;

											erpStoreInv = RepertoryList[0].erpStoreroom;
											if (!(erpRoom == null || erpRoom == '' || erpRoom == undefined)) {
												if (!(erpStoreInv == erpRoom)) {
													throw new Error('当前物料明细指定子库【' + erpRoom + '】与当前库位的物料批次子库【' + erpStoreInv + '】存在不一致，请确认');
												}
											}
										}
									}
								}
							}
						}

						await this.taskcollAdd(null, this.storeSite);
						break;
					case this.Step.Site:
						var str1 = barcode;
						let sArry = str1.split('$');

						/* async CheckSite(siteCode) */
						{
							let responsewe = await this.getStoreSiteByRoom_await(storeRoom, sArry[2]);
							if (responsewe.code == '200') {
								let siteList = responsewe.data;
								//console.log('siteList.length' + siteList.length);
								if (siteList.length <= 0) {
									throw new Error('库房【' + storeRoom + '】下无库位号【' + sArry[2] + '】');
								}

								if (siteList[0].isfrozen != '0') {
									throw new Error('库位【' + sArry[2] + '】被锁定或者冻结');
								}
							}
						}

						if ((matSendControl == '0' && roomMatControl == '0') || roomMatControl == '1') {
							//校验强制批次
							/* CheckMtlSite */
							//开发函数
							{
								let MtlSiteFlag = 0;
								strSiteCode = this.storeSite;
								strBatch = batchNo;
								strMtlCode = matCode;

								if (matControl != '0') {
									MtlSiteFlag = 1;
								}
								if (MtlSiteFlag == 0 && strMtlCode == '' && strMtlCode == null && strMtlCode == undefined) {
									MtlSiteFlag = 1;
								}
								//如果强制库位 库位为空 校验
								if (siteFlag == 'Y') {
									if (MtlSiteFlag == 0 && (strSiteCode == '' || strSiteCode == null || strSiteCode == undefined)) {
										MtlSiteFlag = 1;
									}
								}
								if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
									if (MtlSiteFlag == 0 && (strBatch == '' || strBatch == null || strBatch == undefined)) {
										MtlSiteFlag = 1;
									}
								}

								if (MtlSiteFlag == 0) {
									let tmpMat = '';
									let tmpSite = '';
									let tmpBatch = '';

									let matFind = 'N';
									//强制库位
									if (siteFlag == 'Y') {
										for (let ie = 0; ie < this.detailListView.length; ie++) {
											tmpMat = this.detailListView[ie].matcode;
											tmpSite = this.detailListView[ie].storesiteno;
											tmpBatch = this.detailListView[ie].hintbatchno;

											if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
												if (tmpMat == strMtlCode && tmpBatch == strBatch && tmpSite == strSiteCode) {
													erpRoom = this.detailListView[ie].subinventoryCode;
													matFind = 'Y';
													break;
												}
											} else {
												if (tmpMat == strMtlCode && tmpBatch == strBatch && tmpSite == strSiteCode) {
													erpRoom = this.detailListView[ie].subinventoryCode;
													matFind = 'Y';
													break;
												}
											}
										}

										for (let ie2 = 0; ie2 < this.detailListView.length; ie2++) {
											tmpMat = this.detailListView[ie2].matcode;
											tmpSite = this.detailListView[ie2].storesiteno;
											tmpBatch = this.detailListView[ie2].hintbatchno;

											if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
												if (tmpMat == strMtlCode && tmpBatch == strBatch && tmpSite == strSiteCode) {
													erpRoom = this.detailListView[ie2].subinventoryCode;
													matFind = 'Y';
													break;
												}
											} else {
												if (tmpMat == strMtlCode && tmpSite == strSiteCode) {
													erpRoom = this.detailListView[ie2].subinventoryCode;
													matFind = 'Y';
													break;
												}
											}
										}
										if (matFind == 'N') {
											if (batchFlag == 'Y') {
												this.$set(this.scanningContent, 'text', '');
												throw new Error('采集物料【' + strMtlCode + '】批次【' + strBatch + '】库位【' + strSiteCode + '】不在任务明细中，请核实');
											} else {
												this.$set(this.scanningContent, 'text', '');
												throw new Error('采集物料【' + strMtlCode + '】库位【' + strSiteCode + '】不在任务明细中，请核实');
											}
										}
									} else {
										for (let ie3 = 0; ie3 < this.detailListView.length; ie3++) {
											tmpMat = this.detailListView[ie3].matcode;
											tmpbatchNo = this.detailListView[ie3].hintbatchno;

											if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
												if (tmpMat == strMtlCode && tmpBatch == strBatch) {
													erpRoom = this.detailListView[ie3].subinventoryCode;
													matFind = 'Y';
													break;
												}
											} else {
												if (tmpMat == strMtlCode) {
													erpRoom = this.detailListView[ie3].subinventoryCode;
													matFind = 'Y';
													break;
												}
											}
										}
										if (matFind == 'N') {
											if (batchFlag == 'Y' && matControl == '0') {
												this.$set(this.scanningContent, 'text', '');
												throw new Error('采集物料【' + strMtlCode + '】批次【' + strBatch + '】不在任务明细中，请核实');
											}
											if (batchFlag == 'Y' && (matControl == '1' || matControl == '2')) {
												this.$set(this.scanningContent, 'text', '');
												throw new Error('采集物料【' + strMtlCode + '】批次【' + strBatch + '】不在任务明细中，请核实');
											} else {
												this.$set(this.scanningContent, 'text', '');
												throw new Error('采集物料【' + strMtlCode + '】不在任务明细中，请核实');
											}
										}
									}
								}
							}
						}

						console.log('456');
						this.storeSite = sArry[2];
						console.log('storeSite:' + this.storeSite);
						this.$set(this.scanningContent, 'text', '');
						/* await this.checkInv(0, this.storeSite); */
						{
							let collectQty1 = 0;
							let storeSite = this.storeSite;

							var RepertoryList = [];
							let strRepQty = '';

							if (matCode != null && matCode != '' && matCode != undefined && storeSite != null && storeSite != '' && storeSite != undefined) {
								if (matControlFlag == '1' || matControlFlag == '2') {
									let responsesto = await this.getMtlRepertoryByStoresiteNo_await(storeSite, matCode);
									if (responsesto.code == '200') {
										RepertoryList = responsesto.data;

										let repqtySum2 = null;
										for (let ai2 = 0; ai2 < RepertoryList.length; ai2++) {
											repqtySum2 += RepertoryList[ai2].repqty;
										}
										this.repqty = repqtySum2;

										if (repqtySum2 != null && repqtySum2 != '' && repqtySum2 != undefined) {
											RepQty = repqtySum2;
										}

										let drcheck = [];
										strKey = storeSite + matCode + batchNo;
										if (!(erpRoom == null || erpRoom == '' || erpRoom == undefined)) {
											let repqtySum3 = 0;
											for (let ai3 = 0; ai3 < RepertoryList.length; ai3++) {
												if (RepertoryList[ai3].erpStoreroom == erpRoom && RepertoryList[ai3].batchno == batchNo) {
													repqtySum3 += RepertoryList[ai3].repqty;
													drcheck.push(RepertoryList[ai3]);
												}
											}
											RepQty = repqtySum3;
										} else {
											let repqtySum4 = 0;
											for (let ai4 = 0; ai4 < RepertoryList.length; ai4++) {
												if (RepertoryList[ai4].batchno == batchNo) {
													repqtySum4 += RepertoryList[ai4].repqty;
													drcheck.push(RepertoryList[ai4]);
												}
											}
											RepQty = repqtySum4;
										}

										if (drcheck.length <= 0) {
											throw new Error('物料【' + matCode + '】批次【' + batchNo + '】在库位【' + this.storeSite + '】不存在，请确认');
										}

										if (RepertoryList <= 0) {
											throw new Error('物料【' + matCode + '】批次【' + batchNo + '】 在库位【' + this.storeSite + '】不存在，请确认');
										}
										//库存ERP子库
										erpStoreInv = RepertoryList[0].erpStoreroom;
										if (!(erpRoom == null || erpRoom == '' || erpRoom == undefined)) {
											if (!(erpStoreInv == erpRoom)) {
												throw new Error('当前物料明细指定子库【' + erpRoom + '】与当前库位的物料批次子库【' + erpStoreInv + '】存在不一致，请确认');
											}
										}
									}
								} else {
									let repqtySum31 = 0;
									let repqtySum41 = 0;
									let responsestosn = await this.getMtlRepertoryByStoresiteNosn_await(storeSite, matCode, null, null, null);

									if (responsestosn.code == '200') {
										RepertoryList = responsestosn.data;

										let repqtySum2 = RepertoryList[0].repqty;
										this.repqty = repqtySum2;

										if (repqtySum2 <= 0) {
											this.collectQty = 0;
											throw new Error('物料【' + matCode + '】批次【' + batchNo + '】序列【' + sn + '】 在库位【' + this.storeSite + '】不存在，请确认');
										}
										if (repqtySum2 != null && repqtySum2 != '' && repqtySum2 != undefined) {
											RepQty = repqtySum2;
										}

										strKey = storeSite + matCode + sn;
										let drcheck1 = [];

										if (!(erpRoom == null || erpRoom == '' || erpRoom == undefined)) {
											let responsestosnErp = await this.getMtlRepertoryByStoresiteNosn_await(storeSite, matCode, erpRoom, batchNo, sn);
											if (responsestosnErp.code == '200') {
												RepertoryList = responsestosnErp.data;
												repqtySum31 = RepertoryList[0].repqty;
											}
											RepQty = repqtySum31;
										} else {
											let responsestosnBatch = await this.getMtlRepertoryByStoresiteNosn_await(storeSite, matCode, null, batchNo, sn);
											if (responsestosnBatch.code == '200') {
												RepertoryList = responsestosnBatch.data;
												repqtySum41 = RepertoryList[0].repqty;
											}
											RepQty = repqtySum41;
										}

										if (repqtySum31 <= 0 && repqtySum41 <= 0) {
											this.collectQty = 0;
											throw new Error('物料【' + matCode + '】批次【' + batchNo + '】序列【' + sn + '】在库位【' + storeSite + '】不存在，请确认');
										}
										let responsestosnErp = await this.getMtlRepertoryByStoresiteNoErp_await(storeSite, matCode);
										if (responsestosnErp.code == '200') {
											RepertoryList = responsestosnErp.data;

											erpStoreInv = RepertoryList[0].erpStoreroom;
											if (!(erpRoom == null || erpRoom == '' || erpRoom == undefined)) {
												if (!(erpStoreInv == erpRoom)) {
													throw new Error('当前物料明细指定子库【' + erpRoom + '】与当前库位的物料批次子库【' + erpStoreInv + '】存在不一致，请确认');
												}
											}
										}
									}
								}
							}
						}
						await this.taskcollAdd(null, this.storeSite);
						break;
					case this.Step.Quantity:
						if (sn != undefined && sn != '' && sn != null && sn != undefined) {
							throw new Error('已采集序列号无需采集数量，请扫描二维码');
						}
						this.collectQty = parseFloat(barcode);
						break;

					default:
						break;
				}

				strMsg = await this.getPlaceMsg();
				//表示条码都扫描完毕
				if (strMsg == '') {
					/* await this.DealQuantity(this.collectQty, matControlFlag); */
					/* async DealQuantity(qty, matFlag) */
					{
						let qty = this.collectQty;
						let matFlag = matControlFlag;

						/*
							var matCode = this.BarcodeContent.matcode;
							var batchNo = this.BarcodeContent.batchno;
							var sn = null;
		                   */
						matFlag = Number(matFlag);
						if (matFlag == undefined || matFlag == null || matFlag.length == 0) {
							throw new Error('获取物料编码属性失败');
						}
						if (matFlag == 0) {
							sn = this.BarcodeContent.sn;
						}
						if (qty <= 0) {
							throw new Error('采集数量必须大于0');
						}

						var tmpRepQty = 0;
						var repQty = 0;
						var taskQty = 0;
						var tmpQty = 0;

						if (!(this.repqty == '' || this.repqty == null || this.repqty == undefined)) {
							repQty = this.repqty;
						} else {
							repQty = 0;
						}

						var exsitFlag = false;

						var tatalTaskQty = 0; //当前物料总计划数
						var tatalTmpQty = 0; //当前物料总扫描数
						var tmpNotmatQty = 0;
						var qiangzhicajiFlag = 0;
						var tatalNotmatQty = 0; //当前物料总扫描数
						var outtaskitemid = '';

						var tmpMat = '';
						var tmpBatch = '';
						var tmpSN = '';
						var tmpSite = '';

						{
							let decRepqty = 0;

							if (this.dicInvMtlQty.has(strKey)) {
								decRepqty = this.dicInvMtlQty.get(strKey);
							}
							if (RepQty - decRepqty < qty) {
								this.collectQty = 0;
								throw new Error(
									'库位【' + this.storeSite + '】物料【' + matCode + '】的库存【' + (RepQty - decRepqty) + '】小于本次移出库存【' + qty + '】，请确认'
								);
							}
						}
						//统计当前物料总扫描数和总计划数
						for (let i2 = 0; i2 < this.detailListView.length; i2++) {
							let tmpMat = this.detailListView[i2].matcode; //物料
							if (tmpMat != matCode) {
								continue; //如果物料不是当前输入的物料 继续
							}

							if ((matFlag == 1 || matFlag == 2) && ((matSendControl == '0' && roomMatControl == '0') || roomMatControl == '1')) {
								//批次管控
								if (mtlCheckMode == this.MtlCheckMode.MtlBatch) {
									tmpBatch = this.detailListView[i2].hintbatchno;
									if (tmpBatch != batchNo) {
										continue; //如果物料批次跟当前输入不一致 继续
									}
								} else if (mtlCheckMode == this.MtlCheckMode.MtlBatchSite) {
									tmpBatch = this.detailListView[i2].hintbatchno;
									if (tmpBatch != batchNo) {
										continue; //如果物料批次跟当前输入不一致 继续
									}
									tmpSite = this.detailListView[i2].storesiteno;
									if (tmpSite != this.storeSite) {
										continue; //如果库位跟当前输入的不一致 继续
									}
								} else if (mtlCheckMode == this.MtlCheckMode.MtlSite) {
									tmpSite = this.detailListView[i2].storesiteno;
									if (tmpSite != this.storeSite) {
										continue; //如果库位跟当前输入的不一致 继续
									}
								}
							}

							taskQty = parseFloat(this.detailListView[i2].hintqty);
							tmpQty = parseFloat(this.detailListView[i2].collectedqty);
							tatalTaskQty += taskQty;
							tatalTmpQty += tmpQty;
						}

						//校验数量是否足够
						if (tatalTmpQty + qty > tatalTaskQty) {
							this.collectQty = 0;
							throw new Error('本次采集数量【' + qty + '】大于剩余可采集数量【' + (tatalTaskQty - tatalTmpQty) + '】');
						}

						let decQty = qty;
						var ls = new Map();
						var dicMtlOperatin = new Map();

						for (let h1 = 0; h1 < this.detailListView.length; h1++) {
							tmpMat = this.detailListView[h1].matcode; //物料
							tmpSite = this.detailListView[h1].storesiteno; //物料

							tmpQty = this.detailListView[h1].repqty;

							//计算单个物料剩余库存sss
							if (tmpMat == matCode && tmpSite == this.storeSite && !(tmpQty == null || tmpQty == '' || tmpQty == undefined)) {
								tmpRepQty = parseFloat(this.detailListView[h1].repqty);
							}
							if (repQty > 0 && tmpRepQty > 0 && repQty > tmpRepQty) {
								repQty = tmpRepQty;
							}
						}

						for (let i1 = 0; i1 < this.detailListView.length; i1++) {
							if (decQty <= 0) {
								break;
							}
							tmpMat = this.detailListView[i1].matcode; //物料
							tmpSite = this.detailListView[i1].storesiteno; //物料
							taskQty = parseFloat(this.detailListView[i1].hintqty);
							tmpQty = parseFloat(this.detailListView[i1].collectedqty);

							if ((tmpMat != matCode || tmpSite != this.storeSite) && matFlag != 0 && ((matSendControl == '0' && roomMatControl == '0') || roomMatControl == '1')) {
								continue; //如果物料不是当前输入的物料 继续
							}

							if (tmpMat != matCode && matFlag == 0 && ((matSendControl == '0' && roomMatControl == '0') || roomMatControl == '1')) {
								continue; //如果物料不是当前输入的物料 继续
							}
							if (tmpMat != matCode) {
								continue;
							}
							if (taskQty == tmpQty) {
								continue;
							}

							switch (matFlag) {
								case 0:
									exsitFlag = true;
									break;
								case 1:
									if ((matSendControl == '0' && roomMatControl == '0') || roomMatControl == '1') {
										if (mtlCheckMode == this.MtlCheckMode.MtlBatch) {
											tmpBatch = this.detailListView[i1].hintbatchno;
											if (tmpBatch != batchNo) {
												continue; //如果物料批次跟当前输入不一致 继续
											}
										} else if (mtlCheckMode == this.MtlCheckMode.MtlBatchSite) {
											tmpBatch = this.detailListView[i1].hintbatchno;
											if (tmpBatch != batchNo) {
												continue; //如果物料批次跟当前输入不一致 继续
											}
											tmpSite = this.detailListView[i1].storesiteno;
											if (tmpSite != this.storeSite) {
												continue; //如果库位跟当前输入的不一致 继续
											}
										} else if (mtlCheckMode == this.MtlCheckMode.MtlSite) {
											tmpSite = this.detailListView[i1].storesiteno;
											if (tmpSite != this.storeSite) {
												continue; //如果库位跟当前输入的不一致 继续
											}
										}
									}
									break;
								case 2:
									if ((matSendControl == '0' && roomMatControl == '0') || roomMatControl == '1') {
										if (mtlCheckMode == this.MtlCheckMode.MtlBatch) {
											tmpBatch = this.detailListView[i1].hintbatchno;
											if (tmpBatch != batchNo) {
												continue; //如果物料批次跟当前输入不一致 继续
											}
										} else if (mtlCheckMode == this.MtlCheckMode.MtlBatchSite) {
											tmpBatch = this.detailListView[i1].hintbatchno;
											if (tmpBatch != batchNo) {
												continue; //如果物料批次跟当前输入不一致 继续
											}
											tmpSite = this.detailListView[i1].storesiteno;
											if (tmpSite != this.storeSite) {
												continue; //如果库位跟当前输入的不一致 继续
											}
										} else if (mtlCheckMode == this.MtlCheckMode.MtlSite) {
											tmpSite = this.detailListView[i1].storesiteno;
											if (tmpSite != this.storeSite) {
												continue; //如果库位跟当前输入的不一致 继续
											}
										}
									}
									break;
							}

							outtaskitemid = this.detailListView[i1].outtaskitemid;
							if (!this.dicMtlQty.has(outtaskitemid)) {
								let ls = [];
								ls[0] = tmpQty;
								ls[1] = '0';
								ls[2] = tmpMat;
								this.dicMtlQty.set(outtaskitemid, ls);
							}

							if (taskQty - tmpQty >= decQty) {
								//表示足够扣
								/* this.detailListView[i1].collectedqty = tmpQty + decQty;
								this.detailListView[i1].repqty = repQty - decQty; */
								var cc2 = this.detailListView[i1];
								cc2.collectedqty = tmpQty + decQty;
								cc2.repqty = repQty - decQty;
								this.$set(this.detailListView, i1, cc2);

								let ls2 = this.dicMtlQty.get(outtaskitemid);
								ls2[1] = tmpQty + decQty;
								this.dicMtlQty.set(outtaskitemid, ls2);

								let set = [];
								set[0] = taskQty;
								set[1] = decQty;
								dicMtlOperatin.set(outtaskitemid, set); //第一笔存物料计划数

								decQty = 0;
								exsitFlag = true;
							} else {
								decQty = decQty - (taskQty - tmpQty); //本次扫描数量- 计划剩余数量
								/* this.detailListView[i1].collectedqty = taskQty;
								this.detailListView[i1].repqty = repQty - taskQty; */

								var cc1 = this.detailListView[i1];
								cc1.collectedqty = taskQty;
								//cc1.repqty = repQty - taskQty;
								cc1.repqty = repQty - (taskQty - tmpQty);
								repQty = cc1.repqty;
								this.$set(this.detailListView, i1, cc1);

								let ls21 = this.dicMtlQty.get(outtaskitemid);
								ls21[1] = taskQty;
								this.dicMtlQty.set(outtaskitemid, ls21);

								let set21 = [];
								set21[0] = taskQty;
								set21[1] = taskQty - tmpQty;
								dicMtlOperatin.set(outtaskitemid, set21); //第一笔存物料计划数
							}
						}
						if ((matSendControl == '0' && roomMatControl == '0') || roomMatControl == '1') {
							if (!exsitFlag) {
								throw new Error('采集物料批号序列号信息匹配任务明细失败');
							}
						}

						if (sn != null && sn != '' && sn != undefined && !this.dicSeq.has(matCode + '@' + sn)) {
							this.dicSeq.set(matCode + '@' + sn, matCode + '@' + sn);
						}
						if (!this.dicInvMtlQty.has(strKey)) {
							this.dicInvMtlQty.set(strKey, qty);
						} else {
							let collectQtyGet = this.dicInvMtlQty.get(strKey);
							this.dicInvMtlQty.set(strKey, collectQtyGet + qty);
						}
						await this.taskcollAdd(null, this.storeSite);
						//添加采集记录;对于采集记录的修改操作统一在采集明细中操作
						await this.AddCollectData(matCode, batchNo, sn, qty, storeRoom, this.storeSite, dicMtlOperatin, erpStoreInv, trayNo);
						await this.localSave();
						await this.InitializeCollect();
					}
				}
				this.$set(this.scanningContent, 'text', '');
				this.placeholder = await this.getPlaceMsg();
			} catch (error) {
				uni.showModal({
					title: '平库出库采集异常',
					showCancel: false,
					content: error.message
				});
				this.$set(this.scanningContent, '', null);
				this.InitializeCollect();
			}
		},

		async CheckSite(siteCode) {
			let response = await this.getStoreSiteByRoom_await(storeRoom, siteCode);
			console.log(response);
			if (response.msg && response.code != '200') {
				/* this.$u.toast(res.msg); */
				uni.showToast({
					icon: 'none',
					duration: 3000,
					title: res.msg
				});
				return;
			}
			if (response.code == '200') {
				let siteList = response.data;
				if (siteList.Length <= 0) {
					/* this.$u.toast('库房【' + storeRoom + '】下无库位号【' + siteCode + '】'); */
					uni.showToast({
						icon: 'none',
						duration: 3000,
						title: '库房【' + storeRoom + '】下无库位号【' + siteCode + '】'
					});
					return;
				}

				if (siteList[0].isfrozen != '0') {
					/* this.$u.toast('库位【' + siteCode + '】被锁定或者冻结'); */
					uni.showToast({
						icon: 'none',
						duration: 3000,
						title: '库位【' + siteCode + '】被锁定或者冻结'
					});
					return;
				}
			}
		},

		/* async getStoreSiteByRoom_await(storeRoomNo, storeSiteNo) {
					return await this.getStoreSiteByRoom(storeRoomNo, storeSiteNo);
				}, */
		async getStoreSiteByRoom_await(storeRoomNo, storeSiteNo) {
			return this.getStoreSiteByRoom(storeRoomNo, storeSiteNo);
		},

		async getStoreSiteByRoom(storeRoomNo, storeSiteNo) {
			return new Promise(function (resolve, reject) {
				getStoreSiteByRoom(storeRoomNo, storeSiteNo).then((response) => {
					resolve(response);
				});
			});
		},

		async GetMatControl_await(matcode) {
			return await this.GetMatControl(matcode);
		},
		async GetMatControl(matcode) {
			return new Promise(function (resolve, reject) {
				GetMatControl(matcode).then((response) => {
					resolve(response);
				});
			});
		},

		async GetRoomMatControl(taskId) {
			return new Promise(function (resolve, reject) {
				GetRoomMatControl(taskId).then((response) => {
					resolve(response);
				});
			});
		},
		async getMtlRepertoryByStoresiteNo_await(storeSite, matCode, erp_storeroom, batchno, sn) {
			return await this.getMtlRepertoryByStoresiteNo(storeSite, matCode, erp_storeroom, batchno, sn);
		},

		async getMtlRepertoryByStoresiteNo(storeSite, matCode, erp_storeroom, batchno, sn) {
			return new Promise(function (resolve, reject) {
				getMtlRepertoryByStoresiteNo(storeSite, matCode, erp_storeroom, batchno, sn).then((response) => {
					resolve(response);
				});
			});
		},

		async getMtlRepertoryByStoresiteNosn_await(storeSite, matCode, erp_storeroom, batchno, sn) {
			return await this.getMtlRepertoryByStoresiteNosn(storeSite, matCode, erp_storeroom, batchno, sn);
		},

		async getMtlRepertoryByStoresiteNosn(storeSite, matCode, erp_storeroom, batchno, sn) {
			return new Promise(function (resolve, reject) {
				getMtlRepertoryByStoresiteNosn(storeSite, matCode, erp_storeroom, batchno, sn).then((response) => {
					resolve(response);
				});
			});
		},

		async getPmMaterialInfoByQR_await(barcode) {
			let aa = await this.getPmMaterialInfoByQR(barcode);
			return aa;
		},
		async getPmMaterialInfoByQR(barcode) {
			return new Promise(function (resolve, reject) {
				getPmMaterialInfoByQR(barcode).then((response) => {
					resolve(response);
				});
			});
		},
		// 设定提示信息
		async getPlaceMsg() {
			if (this.storeSite == '' || this.storeSite == null || this.storeSite == undefined) {
				//条码为空 采集条码
				this.focus = false;
				return '请扫描库位';
			}
			if (this.BarcodeContent.matcode == '' || this.BarcodeContent.matcode == null || this.BarcodeContent.matcode == undefined) {
				//条码为空 采集条码
				this.focus = false;
				return '请扫描二维码';
			} else if (this.BarcodeContent.sn == null && this.collectQty == 0) {
				this.focus = true;
				return '请输入数量';
			} else {
				this.focus = false;
				return '';
			}
		},
		/// <summary>
		/// 重新初始采集
		/// </summary>
		async InitializeCollect() {
			this.collectQty = 0;
			this.BarcodeContent = {};
			this.focus = false;
			collectFlg = '';
			matFoundFlg = '';
			erpStoreSite = '';
			batchFountFlg = '0';
			matCode = '';
			batchNo = '';
			sn = '';
			pdate = '';
			vdays = '';
			matControlFlag = '';
			strMsg = '';
			siteFlag = 'Y';
			batchFlag = 'Y';
			strKey = '';
			RepQty = 0;
			matSendControl = '0';
			erpRoom = '';
			trayNo = '';
			erpStoreInv = '';
			resFlag = '';
		},
		async localSave() {
			uni.setStorage({
				key: 'up_inTaskItemList',
				data: this.detailListView,
				success: function () {
					console.log('采集成功后 任务列表保存成功');
				}
			});
			uni.setStorage({
				key: 'up_stocks',
				data: this.stocks,
				success: function () {
					console.log('采集成功后 采集列表保存成功');
				}
			});
			uni.setStorage({
				key: 'up_dicSeq',
				data: JSON.stringify(Array.from(this.dicSeq)),
				success: function () {
					console.log('采集成功后 采集列表保存成功');
				}
			});

			uni.setStorage({
				key: 'up_dicMtlQty',
				data: JSON.stringify(Array.from(this.dicMtlQty)),
				success: function () {
					console.log('采集成功后 采集列表保存成功');
				}
			});
		},
		async getMtlRepertoryByStoresiteNoErp_await(storeSite, matCode) {
			return new Promise(function (resolve, reject) {
				getMtlRepertoryByStoresiteNoErp(storeSite, matCode).then((response) => {
					resolve(response);
				});
			});
		},
		async showConfirm(content) {
			return new Promise(function (resolve, reject) {
				// 一段耗时的异步操作
				uni.showModal({
					title: '操作确认',
					content: content,
					cancelText: '取消',
					confirmText: '确认',
					success: (res) => {
						if (res.confirm) {
							resolve(true); // 数据处理完成
						} else if (res.cancel) {
							console.log('用户点击取消');
							resolve(false);
						}
					}
				});
			});
		},

		async AddCollectData(matCode, batchNo, sn, collectQty, storeRoom, storeSite, dicMtlOperatin, erpRoom, trayNo) {
			for (let [key, value] of dicMtlOperatin) {
				console.log(key + ' = ' + value);
				let stock = {};
				stock.stockid = uuid();
				stock.matcode = matCode;
				stock.batchno = batchNo;
				stock.sn = sn;
				stock.taskQty = value[0]; //计划数
				stock.collectQty = value[1]; //本次采集数量
				stock.outtaskitemid = key;
				stock.taskid = taskId;
				stock.storeRoom = storeRoom;
				stock.storeSite = storeSite;
				stock.erpStore = erpRoom;
				stock.TrayNo = trayNo;

				this.stocks.push(stock);
			}
		},

		commitButton_Click() {
			try {
				if (this.stocks.length == 0) {
					throw new Error('本次无采集明细，请确认！');
				}
				let tmpMat = '';
				let taskQty1 = 0;
				let tmpQty1 = 0;
				let msg = '';
				let tmpStore = '';

				for (let ii = 0; ii < this.detailListView.length; ii++) {
					tmpMat = this.detailListView[ii].matcode; //物料
					tmpStore = this.detailListView[ii].storesiteno; //库位
					taskQty1 = parseFloat(this.detailListView[ii].hintqty);
					tmpQty1 = parseFloat(this.detailListView[ii].collectedqty);
					if (taskQty1 != tmpQty1) {
						msg += '库位【' + tmpStore + '】物料【' + tmpMat + '】还剩【' + (taskQty1 - tmpQty1) + '】未做';
						break;
					}
				}

				if (msg != '') {
					msg += '，请确认是否提交？';
				} else {
					msg = '请确认是否提交？';
				}

				uni.showModal({
					title: '提交确认',
					content: msg,
					success: (res) => {
						if (res.confirm) {
							let collectStocks = this.stocks;
							if (collectStocks.length <= 0) {
								throw new Error('本次无采集明细，请确认！');
							}
							let downShelvesInfosList = [];
							for (let io = 0; io < collectStocks.length; io++) {
								let downShelvesInfo = {};
								let upStock = collectStocks[io];

								downShelvesInfo.taskNo = taskNo;
								downShelvesInfo.matCode = upStock.matcode; //物料号
								downShelvesInfo.batchNo = upStock.batchno; //批号
								downShelvesInfo.sn = upStock.sn; //序列号
								downShelvesInfo.taskQty = upStock.taskQty; //任务数量
								downShelvesInfo.collectQty = upStock.collectQty; //已采集数量
								downShelvesInfo.storeRoomNo = upStock.storeRoom;
								downShelvesInfo.storeSiteNo = upStock.storeSite;
								downShelvesInfo.taskid = upStock.taskid;
								downShelvesInfo.outTaskItemid = upStock.outtaskitemid;
								downShelvesInfo.erpStore = upStock.erpStore;
								downShelvesInfosList.push(downShelvesInfo);
							}
							if (downShelvesInfosList.length <= 0) {
								throw new Error('本次无采集明细，请确认！');
							}

							let lsItems = [];
							let dicMtlQtys = this.dicMtlQty;
							for (let [key, value] of dicMtlQtys) {
								let itemListInfo = {};
								let mtlQty = [];
								mtlQty[0] = value[0];
								mtlQty[1] = value[1];
								itemListInfo.mtlQty = mtlQty;

								itemListInfo.outTaskItemid = key;
								itemListInfo.mtlCode = value[2];

								lsItems.push(itemListInfo);
							}

							if (lsItems.length <= 0) {
								throw new Error('本次无采集明细，请确认！');
							}

							commitDownShelves(downShelvesInfosList, lsItems).then((response) => {
								if (response.code == '200') {
									/* this.$u.toast('提交成功'); */
									uni.showModal({
										title: '信息提示',
										showCancel: false,
										content: '提交成功'
									});

									uni.setStorage({
										key: 'up_stocks',
										data: [], //未修改
										success: function () {
											console.log('采集结果初始化');
										}
									});
									uni.setStorage({
										key: 'up_updateflag',
										data: '0',
										success: function () {
											console.log('采集状态修改标志初始化');
										}
									});
									uni.setStorage({
										key: 'up_inTaskItemList',
										data: [],
										success: function () {
											console.log('采集任务初始化');
										}
									});

									uni.setStorage({
										key: 'up_dicMtlQty',
										data: [],
										success: function () {
											console.log('采集成功后 采集列表保存成功');
										}
									});

									uni.$off('scancodedate');
									uni.reLaunch({
										url: '/pages/goodsdown/goodsDown' // 你可以根据需要调整跳转的页面
									});
								}
							});
						}
					}
				});
			} catch (error) {
				uni.showModal({
					title: '平库出库采集异常',
					showCancel: false,
					content: error.message
				});
			}
		},
		checkIntAndFloat(source) {
			var regex = /^[0-9]+(\.[0-9]+)?$/g;
			return regex.test(source);
		},
		toggleAllSelection(checked, arr) {
			this.checkedList = arr;
			this.checkedIds = this.checkedList.map((item) => item.outtaskitemid);
		},
		toggleRowSelection(checked, arr) {
			this.checkedList = arr;
			this.checkedIds = this.checkedList.map((item) => item.outtaskitemid);
		},

		//导航栏初始化事件
		init(e) {
			this.height = Math.ceil((e.height / e.windowWidth) * 750);
		},
		//导航栏点击事件
		onClick(e) {
			console.log(e);
			if (e.index === 0) {
				this.actionsClick('goodsDownCollectDetail');
			}
			if (e.index === 1) {
				this.commitButton_Click();
			}
			if (e.index === 2) {
				this.show = true;
			}
		},
		//二级菜单点击事件
		subClick(e) {
			console.log(e);
			if (e.index === 1) {
				this.finshClick();
			} else if (e.index === 0) {
				uni.$off('scancodedate');
				setTimeout(() => {
					uni.navigateTo({
						url:
							'/pages/exceptTask/exceptTask?taskComment=' +
							taskComment +
							'&taskNo=' +
							taskNo +
							'&taskid=' +
							taskId +
							'&proType=' +
							'平库下架' +
							'&storeRoom=' +
							storeRoom +
							'&trayNo=' +
							trayNo
					});
				}, 100);
			}
			this.onClose();
		},
		//关闭二级菜单
		onClose() {
			this.show = false;
		},

		handleCheckAll(selectItem) {
			/* 			const { checkedIds, detailListView } = this; */
			if (selectItem.is_selected) {
				this.checkedIds = this.detailListView.map((item) => item.outtaskitemid);
			} else {
				this.checkedIds = [];
			}
			this.checkedList = this.detailListView.filter((item) => inArray(item.outtaskitemid, this.checkedIds));
		},

		handleCheckItem(selectItem) {
			const { checkedIds } = this;
			const index = this.checkedIds.findIndex((id) => id === selectItem.item.outtaskitemid);
			if (selectItem.is_selected) {
				if (index <= 0) {
					this.checkedIds.push(selectItem.item.outtaskitemid);
				}
			} else {
				if (index > 0) {
					this.checkedIds.splice(index, 1);
				}
			}
			this.checkedList = this.detailListView.filter((item) => inArray(item.outtaskitemid, this.checkedIds));
		},

		handleCheckAll2(selectItem) {
			const { checkedIds, detailListView2 } = this;
			if (selectItem.is_selected) {
				this.checkedIds = this.detailListView2.map((item) => item.outtaskitemid);
			} else {
				this.checkedIds = [];
			}
			this.checkedList = this.detailListView2.filter((item) => inArray(item.outtaskitemid, this.checkedIds));
		},

		handleCheckItem2(selectItem) {
			const { checkedIds } = this;
			const index = this.checkedIds.findIndex((id) => id === selectItem.item.outtaskitemid);
			if (selectItem.is_selected) {
				if (index < 0) {
					this.checkedIds.push(selectItem.item.outtaskitemid);
				}
			} else {
				if (index >= 0) {
					this.checkedIds.splice(index, 1);
				}
			}
			this.checkedList = this.detailListView2.filter((item) => inArray(item.outtaskitemid, this.checkedIds));
		},
		async finshClick() {
			if (this.stocks.length > 0) {
				uni.showModal({
					title: '提交异常',
					showCancel: false,
					content: '采集数据未提交,不允许报缺！'
				});
				return;
			}
			if (this.checkedList.length <= 0) {
				uni.showModal({
					title: '提交异常',
					showCancel: false,
					content: '请至少选择一行记录！'
				});
				return;
			}

			uni.showModal({
				title: '物料报缺',
				content: '请确认是否该采集明细物料报缺？',
				success: (res) => {
					if (res.confirm) {
						uni.showLoading({
							title: '加载中'
						});
						let selectedList = this.checkedList;
						let outtaskitemid = selectedList[0].outtaskitemid;
						console.log('outtaskitemid' + outtaskitemid);
						commitFinishOutTaskItem(outtaskitemid).then((response) => {
							/* setTimeout(function () {
								uni.hideLoading();
							}, 100); */
							uni.showToast({
								icon: '信息提示',
								duration: 3000,
								title: '报缺成功'
							});

							this.getList();
						});
					}
				}
			});
		},
		page_back() {
			if (this.stocks.length > 0) {
				uni.showModal({
					title: '提示',
					content: '当前采集记录尚未提交 确定退出采集吗？',
					success: (res) => {
						if (res.confirm) {
							uni.$off('scancodedate');
							uni.reLaunch({
								url: '/pages/goodsdown/goodsDown' // 你可以根据需要调整跳转的页面
							});
						}
					}
				});
			} else {
				uni.$off('scancodedate');
				uni.reLaunch({
					url: '/pages/goodsdown/goodsDown' // 你可以根据需要调整跳转的页面
				});
			}
		}
	}
};
</script>

<style>
.table_hide {
	width: 100%;
	height: 0rpx;
}
</style>
