<script setup lang="ts">
import { Search, MoreFilled, ArrowRight } from '@element-plus/icons-vue'
import { useApp } from "@/hooks/useApp";
import { RightPanel } from "@/components/index";
import { ViewFund, CreateOrEditFund } from "./components/index";
import { PopupKey } from "@/symbols/index"
import { FundKey } from '@/symbols/fund';
import { ElMessage } from 'element-plus';
import { useDownLoad } from "@/hooks/useDownload";

const { setBreadcrumbList } = useApp()
const { downloadFile } = useDownLoad()
const rightPanel = ref<any>()
const loading = ref(true)
const tableHeight = ref(600)
const router = useRouter()

//导入rightPanel数组
const panelComponents = [
    {
        name: 'view',
        component: ViewFund
    },
    {
        name: 'add',
        component: CreateOrEditFund
    },
    {
        name: 'edit',
        component: CreateOrEditFund
    }
]

//设置默认rightPanel
const selectPanel = ref(null)

//filter 过滤select数组
const options = [
    {
        value: 0,
        label: 'Fund',
        name: 'name'
    },
    {
        value: 1,
        label: 'Investment type',
        name: 'investmentType'
    },
    {
        value: 2,
        label: 'Product type',
        name: 'productType'
    }
]

const fundStatusList = ref([])
const fundCategoryList = ref([])
const fundLocation = ref([])
//当前选中语言
const fundStatus = ref(null)
const fundCategory = ref(null)

//过滤当前选中
const filterType = ref(null)
const fundLocationSelect = ref(null)

//搜索字段
const searchStr = ref('')

//Fund list数组
const tableData = ref([
])

//table 数据总数
const listTotal = ref(0)
//每页几条
const pageSize = ref(10)
//第几页
const pageNum = ref(1)

const fundId = ref(null)

const centerDialogVisible = ref(false)

onMounted(() => {
    // console.log(router?.currentRoute.value.query);
    const status = router?.currentRoute.value.query?.status
    if (status === 'view') {
        selectPanel.value = null
        setTimeout(() => {
            handleViewFund({
                id: router?.currentRoute.value.query?.fundId
            })
        }, 500)
    } else if (status === 'edit') {
        selectPanel.value = null
        setTimeout(() => {
            handleEditFund({
                id: router?.currentRoute.value.query?.fundId
            })
        }, 500)
    }
    getFundList()
    getFundStatus()
    getFundCategory()
    getLocation()
    nextTick(() => {
        const title = document.getElementById('title').clientHeight
        const fund = document.getElementById('fund').clientHeight
        const tool = document.getElementById('tool').clientHeight
        const pagination = document.getElementById('pagination').clientHeight
        console.log(fund - title - tool - pagination);
        tableHeight.value = fund - title - tool - pagination
    })
})

async function getFundList() {
    selectPanel.value = null
    let params = {
        pageSize: pageSize.value,
        pageNum: pageNum.value
    }
    let query: AnyObj = {}
    if (filterType.value || filterType.value === 0) {
        query = {
            [options[filterType.value].name]: searchStr.value
        }
    }
    if (fundStatus.value !== null) {
        query = {
            ...query,
            fundStatus: fundStatusList.value[fundStatus.value]?.value
        }
    }
    if (fundCategory.value !== null) {
        query = {
            ...query,
            fundCategory: fundCategoryList.value[fundCategory.value]?.value
        }
    }
    if (fundLocationSelect.value !== null) {
        query = {
            ...query,
            stateId: fundLocationSelect.value
        }
    }
    const [e, r] = await api.queryFunds(query, params)
    loading.value = false
    if (!e && r) {
        console.log(r.data?.list);
        listTotal.value = r.data?.total || 0
        tableData.value = r.data?.list || []
        // r.data?.list.map((item: AnyObj) => {
        //     // if(item.)
        //     console.log(item);

        // })
    } else {
        console.log(e);
    }

}


async function getFundStatus() {
    let query = {
        type: 'fund_status'
    }
    const [e, r] = await api.queryDictionary(query)
    if (!e && r) {
        fundStatusList.value = r?.data || []
    } else {
        console.log(e);
    }
}

async function getFundCategory() {
    let query = {
        type: 'fund_category'
    }
    const [e, r] = await api.queryDictionary(query)
    if (!e && r) {
        fundCategoryList.value = r?.data || []
    } else {
        console.log(e);
    }
}

