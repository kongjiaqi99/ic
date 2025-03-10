<script setup lang="ts">
import { Search, MoreFilled, ArrowRight, ArrowDown } from '@element-plus/icons-vue'
import { useApp } from "@/hooks/useApp";
import { RightPanel } from "@/components/index";
import { CreateInvestment, CreatePurchase } from "./components/index";
import { CreateOrEditEntity } from "@/views/client/components/index";
import { PopupKey } from "@/symbols/index"
import { InvestmentKey } from '@/symbols/investment';
import { EntityKey } from '@/symbols/client';

import { ElMessage, ElMessageBox } from 'element-plus';
import { useDownLoad } from "@/hooks/useDownload";
import { wrapperEnv } from '@/utils/env'

const { VITE_WEB_ENV } = wrapperEnv

const { setBreadcrumbList } = useApp()
const { downloadFile } = useDownLoad()
const router = useRouter()
const webColor = VITE_WEB_ENV === 'ic' ? '#BE9670' : '#AD262F'

const rightPanel = ref<any>()
const rightPanel2 = ref<any>()
const loading = ref(true)
const isRefresh = ref(false)
const showStatement = ref(false)
const showStatementAll = ref(false)
const tableHeight = ref(600)

//导入rightPanel数组
const panelComponents = [
    {
        name: 'add',
        component: CreateInvestment
    },
    {
        name: 'edit',
        component: CreateInvestment
    },
    {
        name: 'purchase',
        component: CreatePurchase
    }
]

//设置默认rightPanel
const selectPanel = ref(null)

//filter 过滤select数组
const options = [
    {
        value: 0,
        label: 'Client',
        name: 'clientName'
    },
    {
        value: 1,
        label: 'ic ID',
        name: 'icId'
    },
    {
        value: 2,
        label: 'Entity',
        name: 'entityName'
    },
    {
        value: 3,
        label: 'Fund',
        name: 'fundName'
    }
]

const investmentInfo = ref<AnyObj>({})

//过滤当前选中
const filterType = ref(null)

//搜索字段
const searchStr = ref('')

//admin list数组
const tableData = ref([])

//table 数据总数
const listTotal = ref(0)
//每页几条
const pageSize = ref(10)
//第几页
const pageNum = ref(1)

const investmentId = ref(null)
const selectInvestmentInfo = ref({})

const centerDialogVisible = ref(false)

const selectEmail = ref(1)
const pinkDate = ref(null)
const selectIdList = ref([])
const downloadMonth = ref(null)

//clientInfo
const clientInfo = ref(null)

onMounted(() => {
    getInvestmentInfo()
    getInvestmentList()
    nextTick(() => {
        const title = document.getElementById('title').clientHeight
        const fund = document.getElementById('investment').clientHeight
        const tool = document.getElementById('tool').clientHeight
        const pagination = document.getElementById('pagination').clientHeight
        tableHeight.value = fund - title - tool - pagination
    })
})

const handleShowStatement = (type: string) => {
    if (type === 'all') {
        showStatementAll.value = !showStatementAll.value
    } else {
        showStatement.value = !showStatement.value
    }
}

async function getInvestmentList() {
    selectPanel.value = null
    let params = {
        pageSize: pageSize.value,
        pageNum: pageNum.value
    }
    let query = {}
    if (filterType.value || filterType.value === 0) {
        query = {
            [options[filterType.value].name]: searchStr.value
        }
    }
    const [e, r] = await api.queryInvestment(query, params)
    loading.value = false
    if (!e && r) {
        console.log(r.data?.list);
        listTotal.value = r.data?.total || 0
        tableData.value = r.data?.list || []
    } else {
        console.log(e);
    }
}

async function getInvestmentInfo() {
    const params = {}
    const [e, r] = await api.queryGlobal(params)
    if (!e && r) {
        investmentInfo.value = r?.data || {}
    } else {
        console.log(e);
    }
}

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    getInvestmentList()
}

