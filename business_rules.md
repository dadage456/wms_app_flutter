# 平库出库采集业务规则文档

## 1. 业务流程概述

### 1.1 三步扫码采集流程
1. **库位扫描** - 格式包含 `$KW$` 标识
2. **物料二维码扫描** - 格式包含 `MC` 标识
3. **数量输入** - 数字格式验证

### 1.2 核心业务状态
- **collectFlg**: 采集状态标志
- **matFoundFlg**: 物料查找标志
- **booCheck**: 批次校验标志
- **booCheckAagentCode**: 供应商校验标志
- **batchFountFlg**: 批次查找标志

## 2. 条码识别与校验规则

### 2.1 基础校验规则
```javascript
// 规则2.1.1: 采集内容为空校验
IF barcode == undefined OR barcode == null OR barcode.length == 0 THEN
    this.$set(this.scanningContent, 'text', '')
    THROW Error('采集内容为空,请重新采集')
END IF
```

### 2.2 条码类型识别
```javascript
// 规则2.2.1: 物料二维码识别
IF barcode.includes('MC') > 0 THEN
    currStep = Step._2DBarcode
END IF

// 规则2.2.2: 库位条码识别
IF barcode.includes('$KW$') THEN
    currStep = Step.Site
END IF

// 规则2.2.3: 数量识别
IF checkIntAndFloat(barcode) THEN
    currStep = Step.Quantity
END IF

// 规则2.2.4: 无效条码
IF 不符合以上任一条件 THEN
    this.$set(this.scanningContent, 'text', '')
    THROW Error('采集内容不合法！')
END IF
```

### 2.3 库位条码解析规则
```javascript
// 规则2.3.1: 库位条码解析
FUNCTION parseSiteCode(barcode) RETURNS STRING
    VAR sArry = barcode.split('$')
    IF sArry.length >= 3 THEN
        RETURN sArry[2]  // 库位码在第三个位置
    ELSE
        THROW Error('库位条码格式不正确')
    END IF
END FUNCTION
```

### 2.4 数量格式校验
```javascript
// 规则2.4.1: 数字格式验证
FUNCTION checkIntAndFloat(source) RETURNS BOOLEAN
    VAR regex = /^[0-9]+(\.[0-9]+)?$/g
    RETURN regex.test(source)
END FUNCTION
```

## 3. 物料控制模式规则

### 3.1 新旧条码格式处理规则
```javascript
// 规则3.1.1: 新旧条码格式识别
VAR newmarttask = BarcodeContent2.id_old
IF newmarttask == '0' THEN
    // 新格式条码处理逻辑
ELSE
    // 旧格式条码处理逻辑
END IF
```

### 3.2 物料发送控制获取规则
```javascript
// 规则3.2.1: 物料发送控制获取
FUNCTION getMatSendControl(matCode) RETURNS STRING
    VAR response = GetMatControl(matCode)
    IF response.code == '200' THEN
        VAR mtlInfo = response.msg.split('!')
        IF mtlInfo[4] != '' THEN
            RETURN mtlInfo[4]
        ELSE
            RETURN '0'  // 默认值
        END IF
    END IF
    RETURN '0'
END FUNCTION
```

### 3.3 物料控制类型
```javascript
// 规则3.3.1: 物料控制模式定义
MtlCheckMode = {
    Mtl: 'Mtl',                    // 仅检查物料
    MtlBatch: 'MtlBatch',          // 物料+批号
    MtlSite: 'MtlSite',            // 物料+库位
    MtlBatchSite: 'MtlBatchSite'   // 物料+批号+库位
}

// 规则3.3.2: 控制模式选择逻辑
IF siteFlag == 'Y' AND batchFlag == 'Y' THEN
    mtlCheckMode = MtlCheckMode.MtlBatchSite
ELSE IF siteFlag == 'Y' AND batchFlag != 'Y' THEN
    mtlCheckMode = MtlCheckMode.MtlSite
ELSE IF siteFlag != 'Y' AND batchFlag == 'Y' THEN
    mtlCheckMode = MtlCheckMode.MtlBatch
ELSE
    mtlCheckMode = MtlCheckMode.Mtl
END IF
```

### 3.4 批次查找规则
```javascript
// 规则3.4.1: 任务明细中批次查找逻辑
FUNCTION findBatchInDetailList(matCode, batchNo, storeSite) RETURNS STRING
    VAR batchFountFlg = '0'
    VAR tmpMat, tmpSite, tmpBatchNo
    VAR erpRoom = ''

    // 规则3.4.1.1: 精确匹配（物料+库位+批次）
    FOR EACH item IN detailListView
        tmpMat = item.matcode
        tmpSite = item.storesiteno
        tmpBatchNo = item.hintbatchno
        IF tmpMat == matCode AND tmpSite == storeSite AND tmpBatchNo == batchNo THEN
            erpRoom = item.subinventoryCode
            batchFountFlg = '1'
            BREAK
        END IF
    END FOR

    // 规则3.4.1.2: 模糊匹配（物料+库位）
    IF batchFountFlg == '0' THEN
        FOR EACH item IN detailListView
            tmpMat = item.matcode
            tmpSite = item.storesiteno
            IF tmpMat == matCode AND tmpSite == storeSite THEN
                erpRoom = item.subinventoryCode
                batchFountFlg = '1'
                BREAK
            END IF
        END FOR
    END IF

    RETURN batchFountFlg
END FUNCTION
```

