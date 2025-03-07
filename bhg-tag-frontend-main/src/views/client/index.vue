<script setup lang="ts">
import { Search, MoreFilled, ArrowRight } from '@element-plus/icons-vue'
import { useApp } from "@/hooks/useApp";
import { useDownLoad } from "@/hooks/useDownload";
import { RightPanel } from "@/components/index";
import { CreateClient } from "./components/index";
import { PopupKey } from "@/symbols/index"
import { ClientKey } from '@/symbols/client';
import { ElMessage } from 'element-plus';

const { setBreadcrumbList } = useApp()
const { downloadFile } = useDownLoad()
const router = useRouter()

const rightPanel = ref<any>()
const loading = ref(true)
const tableHeight = ref(600)

//导入rightPanel数组
const panelComponents = [
    {
        name: 'add',
        component: CreateClient
    }
]

//设置默认rightPanel
const selectPanel = ref(null)

//filter 过滤select数组
const options = [
    {
        value: 0,
        label: 'Client',
        name: 'name'
    },
    {
        value: 1,
        label: 'Email',
        name: 'email'
    },
    {
        value: 2,
        label: 'Mobile',
        name: 'mobile'
    },
    {
        value: 3,
        label: 'Entity',
        name: 'entityName'
    },
    {
        value: 4,
        label: 'State',
        name: 'state'
    }
]
//filter languageOptions
const clientTypeList = ref([])

//过滤当前选中
const filterType = ref(null)

//当前选中语言
const clientType = ref(null)

const withheldTax = ref(null)

//搜索字段
const searchStr = ref('')

//Client list数组
const tableData = ref([
])

//table 数据总数
const listTotal = ref(0)
//每页几条
const pageSize = ref(10)
//第几页
const pageNum = ref(1)

const clientId = ref(null)

const centerDialogVisible = ref(false)

onMounted(() => {
    getClientList()
    queryClientType()
    nextTick(() => {
        const title = document.getElementById('title').clientHeight
        const fund = document.getElementById('client').clientHeight
        const tool = document.getElementById('tool').clientHeight
        const pagination = document.getElementById('pagination').clientHeight
        tableHeight.value = fund - title - tool - pagination
    })
})

async function getClientList() {
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
    if (clientType.value !== null) {
        query = {
            ...query,
            clientType: clientTypeList.value[clientType.value]?.value
        }
    }
    if (withheldTax.value !== null) {
        query = {
            ...query,
            withheldTax: withheldTax.value
        }
    }
    const [e, r] = await api.queryClients(query, params)
    loading.value = false
    if (!e && r) {
        console.log(r.data);
        listTotal.value = r.data?.total || 0
        tableData.value = r.data?.list || []
    } else {
        console.log(e);
    }

}

async function queryClientType() {
    let params = { type: 'client_type' }
    const [e, r] = await api.queryDictionary(params)
    if (!e && r) {
        clientTypeList.value = r?.data || []
    }
}

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    getClientList()
}

//清除条件
const handleClear = () => {
    filterType.value = null
    searchStr.value = ''
    pageNum.value = 1
    getClientList()
}

//条件查询
const handleSearch = () => {
    pageNum.value = 1
    getClientList()
}