//清除条件
const handleClear = () => {
    filterType.value = null
    searchStr.value = ''
    pageNum.value = 1
    getInvestmentList()
}

//条件查询
const handleSearch = () => {
    pageNum.value = 1
    getInvestmentList()
}

//添加Investment
const handleAddInvestment = () => {
    setBreadcrumbList([{
        name: 'Create Investment'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'add'
    })
    investmentId.value = null
    rightPanel.value.handleIsShow()
}

// //查看详情
// const handleViewInvestment = (item: AnyObj) => {
//     setBreadcrumbList([{
//         name: 'View Investment'
//     }])
//     selectPanel.value = panelComponents.findIndex((item) => {
//         return item.name === 'view'
//     })
//     investmentId.value = item.id
//     rightPanel.value.handleIsShow()
// }

//编辑Investment
const handleEditInvestment = (item: AnyObj) => {
    // setBreadcrumbList([{
    //     name: 'Edit Investment'
    // }])
    // selectPanel.value = panelComponents.findIndex((item) => {
    //     return item.name === 'edit'
    // })
    // investmentId.value = item.id
    // rightPanel.value.handleIsShow()
    setBreadcrumbList([{
        name: `${item.clientName}`
    }])
    // selectPanel.value = panelComponents.findIndex((item) => {
    //     return item.name === 'view'
    // })
    // clientId.value = item.id
    // rightPanel.value.handleIsShow()
    router.push({ path: `/client/detail/${item.clientId}`, query: { eId: item.entityId } }).catch((err) => {
        console.warn(err)
    })
}

//编辑Purchase
const handleEditPurchase = (item: AnyObj) => {
    setBreadcrumbList([{
        name: 'Create Purchase'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'purchase'
    })
    selectInvestmentInfo.value = item
    rightPanel.value.handleIsShow()
}

//删除Investment
const handleShowDelInvestment = () => {
    centerDialogVisible.value = true
}

//删除Investment
const handleDelInvestment = async (item: AnyObj) => {
    const params = {
        // id: item.pfId[0],
        idList: item.pfId
    }
    const [e, r] = await api.delPurchasedFund(params)
    if (!e && r) {
        if (r.data) {
            ElMessage.success('delete success')
        }
        centerDialogVisible.value = false
        getInvestmentList()
    }
}

//关闭RightPanel
const closeRightPanel = (t: string) => {
    if (t === 'entity') {
        if (rightPanel2.value) {
            isRefresh.value = true
            rightPanel2.value.handleIsShow()
        }
    } else {
        if (rightPanel.value) {
            rightPanel.value.handleIsShow()
        }
    }

}

const handleSelectionChange = (item) => {
    if (item.length > 0) {
        selectIdList.value = []
        item.forEach(element => {
            selectIdList.value = selectIdList.value.concat(element.pfId)
        })
    } else {
        selectIdList.value = []
    }


}

const handleSendEmail = async () => {
    // if (selectIdList.value.length <= 0) return
    let params: AnyObj = {
        startDate: pinkDate.value,
        idList: selectIdList.value,
        templateType: selectEmail.value
    }
    const [e, r] = await api.sendMail(params)
    if (!e && r) {
        ElMessage.success('send success')
    }
}

const handleSendUnitCertificate = async (item: AnyObj) => {
    let params = {
        idList: item.pfId,
    }
    const [e, r] = await api.sendUnitCertificate(params)
    if (!e && r) {
        if (r?.success) {
            ElMessage.success('send success')
        }
    }
}

const handleShowEntity = async (id: string) => {
    let params = {
        id: id
    }
    const [e, r] = await api.queryClientDetailById(params)
    if (!e && r) {
        clientInfo.value = r?.data || {}
        rightPanel2.value.handleIsShow()
    }
}

const exportInv = async (str: string) => {
    const name = 'investment'
    let query: AnyObj = {}
    if (filterType.value || filterType.value === 0) {
        query = {
            [options[filterType.value].name]: searchStr.value
        }
    }
    if (downloadMonth.value) {
        query.startDate = downloadMonth.value[0]
        query.endDate = downloadMonth.value[1]
    }
    console.log("🚀 ~ exportInv ~ query:", query)
    if (str === 'csv') {
        api.exportCsv(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'xml') {
        api.exportXml(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'json') {
        api.exportJson(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    }
}

//查看详情
const handleViewClient = (item: AnyObj) => {
    setBreadcrumbList([{
        name: `${item.clientName}`
    }])
    router.push({ path: `/client/detail/${item.clientId}` }).catch((err) => {
        console.warn(err)
    })
}

//向下抛出回调方法以及弹窗显隐
provide(PopupKey, { func: closeRightPanel, isRefresh: isRefresh })

provide(InvestmentKey, { iId: investmentId, info: selectInvestmentInfo })
provide(EntityKey, { eId: ref(null), clientInfo: clientInfo, entityInfo: {} })
</script>
<template>
    <div class="info">
        <div class="item">
            <div class="name">Number of Investment</div>
            <div class="number">
                <el-statistic :value="investmentInfo.investmentCount"></el-statistic>
            </div>
        </div>
        <div class="item">
            <div class="name">Total investment</div>
            <div class="number">
                <el-statistic :value="investmentInfo.totalInvestment" :precision="2" prefix="$"></el-statistic>
            </div>
        </div>
        <div class="item">
            <div class="name">Current investment return</div>
            <div class="number">
                <el-statistic :value="investmentInfo.currentReturn" :precision="2" prefix="$"></el-statistic>
            </div>
        </div>
        <div class="item">
            <div class="name">Previous investment return</div>
            <div class="number">
                <el-statistic :value="investmentInfo.previousInvestment" :precision="2" prefix="$"></el-statistic>
            </div>
        </div>
    </div>
    <div>
    </div>
    <div class="investment" id="investment" v-loading="loading">
        <div class="title" id="title">Investment List</div>
        <div class="tool-box" id="tool">
            <div class="flex">
                <el-select class="select" v-model="filterType" clearable placeholder="Filter by">
                    <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
                </el-select>
                <el-input v-model="searchStr" class="m-lr-20" placeholder="Search" :prefix-icon="Search" clearable />
                <el-button class="text-white color-web-bg" @click="handleSearch">
                    Search
                </el-button>
                <el-button class="text-828282" type="primary" color="#E8E8E8" @click="handleClear">
                    Clear
                </el-button>
            </div>
            <div class="flex">
                <el-button v-permission="'Investment'" type="primary" color="#4E9F1C" @click="handleAddInvestment">
                    New Investment
                    <el-icon>
                        <ArrowRight />
                    </el-icon>
                </el-button>
                <el-popover :visible="showStatementAll" placement="bottom" :width="255" trigger="click">
                    <template #reference>
                        <el-button v-permission="'Investment'" class="text-white color-web-bg"
                            @click="handleShowStatement('all')">
                            Send to All
                        </el-button>
                    </template>
                    <div class="email-select">
                        <div class="title">Send to All</div>
                        <el-radio-group v-model="selectEmail">
                            <el-radio :value="1">Month</el-radio>
                            <el-radio :value="2">Year</el-radio>
                        </el-radio-group>
                        <el-date-picker v-model="pinkDate" :type="selectEmail === 1 ? 'month' : 'year'"
                            :placeholder="selectEmail === 1 ? 'Pick a month' : 'Pick a year'"
                            :format="selectEmail === 1 ? 'YYYY-MM' : 'YYYY'" value-format="YYYY-MM-DD" />
                        <el-button class="text-white m-tb-20 color-web-bg" @click="handleSendEmail">
                            Send
                        </el-button>
                    </div>
                </el-popover>
                <el-popover :visible="showStatement" placement="bottom" :width="255" trigger="click">
                    <template #reference>
                        <el-button v-permission="'Investment'" class="text-white color-web-bg"
                            @click="handleShowStatement('')">
                            Bulk sending
                            <el-icon>
                                <ArrowDown />
                            </el-icon>
                        </el-button>
                    </template>
                    <div class="email-select">
                        <div class="title">Bulk Sending</div>
                        <el-radio-group v-model="selectEmail">
                            <el-radio :value="1">Month</el-radio>
                            <el-radio :value="2">Year</el-radio>
                        </el-radio-group>
                        <el-date-picker v-model="pinkDate" :type="selectEmail === 1 ? 'month' : 'year'"
                            :placeholder="selectEmail === 1 ? 'Pick a month' : 'Pick a year'"
                            :format="selectEmail === 1 ? 'YYYY-MM' : 'YYYY'" value-format="YYYY-MM-DD" />
                        <el-button class="text-white m-tb-20 color-web-bg" @click="handleSendEmail">
                            Send
                        </el-button>
                    </div>
                </el-popover>
            </div>
        </div>
        <div class="table" :style="{ height: `${tableHeight}px` }">
            <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                v-if="tableData.length > 0" @selection-change="handleSelectionChange">
                <el-table-column type="selection" width="55" fixed="left" />
                <el-table-column prop="clientName" label="Client" :align="'center'" width="150" fixed="left">
                    <template #default="scope">
                        <div class="table-name pointer" @click="handleViewClient(scope.row)">
                            <span>{{ scope.row.clientName }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="icId" label="ic ID" :align="'left'" width="150" />
                <el-table-column prop="entityName" label="Entity" :align="'left'" width="150" />
                <el-table-column prop="fundName" label="Fund" width="200" />
                <el-table-column prop="monthReturn" label="Current investment return" width="200" :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.monthReturn" :precision="2" :value-style="{ fontSize: '14px' }"
                            prefix="$"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="currentReturn" label="Total investment return" width="180" :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.currentReturn" :precision="2"
                            :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="purchasedAmount" label="Investment amount" width="180" :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.purchasedAmount" :precision="2"
                            :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="recordCount" label="Investment Record" width="180" :align="'center'" />
                <el-table-column prop="status" label="Investment Status" width="150" :align="'center'">
                    <template #default="scope">
                        <el-tag class="text-white" :color="scope.row.status === 'On-Going' ? '#4E9F1C' : webColor">
                            {{ scope.row.status }}
                        </el-tag>
                    </template>
                </el-table-column>
                <el-table-column prop="" label="Action" :align="'center'" fixed="right">
                    <template #default="scope">
                        <div class="pointer">
                            <el-popover placement="bottom" :width="170" trigger="hover">
                                <template #reference>
                                    <el-icon :size="30" color="#969696">
                                        <MoreFilled />
                                    </el-icon>
                                </template>
                                <div v-permission="'Investment'" class="action">
                                    <div class="item" @click="handleEditPurchase(scope.row)">Purchase</div>
                                    <div class="item" @click="handleEditInvestment(scope.row)">Edit</div>
                                    <div class="item" @click="handleShowDelInvestment()">Delete</div>
                                    <div class="item" @click="handleSendUnitCertificate(scope.row)">Send</div>
                                    <el-dialog v-model="centerDialogVisible" title="Message" width="30%" align-center>
                                        <span>Are you sure to delete this?</span>
                                        <template #footer>
                                            <span class="dialog-footer">
                                                <el-button @click="centerDialogVisible = false">Cancel</el-button>
                                                <el-button type="primary" @click="handleDelInvestment(scope.row)">
                                                    Confirm
                                                </el-button>
                                            </span>
                                        </template>
                                    </el-dialog>
                                </div>
                            </el-popover>
                        </div>
                    </template>
                </el-table-column>
            </el-table>
            <el-empty :image-size="200" v-else />
        </div>
        <div class="pagination" id="pagination">
            <div class="down-area">
                <template v-if="tableData.length > 0">
                    <div class="">Download:</div>
                    <div class="download-link" @click="exportInv('csv')">CSV</div>
                    <div class="download-link" @click="exportInv('xml')">XML</div>
                    <div class="download-link" @click="exportInv('json')">JSON</div>
                    <div class="padding-left-5">
                        <!-- <el-date-picker v-model="downloadMonth" type="month" placeholder="Pick a month" format="YYYY-MM"
                            value-format="YYYY-MM-DD" /> -->
                        <el-date-picker v-model="downloadMonth" type="daterange" range-separator="To"
                            start-placeholder="Start date" end-placeholder="End date" value-format="YYYY-MM-DD"
                            format="YYYY-MM-DD" />
                    </div>
                </template>
            </div>
            <el-pagination background layout="total,consists of sizes, prev, pager, next, jumper, ->, slot"
                :total="listTotal" v-model:page-size="pageSize" v-model:current-page="pageNum"
                @current-change="handleCurrentChange" />
        </div>
    </div>
    <RightPanel ref="rightPanel" @back-Fn="getInvestmentList">
        <template #content>
            <component :is="panelComponents[selectPanel].component" v-if="selectPanel !== null"
                @show-entity="handleShowEntity"></component>
        </template>
    </RightPanel>
    <RightPanel ref="rightPanel2" @back-Fn="() => { }">
        <template #content>
            <CreateOrEditEntity></CreateOrEditEntity>
        </template>
    </RightPanel>
</template>

<style lang="scss" scoped>
.info {
    display: flex;
    justify-content: space-between;
    align-items: center;
    padding-bottom: 20px;
    gap: 20px;

    .item {
        width: calc((100% - 60px) / 4);
        height: 163px;
        border-radius: 8px;
        background: #FFF;
        box-shadow: 0px 5px 12px 0px rgba(106, 106, 106, 0.10);
        padding: 30px;

        .name {
            color: #363636;
            font-size: 20px;
            font-style: normal;
            font-weight: 600;
        }

        .number {
            padding-top: 10px;
            color: #333;
            font-size: 48px;
            font-style: normal;
            font-weight: 500;
        }
    }
}

.investment {
    min-height: 100%;
    border-radius: 12px;
    background: #FFF;
    box-shadow: 0px 1px 1px 0px rgba(0, 0, 0, 0.08), 0px 2px 1px 0px rgba(0, 0, 0, 0.06), 0px 1px 3px 0px rgba(0, 0, 0, 0.10);

    .title {
        color: #1C1C1C;
        font-size: 24px;
        font-style: normal;
        font-weight: 700;
        padding: 48px 56px 16px;
    }

    .tool-box {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 56px 16px;

        .flex {
            display: flex;
            align-items: center;

            .select {
                width: 220px;
            }
        }

        .m-lr-20 {
            margin: 0 20px;
        }

        .text-white {
            color: #ffffff;
        }

        .text-828282 {
            color: #828282;
        }

        .m-l-20 {
            margin-left: 20px;
        }
    }

    .table {
        display: flex;
        justify-content: center;
        align-items: center;
    }
}

.table-img {
    max-width: 100px;
    max-height: 100px;

    .img-bg {
        max-width: 100px;
        max-height: 100px;
        width: auto;
        height: auto;
        display: block;
    }
}

.table-cut {
    overflow: hidden;
    display: -webkit-box;
    -webkit-line-clamp: 3;
    -webkit-box-orient: vertical;
    word-break: break-all;
}

.text-white {
    color: #fff;
}

.email-select {
    text-align: center;

    .title {
        text-align: center;
        padding-bottom: 15px;
    }

    .m-tb-20 {
        margin: 10px 0;
    }
}

.table ::v-deep(.el-statistic__prefix) {
    font-size: 14px;
}

.padding-left-5 {
    padding-left: 10px;
}
</style>