### 3.5 序列号控制规则
```javascript
// 规则3.5.1: 序列号物料校验
IF matControl == '0' THEN  // 序列号控制
    // 规则3.5.1.1: 序列号不能为空
    IF BarcodeContent.sn == undefined OR BarcodeContent.sn == null OR BarcodeContent.sn == '' THEN
        THROW Error('物料【' + BarcodeContent2.matcode + '】序列号不能为空')
    END IF

    // 规则3.5.1.2: 序列号重复校验
    IF dicSeq.has(BarcodeContent2.matcode + '@' + BarcodeContent2.sn) THEN
        THROW Error('物料【' + BarcodeContent2.matcode + '】序列号【' + BarcodeContent2.sn + '】不允许重复采集')
    END IF

    // 规则3.5.1.3: 已采集序列号校验
    FOR EACH stock IN stocks
        IF stock.sn == BarcodeContent2.sn THEN
            THROW Error('采集物料【' + BarcodeContent2.matcode + '】序列号【' + BarcodeContent2.sn + '】库位【' + storeSite + '】已经采集')
        END IF
    END FOR
END IF
```

### 3.6 批次控制规则
```javascript
// 规则3.6.1: 批次物料校验
IF matControl == '1' OR matControl == '2' THEN  // 批次控制
    // 规则3.6.1.1: 批次号不能为空
    IF BarcodeContent2.batchno == undefined OR BarcodeContent2.batchno == null OR BarcodeContent2.batchno == '' THEN
        THROW Error('物料【' + BarcodeContent2.matcode + '】批次号不能为空')
    END IF
END IF

// 规则3.6.2: 控制模式有效性校验
IF matControl != '0' AND matControl != '1' AND matControl != '2' THEN
    THROW Error('物料' + BarcodeContent2.matcode + '编码控制维护值维护不合法')
END IF
```

### 3.7 强制批次校验条件规则
```javascript
// 规则3.7.1: 强制批次校验条件判断
FUNCTION isForceBatchCheck() RETURNS BOOLEAN
    RETURN (matSendControl == '0' AND roomMatControl == '0') OR roomMatControl == '1'
END FUNCTION
```

## 4. 库位校验规则

### 4.1 库位有效性校验
```javascript
// 规则4.1.1: 库位存在性校验
FUNCTION CheckSite(storeRoom, siteCode) RETURNS VOID
    VAR response = getStoreSiteByRoom(storeRoom, siteCode)

    // 规则4.1.1.1: 库位必须存在
    IF response.data.length <= 0 THEN
        THROW Error('库房【' + storeRoom + '】下无库位号【' + siteCode + '】')
    END IF

    // 规则4.1.1.2: 库位状态校验
    IF response.data[0].isfrozen != '0' THEN
        THROW Error('库位【' + siteCode + '】被锁定或者冻结')
    END IF
END FUNCTION
```

### 4.2 库位与物料匹配校验
```javascript
// 规则4.2.1: 物料库位匹配校验
FUNCTION CheckMtlSite(matCode, batchNo, storeSite) RETURNS VOID
    VAR matFind = 'N'
    VAR tmpMat, tmpSite, tmpBatch

    // 规则4.2.1.1: 强制库位校验
    IF siteFlag == 'Y' THEN
        FOR EACH item IN detailListView
            tmpMat = item.matcode
            tmpSite = item.storesiteno
            tmpBatch = item.hintbatchno

            IF batchFlag == 'Y' AND (matControl == '1' OR matControl == '2') THEN
                IF tmpMat == strMtlCode AND tmpBatch == strBatch AND tmpSite == strSiteCode THEN
                    erpRoom = item.subinventoryCode
                    matFind = 'Y'
                    BREAK
                END IF
            ELSE
                IF tmpMat == strMtlCode AND tmpSite == strSiteCode THEN
                    erpRoom = item.subinventoryCode
                    matFind = 'Y'
                    BREAK
                END IF
            END IF
        END FOR

        IF matFind == 'N' THEN
            IF batchFlag == 'Y' THEN
                THROW Error('采集物料【' + strMtlCode + '】批次【' + strBatch + '】库位【' + strSiteCode + '】不在任务明细中')
            ELSE
                THROW Error('采集物料【' + strMtlCode + '】库位【' + strSiteCode + '】不在任务明细中')
            END IF
        END IF
    END IF

    // 规则4.2.1.2: 非强制库位校验
    IF siteFlag != 'Y' THEN
        FOR EACH item IN detailListView
            tmpMat = item.matcode
            tmpBatch = item.hintbatchno

            IF batchFlag == 'Y' AND (matControl == '1' OR matControl == '2') THEN
                IF tmpMat == strMtlCode AND tmpBatch == strBatch THEN
                    erpRoom = item.subinventoryCode
                    matFind = 'Y'
                    BREAK
                END IF
            ELSE
                IF tmpMat == strMtlCode THEN
                    erpRoom = item.subinventoryCode
                    matFind = 'Y'
                    BREAK
                END IF
            END IF
        END FOR

        IF matFind == 'N' THEN
            THROW Error('采集物料【' + strMtlCode + '】不在任务明细中')
        END IF
    END IF
END FUNCTION
```