async function getLocation() {
    let query = {
        type: 'state'
    }
    const [e, r] = await api.queryDictionary(query)
    if (!e && r) {
        // console.log("🚀 ~ getLocation ~ r:", r?.data)
        fundLocation.value = r?.data || []
    } else {
        console.log(e);
    }
}

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    getFundList()
}

//清除条件
const handleClear = () => {
    filterType.value = null
    searchStr.value = ''
    pageNum.value = 1
    fundStatus.value = ''
    fundCategory.value = ''
    getFundList()
}

//条件查询
const handleSearch = () => {
    pageNum.value = 1
    getFundList()
}

//添加Fund
const handleAddFund = () => {
    setBreadcrumbList([{
        name: 'Create Fund'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'add'
    })
    fundId.value = null
    rightPanel.value.handleIsShow()
}

//查看详情
const handleViewFund = (item: AnyObj) => {
    setBreadcrumbList([{
        name: 'View Fund'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'view'
    })
    fundId.value = item.id
    rightPanel.value.handleIsShow()
}

//编辑Fund
const handleEditFund = (item: AnyObj) => {
    setBreadcrumbList([{
        name: 'Edit Fund'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'edit'
    })
    fundId.value = item.id
    rightPanel.value.handleIsShow()
}

//删除Fund
const handleShowDelFund = () => {
    centerDialogVisible.value = true
}

//删除管理员
const handleDelFund = async (item: AnyObj) => {
    const params = {
        id: item.id
    }
    const [e, r] = await api.delFund(params)
    if (!e && r) {
        if (r.data) {
            ElMessage.success('delete success')
        }
        centerDialogVisible.value = false
        getFundList()
    }
}

//关闭RightPanel
const closeRightPanel = () => {
    if (rightPanel.value) {
        rightPanel.value.handleIsShow()
    }
}

//切换语言查询
const handleChangeLan = () => {
    getFundList()
}

const exportFund = async (str: string) => {
    const name = 'fund'
    let query = {}
    if (filterType.value || filterType.value === 0) {
        query = {
            [options[filterType.value].name]: searchStr.value
        }
    }
    if (fundStatus.value !== null) {
        query = {
            ...query,
            fundStatus: fundStatusList.value[fundStatus.value]?.value
        }
    }
    if (fundCategory.value !== null) {
        query = {
            ...query,
            fundCategory: fundCategoryList.value[fundCategory.value]?.value
        }
    }
    if (fundLocationSelect.value !== null) {
        query = {
            ...query,
            stateId: fundLocationSelect.value
        }
    }
    if (str === 'csv') {
        api.exportFundsCsv(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'xml') {
        api.exportFundsXml(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'json') {
        api.exportFundsJson(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    }
}

//向下抛出回调方法以及弹窗显隐
provide(PopupKey, { func: closeRightPanel })

provide(FundKey, { fId: fundId })
</script>
<template>
    <div class="fund" id="fund" v-loading="loading">
        <div class="title" id="title">Fund List</div>
        <div class="tool-box" id="tool">
            <div class="flex">
                <el-select class="select" v-model="filterType" clearable placeholder="Filter by">
                    <el-option v-for="item in options" :key="item.value" :label="item.label" :value="item.value" />
                </el-select>
                <el-input v-model="searchStr" class="m-lr-20 width-200" placeholder="Search" :prefix-icon="Search"
                    clearable />
                <el-button class="text-white color-web-bg" @click="handleSearch">
                    Search
                </el-button>
                <el-button class="text-828282" type="primary" color="#E8E8E8" @click="handleClear">
                    Clear
                </el-button>
                <el-select class="select-150 m-l-20" v-model="fundCategory" clearable placeholder="B Fund Category"
                    @change="handleChangeLan">
                    <el-option v-for="item in fundCategoryList" :key="item.value" :label="item.code"
                        :value="item.value" />
                </el-select>
                <el-select class="select m-l-20" v-model="fundStatus" clearable placeholder="Fund Status"
                    @change="handleChangeLan">
                    <el-option v-for="item in fundStatusList" :key="item.value" :label="item.code"
                        :value="item.value" />
                </el-select>
                <el-select class="select m-l-20" v-model="fundLocationSelect" clearable placeholder="Fund Location"
                    @change="handleChangeLan">
                    <el-option v-for="item in fundLocation" :key="item.value" :label="item.code" :value="item.id" />
                </el-select>
                <!-- <el-select v-model="ruleForm.stateId" placeholder="Select Location" @change="handleLocation" clearable>
                    <el-option :label="item.code" :value="item.id" v-for="(item, index) in fundLocation" :key="index" />
                </el-select> -->
            </div>
            <div>
                <el-button v-permission="'Fund'" type="primary" color="#4E9F1C" @click="handleAddFund">
                    New Fund
                    <el-icon>
                        <ArrowRight />
                    </el-icon>
                </el-button>
            </div>
        </div>
        <div class="table">
            <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                v-if="tableData.length > 0">
                <el-table-column prop="id" label="Fund ID" :align="'center'" fixed="left" width="100">
                </el-table-column>
                <el-table-column prop="name" label="Fund" :align="'left'" width="200" fixed="left">
                    <template #default="scope">
                        <div class="table-name pointer" @click="handleViewFund(scope.row)">
                            <span>{{ scope.row.name }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="cover" label="Image" :align="'center'" width="150">
                    <template #default="scope">
                        <div class="table-img">
                            <el-image style="width: 100px; height: 100px" :src="scope.row.cover || scope.row.coverCn"
                                fit="contain" v-if="scope.row.cover || scope.row.coverCn" />
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="settlementDate" label="Settlement Date" :align="'left'" width="180" />
                <el-table-column prop="interestStartsDate" label="Interest Start Date" width="180" />
                <el-table-column prop="amount" label="Amount" width="150">
                    <template #default="scope">
                        <el-statistic :value="scope.row.amount" :precision="2" :value-style="{ fontSize: '14px' }"
                            prefix="$"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="currency" label="Currency" width="100" />
                <el-table-column prop="fundType" label="Fund Category" width="180">
                </el-table-column>
                <el-table-column prop="investmentType" label="Investment Type" width="200" />
                <el-table-column prop="productType" label="Product Type" width="150" />
                <el-table-column prop="purchaseMinAmount" label="Minimum Required Investment amount" width="150">
                    <template #default="scope">
                        <el-statistic :value="Number(scope.row.purchaseMinAmount)" :precision="2"
                            :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="fundStatus" label="Fund Status" width="150" />
                <el-table-column prop="" label="Action" :align="'center'" fixed="right">
                    <template #default="scope">
                        <div class="pointer">
                            <el-popover placement="bottom" :width="170" trigger="hover">
                                <template #reference>
                                    <el-icon :size="30" color="#969696">
                                        <MoreFilled />
                                    </el-icon>
                                </template>
                                <div class="action">
                                    <div class="item" @click="handleViewFund(scope.row)">View</div>
                                    <div v-permission="'Fund'" class="item" @click="handleEditFund(scope.row)">Edit
                                    </div>
                                    <div v-permission="'Fund'" class="item" @click="handleShowDelFund()">Delete</div>
                                    <el-dialog v-model="centerDialogVisible" title="Message" width="30%" align-center>
                                        <span>Are you sure to delete this?</span>
                                        <template #footer>
                                            <span class="dialog-footer">
                                                <el-button @click="centerDialogVisible = false">Cancel</el-button>
                                                <el-button type="primary" @click="handleDelFund(scope.row)">
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
                    <div class="download-link" @click="exportFund('csv')">CSV</div>
                    <div class="download-link" @click="exportFund('xml')">XML</div>
                    <div class="download-link" @click="exportFund('json')">JSON</div>
                </template>
            </div>
            <el-pagination background layout="total,consists of sizes, prev, pager, next, jumper, ->, slot"
                :total="listTotal" v-model:page-size="pageSize" v-model:current-page="pageNum"
                @current-change="handleCurrentChange" />
        </div>
    </div>
    <RightPanel ref="rightPanel" @back-Fn="getFundList">
        <template #content>
            <component :is="panelComponents[selectPanel].component" v-if="selectPanel !== null"></component>
        </template>
    </RightPanel>
</template>

<style lang="scss" scoped>
.fund {
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
                width: 120px;
            }

            .select-150 {
                width: 140px;
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

::v-deep(.el-statistic__prefix) {
    font-size: 14px;
}
</style>