//添加Client
const handleAddClient = () => {
    setBreadcrumbList([{
        name: 'Create Client'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'add'
    })
    clientId.value = null
    rightPanel.value.handleIsShow()
}

//查看详情
const handleViewClient = (item: AnyObj) => {
    setBreadcrumbList([{
        name: `${item.name}`
    }])
    // selectPanel.value = panelComponents.findIndex((item) => {
    //     return item.name === 'view'
    // })
    // clientId.value = item.id
    // rightPanel.value.handleIsShow()
    router.push({ path: `/client/detail/${item.id}` }).catch((err) => {
        console.warn(err)
    })
}

//删除Client
const handleShowDelClient = () => {
    centerDialogVisible.value = true
}

//删除管理员
const handleDelClient = async (item: AnyObj) => {
    const params = {
        id: item.id
    }
    const [e, r] = await api.delClient(params)
    if (!e && r) {
        if (r.data) {
            ElMessage.success('delete success')
        }
        centerDialogVisible.value = false
        getClientList()
    }
}

//重置client密码
const handleResetPas = async (item: AnyObj) => {
    const params = {
        id: item.id
    }
    const [e, r] = await api.resetClientPassword(params)
    if (!e && r) {
        if (r.data) {
            ElMessage.success('reset success')
        }
    }
}

const exportClients = async (str: string) => {
    const name = 'client'
    let query = {}
    if (filterType.value || filterType.value === 0) {
        query = {
            [options[filterType.value].name]: searchStr.value
        }
    }
    if (clientType.value !== null) {
        query = {
            ...query,
            clientType: clientTypeList.value[clientType.value]?.value
        }
    }
    if (str === 'csv') {
        api.exportClientsCsv(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'xml') {
        api.exportClientsXml(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'json') {
        api.exportClientsJson(query)
            .then(res => {
                downloadFile(res, str, name)
            })
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
    getClientList()
}

//向下抛出回调方法以及弹窗显隐
provide(PopupKey, { func: closeRightPanel })

provide(ClientKey, { cId: clientId })
</script>
<template>
    <div class="client" id="client" v-loading="loading">
        <div class="title" id="title">Client List</div>
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
                <el-select class="select m-l-20" v-model="clientType" clearable placeholder="Client type"
                    @change="handleChangeLan">
                    <el-option v-for="item in clientTypeList" :key="item.value" :label="item.code"
                        :value="item.value" />
                </el-select>
                <el-select class="select m-l-20" v-model="withheldTax" clearable placeholder="withheldTax"
                    @change="handleChangeLan">
                    <el-option label="Overseas" :value="true" />
                    <el-option label="Onshore" :value="false" />
                </el-select>
            </div>
            <div>
                <el-button v-permission="'Client'" type="primary" color="#4E9F1C" @click="handleAddClient">
                    New Client
                    <el-icon>
                        <ArrowRight />
                    </el-icon>
                </el-button>
            </div>
        </div>
        <div class="table" :style="{ height: `${tableHeight}px` }">
            <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                v-if="tableData.length > 0">
                <el-table-column prop="id" label="Client ID" :align="'center'" fixed="left" width="100">
                </el-table-column>
                <el-table-column prop="name" label="Client" :align="'left'" width="150" fixed="left">
                    <template #default="scope">
                        <div class="table-name pointer" @click="handleViewClient(scope.row)">
                            <span>{{ scope.row.name }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="birth" label="DOB" :align="'left'" width="150" />
                <el-table-column prop="email" label="Email" width="200" />
                <el-table-column prop="mobile" label="Mobile" width="200" :align="'center'">
                </el-table-column>
                <el-table-column prop="clientType" label="Client Type" width="150" :align="'center'" />
                <el-table-column prop="totalAmount" label="Total Investment Amount" width="300" :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.totalAmount" :precision="2" :value-style="{ fontSize: '14px' }"
                            prefix="$"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="prevMonthReturn" label="Pervious Month Investment Return (End of month)"
                    width="300" :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.prevMonthReturn" :precision="2"
                            :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="currentReturn" label="Total current Investment Return" width="300"
                    :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.currentReturn" :precision="2"
                            :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
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
                                <div class="action">
                                    <div class="item" @click="handleViewClient(scope.row)">View</div>
                                    <!-- <div class="item" @click="handleEditClient(scope.row)">Edit</div> -->
                                    <div v-permission="'Client'" class="item" @click="handleResetPas(scope.row)">Reset
                                        password</div>
                                    <div v-permission="'Client'" class="item" @click="handleShowDelClient()">Delete
                                    </div>
                                    <el-dialog v-model="centerDialogVisible" title="Message" width="30%" align-center>
                                        <span>Are you sure to delete this?</span>
                                        <template #footer>
                                            <span class="dialog-footer">
                                                <el-button @click="centerDialogVisible = false">Cancel</el-button>
                                                <el-button type="primary" @click="handleDelClient(scope.row)">
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
                    <div class="download-link" @click="exportClients('csv')">CSV</div>
                    <div class="download-link" @click="exportClients('xml')">XML</div>
                    <div class="download-link" @click="exportClients('json')">JSON</div>
                </template>
            </div>
            <el-pagination background layout="total,consists of sizes, prev, pager, next, jumper, ->, slot"
                :total="listTotal" v-model:page-size="pageSize" v-model:current-page="pageNum"
                @current-change="handleCurrentChange" />
        </div>
    </div>
    <RightPanel ref="rightPanel" @back-Fn="getClientList">
        <template #content>
            <component :is="panelComponents[selectPanel].component" v-if="selectPanel !== null"></component>
        </template>
    </RightPanel>
</template>

<style lang="scss" scoped>
.client {
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