## 5. 库存校验规则

### 5.1 库存数量计算规则
```javascript
// 规则5.1.1: 库存数量累加计算
FUNCTION calculateTotalStock(RepertoryList) RETURNS NUMBER
    VAR repqtySum = 0
    FOR EACH item IN RepertoryList
        repqtySum += item.repqty
    END FOR
    RETURN repqtySum
END FUNCTION

// 规则5.1.2: 按条件筛选库存数量
FUNCTION calculateFilteredStock(RepertoryList, erpRoom, batchNo) RETURNS NUMBER
    VAR repqtySum = 0
    FOR EACH item IN RepertoryList
        IF erpRoom != null AND erpRoom != '' THEN
            IF item.erpStoreroom == erpRoom AND item.batchno == batchNo THEN
                repqtySum += item.repqty
            END IF
        ELSE
            IF item.batchno == batchNo THEN
                repqtySum += item.repqty
            END IF
        END IF
    END FOR
    RETURN repqtySum
END FUNCTION
```

### 5.2 ERP子库获取规则
```javascript
// 规则5.2.1: ERP子库获取
FUNCTION getErpStoreRoom(RepertoryList) RETURNS STRING
    IF RepertoryList.length > 0 THEN
        RETURN RepertoryList[0].erpStoreroom
    END IF
    RETURN ''
END FUNCTION
```

### 5.3 批次库存校验
```javascript
// 规则5.3.1: 批次物料库存校验
FUNCTION checkInvBatch(storeSite, matCode, batchNo) RETURNS VOID
    VAR RepertoryList = getMtlRepertoryByStoresiteNo(storeSite, matCode)
    VAR repqtySum = 0
    VAR drcheck = []

    // 规则5.3.1.1: 计算总库存
    repqtySum = calculateTotalStock(RepertoryList)

    // 规则5.3.1.2: 按批次筛选库存
    IF erpRoom != null AND erpRoom != '' THEN
        FOR EACH item IN RepertoryList
            IF item.erpStoreroom == erpRoom AND item.batchno == batchNo THEN
                repqtySum = item.repqty
                drcheck.push(item)
            END IF
        END FOR
    ELSE
        FOR EACH item IN RepertoryList
            IF item.batchno == batchNo THEN
                repqtySum = item.repqty
                drcheck.push(item)
            END IF
        END FOR
    END IF

    // 规则5.3.1.3: 库存存在性校验
    IF drcheck.length <= 0 THEN
        THROW Error('物料【' + matCode + '】批次【' + batchNo + '】在库位【' + storeSite + '】不存在')
    END IF

    // 规则5.3.1.4: 库存数量校验
    IF repqtySum <= 0 THEN
        THROW Error('物料【' + matCode + '】批次【' + batchNo + '】在库位【' + storeSite + '】库存不足')
    END IF

    // 规则5.3.1.5: ERP子库一致性校验
    IF erpRoom != null AND erpRoom != '' THEN
        VAR erpStoreInv = getErpStoreRoom(RepertoryList)
        IF erpStoreInv != erpRoom THEN
            THROW Error('当前物料明细指定子库【' + erpRoom + '】与当前库位的物料批次子库【' + erpStoreInv + '】存在不一致')
        END IF
    END IF
END FUNCTION
```

### 5.4 序列号库存校验
```javascript
// 规则5.4.1: 序列号物料库存校验
FUNCTION checkInvSerial(storeSite, matCode, batchNo, sn) RETURNS VOID
    VAR RepertoryList = getMtlRepertoryByStoresiteNosn(storeSite, matCode, null, null, null)
    VAR repqtySum = 0

    // 规则5.4.1.1: 基础库存校验
    IF RepertoryList.length > 0 THEN
        repqtySum = RepertoryList[0].repqty
    END IF

    // 规则5.4.1.2: 库存数量校验
    IF repqtySum <= 0 THEN
        THROW Error('物料【' + matCode + '】批次【' + batchNo + '】序列【' + sn + '】在库位【' + storeSite + '】不存在')
    END IF

    // 规则5.4.1.3: 按条件筛选库存
    VAR repqtySumFinal = 0
    IF erpRoom != null AND erpRoom != '' THEN
        VAR filteredList = getMtlRepertoryByStoresiteNosn(storeSite, matCode, erpRoom, batchNo, sn)
        IF filteredList.length > 0 THEN
            repqtySumFinal = filteredList[0].repqty
        END IF
    ELSE
        VAR filteredList = getMtlRepertoryByStoresiteNosn(storeSite, matCode, null, batchNo, sn)
        IF filteredList.length > 0 THEN
            repqtySumFinal = filteredList[0].repqty
        END IF
    END IF

    // 规则5.4.1.4: 最终库存校验
    IF repqtySumFinal <= 0 THEN
        THROW Error('物料【' + matCode + '】批次【' + batchNo + '】序列【' + sn + '】在库位【' + storeSite + '】不存在')
    END IF
END FUNCTION
```

## 6. 数量处理规则

### 6.1 数量有效性校验
```javascript
// 规则6.1.1: 数量基本校验
FUNCTION validateQuantity(qty) RETURNS VOID
    // 规则6.1.1.1: 数量必须大于0
    IF qty <= 0 THEN
        THROW Error('采集数量必须大于0')
    END IF

    // 规则6.1.1.2: 序列号物料不允许输入数量
    IF sn != undefined AND sn != '' AND sn != null THEN
        THROW Error('已采集序列号无需采集数量，请扫描二维码')
    END IF
END FUNCTION

// 规则6.1.2: 序列号物料数量限制校验
FUNCTION validateSerialNumberQuantity(sn) RETURNS VOID
    IF sn != undefined AND sn != '' AND sn != null AND sn != undefined THEN
        THROW Error('已采集序列号无需采集数量，请扫描二维码')
    END IF
END FUNCTION
```

### 6.2 库存充足性校验
```javascript
// 规则6.2.1: 库存充足性校验
FUNCTION validateStockSufficiency(storeSite, matCode, batchNo, qty) RETURNS VOID
    VAR decRepqty = 0
    VAR strKey = storeSite + matCode + batchNo

    // 规则6.2.1.1: 获取已采集数量
    IF dicInvMtlQty.has(strKey) THEN
        decRepqty = dicInvMtlQty.get(strKey)
    END IF

    // 规则6.2.1.2: 校验库存是否充足
    IF RepQty - decRepqty < qty THEN
        THROW Error('库位【' + storeSite + '】物料【' + matCode + '】的库存【' + (RepQty - decRepqty) + '】小于本次移出库存【' + qty + '】')
    END IF
END FUNCTION
```

### 6.3 数量分配库存更新规则
```javascript
// 规则6.3.1: 数量分配时库存更新逻辑
FUNCTION updateInventoryDuringAllocation(item, decQty, repQty) RETURNS NUMBER
    VAR taskQty = parseFloat(item.hintqty)
    VAR tmpQty = parseFloat(item.collectedqty)

    IF taskQty - tmpQty >= decQty THEN
        // 足够扣减
        item.collectedqty = tmpQty + decQty
        item.repqty = repQty - decQty
        RETURN decQty
    ELSE
        // 部分扣减
        VAR allocatedQty = taskQty - tmpQty
        item.collectedqty = taskQty
        item.repqty = repQty - allocatedQty
        RETURN allocatedQty
    END IF
END FUNCTION
```

### 6.4 任务数量匹配校验
```javascript
// 规则6.4.1: 任务数量匹配校验
FUNCTION validateTaskQuantity(matCode, batchNo, storeSite, qty) RETURNS VOID
    VAR tatalTaskQty = 0  // 当前物料总计划数
    VAR tatalTmpQty = 0   // 当前物料总扫描数

    // 规则6.4.1.1: 统计当前物料总计划数和总扫描数
    FOR EACH item IN detailListView
        IF item.matcode != matCode THEN
            CONTINUE
        END IF

        // 规则6.4.1.2: 根据控制模式进行匹配
        IF (matControl == '1' OR matControl == '2') AND ((matSendControl == '0' AND roomMatControl == '0') OR roomMatControl == '1') THEN
            IF mtlCheckMode == MtlCheckMode.MtlBatch THEN
                IF item.hintbatchno != batchNo THEN
                    CONTINUE
                END IF
            ELSE IF mtlCheckMode == MtlCheckMode.MtlBatchSite THEN
                IF item.hintbatchno != batchNo OR item.storesiteno != storeSite THEN
                    CONTINUE
                END IF
            ELSE IF mtlCheckMode == MtlCheckMode.MtlSite THEN
                IF item.storesiteno != storeSite THEN
                    CONTINUE
                END IF
            END IF
        END IF

        tatalTaskQty += parseFloat(item.hintqty)
        tatalTmpQty += parseFloat(item.collectedqty)
    END FOR

    // 规则6.4.1.3: 校验数量是否足够
    IF tatalTmpQty + qty > tatalTaskQty THEN
        THROW Error('本次采集数量【' + qty + '】大于剩余可采集数量【' + (tatalTaskQty - tatalTmpQty) + '】')
    END IF
END FUNCTION
```

## 7. 数据处理规则

### 7.1 采集数据处理
```javascript
// 规则7.1.1: 采集数量分配逻辑
FUNCTION allocateCollectQuantity(qty) RETURNS VOID
    VAR decQty = qty
    VAR dicMtlOperatin = new Map()

    // 规则7.1.1.1: 遍历任务明细进行数量分配
    FOR EACH item IN detailListView
        IF decQty <= 0 THEN
            BREAK
        END IF

        // 规则7.1.1.2: 物料和库位匹配校验
        IF (item.matcode != matCode OR item.storesiteno != storeSite) AND matControl != 0 AND ((matSendControl == '0' AND roomMatControl == '0') OR roomMatControl == '1') THEN
            CONTINUE
        END IF

        // 规则7.1.1.3: 任务完成校验
        IF item.hintqty == item.collectedqty THEN
            CONTINUE
        END IF

        // 规则7.1.1.4: 根据控制模式进行匹配
        VAR exsitFlag = false
        SWITCH matControl
            CASE 0:
                exsitFlag = true
                BREAK
            CASE 1:
                // 批次控制逻辑
                exsitFlag = validateBatchControl(item, batchNo, storeSite)
                BREAK
            CASE 2:
                // 批次控制逻辑
                exsitFlag = validateBatchControl(item, batchNo, storeSite)
                BREAK
        END SWITCH

        IF !exsitFlag THEN
            CONTINUE
        END IF

        // 规则7.1.1.5: 数量分配
        VAR taskQty = parseFloat(item.hintqty)
        VAR tmpQty = parseFloat(item.collectedqty)
        VAR outtaskitemid = item.outtaskitemid
        VAR allocatedQty = updateInventoryDuringAllocation(item, decQty, repQty)

        // 更新数量映射
        updateMtlQtyMap(outtaskitemid, item.collectedqty, taskQty)
        dicMtlOperatin.set(outtaskitemid, [taskQty, allocatedQty])

        decQty = decQty - allocatedQty
    END FOR

    // 规则7.1.1.6: 匹配校验
    IF ((matSendControl == '0' AND roomMatControl == '0') OR roomMatControl == '1') AND !exsitFlag THEN
        THROW Error('采集物料批号序列号信息匹配任务明细失败')
    END IF
END FUNCTION
```

### 7.2 UUID生成规则
```javascript
// 规则7.2.1: UUID生成规则
FUNCTION generateStockId() RETURNS STRING
    RETURN uuid()
END FUNCTION
```

### 7.3 数据持久化规则
```javascript
// 规则7.3.1: 数据保存规则
FUNCTION saveCollectData(matCode, batchNo, sn, qty, storeRoom, storeSite, dicMtlOperatin, erpRoom, trayNo) RETURNS VOID
    // 规则7.3.1.1: 生成采集记录
    FOR EACH [key, value] IN dicMtlOperatin
        VAR stock = {
            stockid: generateStockId(),
            matcode: matCode,
            batchno: batchNo,
            sn: sn,
            taskQty: value[0],     // 计划数
            collectQty: value[1], // 本次采集数量
            outtaskitemid: key,
            taskid: taskId,
            storeRoom: storeRoom,
            storeSite: storeSite,
            erpStore: erpRoom,
            TrayNo: trayNo
        }

        // 规则7.3.1.2: 添加到采集列表
        stocks.push(stock)
    END FOR

    // 规则7.3.1.3: 更新序列号映射
    IF sn != null AND sn != '' AND !dicSeq.has(matCode + '@' + sn) THEN
        dicSeq.set(matCode + '@' + sn, matCode + '@' + sn)
    END IF

    // 规则7.3.1.4: 更新库存数量映射
    VAR strKey = storeSite + matCode + batchNo
    IF !dicInvMtlQty.has(strKey) THEN
        dicInvMtlQty.set(strKey, qty)
    ELSE
        VAR collectQtyGet = dicInvMtlQty.get(strKey)
        dicInvMtlQty.set(strKey, collectQtyGet + qty)
    END IF
END FUNCTION
```

### 7.4 提交数据格式转换规则
```javascript
// 规则7.4.1: 提交数据格式转换
FUNCTION convertDataForSubmit(stocks) RETURNS ARRAY
    VAR downShelvesInfosList = []
    FOR EACH stock IN stocks
        VAR downShelvesInfo = {
            taskNo: taskNo,
            matCode: stock.matcode,        // 物料号
            batchNo: stock.batchno,        // 批号
            sn: stock.sn,                  // 序列号
            taskQty: stock.taskQty,        // 任务数量
            collectQty: stock.collectQty,  // 已采集数量
            storeRoomNo: stock.storeRoom,  // 库房号
            storeSiteNo: stock.storeSite,  // 库位号
            taskid: stock.taskid,          // 任务ID
            outTaskItemid: stock.outtaskitemid,  // 出库任务项ID
            erpStore: stock.erpStore      // ERP子库
        }
        downShelvesInfosList.push(downShelvesInfo)
    END FOR
    RETURN downShelvesInfosList
END FUNCTION
```

## 8. 提交校验规则

### 8.1 提交前校验
```javascript
// 规则8.1.1: 提交前校验
FUNCTION validateBeforeSubmit() RETURNS VOID
    // 规则8.1.1.1: 采集记录校验
    IF stocks.length == 0 THEN
        THROW Error('本次无采集明细，请确认！')
    END IF

    // 规则8.1.1.2: 任务完成度校验
    VAR msg = ''
    FOR EACH item IN detailListView
        VAR taskQty = parseFloat(item.hintqty)
        VAR tmpQty = parseFloat(item.collectedqty)

        IF taskQty != tmpQty THEN
            msg += '库位【' + item.storesiteno + '】物料【' + item.matcode + '】还剩【' + (taskQty - tmpQty) + '】未做'
            BREAK
        END IF
    END FOR

    // 规则8.1.1.3: 确认提示
    IF msg != '' THEN
        msg += '，请确认是否提交？'
    ELSE
        msg = '请确认是否提交？'
    END IF

    RETURN msg
END FUNCTION
```

### 8.2 报缺校验
```javascript
// 规则8.2.1: 报缺校验
FUNCTION validateBeforeReportShortage() RETURNS VOID
    // 规则8.2.1.1: 未提交数据校验
    IF stocks.length > 0 THEN
        THROW Error('采集数据未提交,不允许报缺！')
    END IF

    // 规则8.2.1.2: 选中记录校验
    IF checkedList.length <= 0 THEN
        THROW Error('请至少选择一行记录！')
    END IF
END FUNCTION
```

## 9. 系统状态管理规则

### 9.1 采集状态初始化
```javascript
// 规则9.1.1: 采集状态初始化
FUNCTION InitializeCollect() RETURNS VOID
    collectQty = 0
    BarcodeContent = {}
    focus = false
    collectFlg = ''
    matFoundFlg = ''
    erpStoreSite = ''
    batchFountFlg = '0'
    matCode = ''
    batchNo = ''
    sn = ''
    pdate = ''
    vdays = ''
    matControlFlag = ''
    strMsg = ''
    siteFlag = 'Y'
    batchFlag = 'Y'
    strKey = ''
    RepQty = 0
    matSendControl = '0'
    erpRoom = ''
    trayNo = ''
    erpStoreInv = ''
    resFlag = ''
END FUNCTION
```

### 9.2 本地数据存储规则
```javascript
// 规则9.2.1: 本地数据存储
FUNCTION localSave() RETURNS VOID
    // 规则9.2.1.1: 任务列表保存
    uni.setStorage({
        key: 'up_inTaskItemList',
        data: detailListView
    })

    // 规则9.2.1.2: 采集结果保存
    uni.setStorage({
        key: 'up_stocks',
        data: stocks
    })

    // 规则9.2.1.3: 序列号映射保存
    uni.setStorage({
        key: 'up_dicSeq',
        data: JSON.stringify(Array.from(dicSeq))
    })

    // 规则9.2.1.4: 物料数量映射保存
    uni.setStorage({
        key: 'up_dicMtlQty',
        data: JSON.stringify(Array.from(dicMtlQty))
    })

    // 规则9.2.1.5: 库存数量映射保存
    uni.setStorage({
        key: 'up_dicInvMtlQty',
        data: JSON.stringify(Array.from(dicInvMtlQty))
    })
END FUNCTION
```

## 9. 异常处理规则

### 9.1 API错误处理规则
```javascript
// 规则9.1.1: API错误信息处理
FUNCTION handleApiError(response) RETURNS VOID
    IF response.code != '200' THEN
        uni.showToast({
            icon: 'none',
            duration: 3000,
            title: response.msg
        })
        RETURN
    END IF
END FUNCTION
```

### 9.2 任务列表为空校验
```javascript
// 规则9.2.1: 任务列表为空检查
FUNCTION validateTaskListExists() RETURNS VOID
    IF detailListView.length <= 0 THEN
        uni.showModal({
            title: '采集异常',
            showCancel: false,
            content: '当前任务列表没有待处理任务！'
        })
    END IF
END FUNCTION
```

### 9.3 库位解析错误处理
```javascript
// 规则9.3.1: 库位条码格式错误处理
FUNCTION handleSiteCodeParseError(barcode) RETURNS VOID
    VAR sArry = barcode.split('$')
    IF sArry.length < 3 THEN
        this.$set(this.scanningContent, 'text', '')
        THROW Error('库位条码格式不正确')
    END IF
END FUNCTION
```

### 9.4 数量格式错误处理
```javascript
// 规则9.4.1: 数量格式错误处理
FUNCTION handleQuantityFormatError(barcode) RETURNS VOID
    IF !checkIntAndFloat(barcode) THEN
        this.$set(this.scanningContent, 'text', '')
        THROW Error('采集内容不合法！')
    END IF
END FUNCTION
```

## 10. UI交互规则

### 10.1 焦点控制规则
```javascript
// 规则10.1.1: 输入框焦点控制
FUNCTION manageInputFocus() RETURNS VOID
    // 规则10.1.1.1: 库位为空时聚焦到库位输入
    IF storeSite == '' OR storeSite == null OR storeSite == undefined THEN
        focus = false
        RETURN '请扫描库位'
    END IF

    // 规则10.1.1.2: 物料二维码为空时聚焦到二维码输入
    IF BarcodeContent.matcode == '' OR BarcodeContent.matcode == null OR BarcodeContent.matcode == undefined THEN
        focus = false
        RETURN '请扫描二维码'
    END IF

    // 规则10.1.1.3: 序列号为空且数量为0时聚焦到数量输入
    IF BarcodeContent.sn == null AND collectQty == 0 THEN
        focus = true
        RETURN '请输入数量'
    END IF

    // 规则10.1.1.4: 其他情况不聚焦
    focus = false
    RETURN ''
END FUNCTION
```

### 10.2 提示信息生成规则
```javascript
// 规则10.2.1: 动态提示信息生成
FUNCTION getPlaceMsg() RETURNS STRING
    // 规则10.2.1.1: 库位为空提示
    IF storeSite == '' OR storeSite == null OR storeSite == undefined THEN
        focus = false
        RETURN '请扫描库位'
    END IF

    // 规则10.2.1.2: 物料二维码为空提示
    IF BarcodeContent.matcode == '' OR BarcodeContent.matcode == null OR BarcodeContent.matcode == undefined THEN
        focus = false
        RETURN '请扫描二维码'
    END IF

    // 规则10.2.1.3: 序列号为空且数量为0提示
    IF BarcodeContent.sn == null AND collectQty == 0 THEN
        focus = true
        RETURN '请输入数量'
    END IF

    // 规则10.2.1.4: 完成状态提示
    focus = false
    RETURN ''
END FUNCTION
```

### 10.3 扫描内容清除规则
```javascript
// 规则10.3.1: 扫描内容清除
FUNCTION clearScanningContent() RETURNS VOID
    this.$set(this.scanningContent, 'text', '')
END FUNCTION
```

## 11. 状态管理规则

### 11.1 采集完成后状态重置规则
```javascript
// 规则11.1.1: 采集状态完整重置
FUNCTION InitializeCollect() RETURNS VOID
    collectQty = 0
    BarcodeContent = {}
    focus = false
    collectFlg = ''
    matFoundFlg = ''
    erpStoreSite = ''
    batchFountFlg = '0'
    matCode = ''
    batchNo = ''
    sn = ''
    pdate = ''
    vdays = ''
    matControlFlag = ''
    strMsg = ''
    siteFlag = 'Y'
    batchFlag = 'Y'
    strKey = ''
    RepQty = 0
    matSendControl = '0'
    erpRoom = ''
    trayNo = ''
    erpStoreInv = ''
    resFlag = ''
END FUNCTION
```

### 11.2 页面切换时的数据保存规则
```javascript
// 规则11.2.1: 本地数据存储
FUNCTION localSave() RETURNS VOID
    // 规则11.2.1.1: 任务列表保存
    uni.setStorage({
        key: 'up_inTaskItemList',
        data: detailListView,
        success: function () {
            console.log('采集成功后 任务列表保存成功')
        }
    })

    // 规则11.2.1.2: 采集结果保存
    uni.setStorage({
        key: 'up_stocks',
        data: stocks,
        success: function () {
            console.log('采集成功后 采集列表保存成功')
        }
    })

    // 规则11.2.1.3: 序列号映射保存
    uni.setStorage({
        key: 'up_dicSeq',
        data: JSON.stringify(Array.from(dicSeq)),
        success: function () {
            console.log('采集成功后 采集列表保存成功')
        }
    })

    // 规则11.2.1.4: 物料数量映射保存
    uni.setStorage({
        key: 'up_dicMtlQty',
        data: JSON.stringify(Array.from(dicMtlQty)),
        success: function () {
            console.log('采集成功后 采集列表保存成功')
        }
    })

    // 规则11.2.1.5: 库存数量映射保存
    uni.setStorage({
        key: 'up_dicInvMtlQty',
        data: JSON.stringify(Array.from(dicInvMtlQty)),
        success: function () {
            console.log('采集成功后 采集列表保存成功')
        }
    })
END FUNCTION
```

## 12. 选择操作规则

### 12.1 全选/反选逻辑规则
```javascript
// 规则12.1.1: 表格全选逻辑
FUNCTION handleCheckAll(selectItem, detailListView) RETURNS VOID
    IF selectItem.is_selected THEN
        checkedIds = detailListView.map((item) => item.outtaskitemid)
    ELSE
        checkedIds = []
    END IF
    checkedList = detailListView.filter((item) => inArray(item.outtaskitemid, checkedIds))
END FUNCTION

// 规则12.1.2: 表格全选逻辑（第二列表）
FUNCTION handleCheckAll2(selectItem, detailListView2) RETURNS VOID
    IF selectItem.is_selected THEN
        checkedIds = detailListView2.map((item) => item.outtaskitemid)
    ELSE
        checkedIds = []
    END IF
    checkedList = detailListView2.filter((item) => inArray(item.outtaskitemid, checkedIds))
END FUNCTION
```

### 12.2 单选逻辑规则
```javascript
// 规则12.2.1: 表格单选逻辑
FUNCTION handleCheckItem(selectItem) RETURNS VOID
    VAR index = checkedIds.findIndex((id) => id === selectItem.item.outtaskitemid)
    IF selectItem.is_selected THEN
        IF index < 0 THEN
            checkedIds.push(selectItem.item.outtaskitemid)
        END IF
    ELSE
        IF index >= 0 THEN
            checkedIds.splice(index, 1)
        END IF
    END IF
    checkedList = detailListView.filter((item) => inArray(item.outtaskitemid, checkedIds))
END FUNCTION

// 规则12.2.2: 表格单选逻辑（第二列表）
FUNCTION handleCheckItem2(selectItem) RETURNS VOID
    VAR index = checkedIds.findIndex((id) => id === selectItem.item.outtaskitemid)
    IF selectItem.is_selected THEN
        IF index < 0 THEN
            checkedIds.push(selectItem.item.outtaskitemid)
        END IF
    ELSE
        IF index >= 0 THEN
            checkedIds.splice(index, 1)
        END IF
    END IF
    checkedList = detailListView2.filter((item) => inArray(item.outtaskitemid, checkedIds))
END FUNCTION
```

## 13. 业务流程规则

### 13.1 采集完成提示规则
```javascript
// 规则13.1.1: 采集完成提示处理
FUNCTION handleCollectComplete() RETURNS VOID
    // 规则13.1.1.1: 显示成功提示
    uni.showToast({
        icon: 'none',
        duration: 3000,
        title: '采集完成'
    })

    // 规则13.1.1.2: 重置采集状态
    InitializeCollect()

    // 规则13.1.1.3: 清除扫描内容
    clearScanningContent()
END FUNCTION
```

### 13.2 数据提交后的清理规则
```javascript
// 规则13.2.1: 提交成功后数据处理
FUNCTION handleSubmitSuccess() RETURNS VOID
    // 规则13.2.1.1: 清空采集列表
    stocks = []

    // 规则13.2.1.2: 清空选中列表
    checkedIds = []
    checkedList = []

    // 规则13.2.1.3: 重置采集状态
    InitializeCollect()

    // 规则13.2.1.4: 刷新任务列表
    getList()

    // 规则13.2.1.5: 显示成功提示
    uni.showToast({
        icon: 'none',
        duration: 3000,
        title: '提交成功'
    })
END FUNCTION
```

### 13.3 页面返回校验规则
```javascript
// 规则13.3.1: 页面返回时的数据校验
FUNCTION validateBeforePageBack() RETURNS VOID
    IF stocks.length > 0 THEN
        uni.showModal({
            title: '提示',
            content: '当前采集记录尚未提交 确定退出采集吗？',
            success: (res) => {
                IF res.confirm THEN
                    uni.$off('scancodedate')
                    uni.reLaunch({
                        url: '/pages/goodsdown/goodsDown'
                    })
                END IF
            }
        })
    ELSE
        uni.$off('scancodedate')
        uni.reLaunch({
            url: '/pages/goodsdown/goodsDown'
        })
    END IF
END FUNCTION
```

## 14. 单元测试建议

### 14.1 测试用例分类
1. **条码识别测试** - 验证各种条码格式的正确识别
2. **物料控制测试** - 验证不同物料控制模式的业务逻辑
3. **库存校验测试** - 验证库存充足性和一致性校验
4. **数量处理测试** - 验证数量分配和计算逻辑
5. **数据处理测试** - 验证数据持久化和状态管理
6. **边界条件测试** - 验证异常情况的处理

### 10.2 测试数据建议
- 准备不同控制模式的测试物料
- 准备不同状态的测试库位
- 准备不同批次的测试库存
- 准备完整的任务明细数据

### 10.3 测试覆盖要求
- 所有校验规则的覆盖率达到100%
- 所有异常处理路径的覆盖率达到100%
- 所有业务流程的覆盖率达到100%