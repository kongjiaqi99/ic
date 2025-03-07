<script setup lang="ts">
import { Search, MoreFilled } from '@element-plus/icons-vue'
import { useApp } from "@/hooks/useApp";
import { RightPanel } from "@/components/index";
import ViewEnquiry from "./components/ViewEnquiry.vue";
import { EnquiryKey } from '../../symbols/enquiry';
import { useDownLoad } from "@/hooks/useDownload";

const { setBreadcrumbList } = useApp()
const { downloadFile } = useDownLoad()

const rightPanel = ref<any>()
const tableHeight = ref(600)

//导入rightPanel数组
const panelComponents = [
    {
        name: 'view',
        component: ViewEnquiry
    }
]

//设置默认rightPanel
const selectPanel = ref(null)
const enquiryStatus = ref([])

//filter 过滤select数组
const options = [
    {
        value: 0,
        label: 'Email',
        name: 'email'
    },
    {
        value: 1,
        label: 'Message',
        name: 'message'
    },
    {
        value: 2,
        label: 'Name',
        name: 'name'
    }
]

//过滤当前选中
const filterType = ref(null)

//搜索字段
const searchStr = ref('')

//admin list数组
const tableData = ref([
])

//table 数据总数
const listTotal = ref(0)
//每页几条
const pageSize = ref(10)
//第几页
const pageNum = ref(1)

const enquiryId = ref(null)

onMounted(() => {
    getEnquiryStatus()
    getEnquiryList()
    nextTick(() => {
        const title = document.getElementById('title').clientHeight
        const fund = document.getElementById('enquire').clientHeight
        const sub = document.getElementById('sub').clientHeight
        const tool = document.getElementById('tool').clientHeight
        const pagination = document.getElementById('pagination').clientHeight
        tableHeight.value = fund - title - tool - pagination - sub
    })
})

async function getEnquiryList() {
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
    const [e, r] = await api.queryEnquiries(query, params)
    if (!e && r) {
        console.log(r.data.list);
        listTotal.value = r.data?.total || 0
        tableData.value = r.data?.list || []
    } else {
        console.log(e);
    }

}

async function getEnquiryStatus() {
    let query = {
        type: 'enquiry_type'
    }
    const [e, r] = await api.queryDictionary(query)
    if (!e && r) {
        enquiryStatus.value = r?.data || []
    } else {
        console.log(e);
    }
}

const typeComputed = computed(() => (str) => {
    if (!str) return
    let item = enquiryStatus.value.find(i => {
        return i.value === String(str)
    })
    return item?.code
})

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    getEnquiryList()
}

//清除条件
const handleClear = () => {
    filterType.value = null
    searchStr.value = ''
    pageNum.value = 1
    getEnquiryList()
}

//条件查询
const handleSearch = () => {
    pageNum.value = 1
    getEnquiryList()
}

//查看详情
const handleViewAdmin = (item: AnyObj) => {
    setBreadcrumbList([{
        name: 'Client Update Request'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'view'
    })
    enquiryId.value = item.id
    rightPanel.value.handleIsShow()
}

const exportEnquire = async (str: string) => {
    const name = 'enquiry'
    let query = {}
    if (filterType.value || filterType.value === 0) {
        query = {
            [options[filterType.value].name]: searchStr.value
        }
    }
    if (str === 'csv') {
        api.exportEnquiriesCsv(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'xml') {
        api.exportEnquiriesXml(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'json') {
        api.exportEnquiriesJson(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    }
}

provide(EnquiryKey, { eId: enquiryId })
</script>
<template>
    <div class="enquire" id="enquire">
        <div class="title" id="title">Enquiry List</div>
        <div class="sub-title" id="sub">You have requests awaiting your approval</div>
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
            <div></div>
        </div>
        <div class="table" :style="{ height: `${tableHeight}px` }">
            <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                v-if="tableData.length > 0">
                <el-table-column prop="id" label="Enquiry ID" :align="'center'">
                    <template #default="scope">
                        <div class="table-name">
                            <span>{{ scope.row.id }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="email" label="Email" :align="'left'" />
                <el-table-column prop="name" label="Name" :align="'left'" />
                <el-table-column prop="message" label="Type">
                    <template #default="scope">
                        <span>{{ typeComputed(scope.row.type) }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="createAt" label="Create at" />
                <el-table-column prop="" label="Action" :align="'center'">
                    <template #default="scope">
                        <div class="pointer">
                            <el-popover placement="bottom" :width="170" trigger="hover">
                                <template #reference>
                                    <el-icon :size="30" color="#969696">
                                        <MoreFilled />
                                    </el-icon>
                                </template>
                                <div class="action">
                                    <div class="item" @click="handleViewAdmin(scope.row)">View</div>
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
                    <div class="download-link" @click="exportEnquire('csv')">CSV</div>
                    <div class="download-link" @click="exportEnquire('xml')">XML</div>
                    <div class="download-link" @click="exportEnquire('json')">JSON</div>
                </template>
            </div>
            <el-pagination background layout="total,consists of sizes, prev, pager, next, jumper, ->, slot"
                :total="listTotal" v-model:page-size="pageSize" v-model:current-page="pageNum"
                @current-change="handleCurrentChange" />
        </div>
    </div>
    <RightPanel ref="rightPanel" @back-Fn="getEnquiryList">
        <template #content>
            <component :is="panelComponents[selectPanel].component" v-if="selectPanel !== null"></component>
        </template>
    </RightPanel>
</template>
<style lang="scss" scoped>
.enquire {
    height: 100%;
    border-radius: 12px;
    background: #FFF;
    box-shadow: 0px 1px 1px 0px rgba(0, 0, 0, 0.08), 0px 2px 1px 0px rgba(0, 0, 0, 0.06), 0px 1px 3px 0px rgba(0, 0, 0, 0.10);

    .title {
        color: #1C1C1C;
        font-size: 24px;
        font-style: normal;
        font-weight: 700;
        padding: 48px 56px 8px;
    }

    .sub-title {
        color: #9FA1A6;
        font-size: 16px;
        font-style: normal;
        font-weight: 400;
        padding: 0 56px 16px;
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
    }

    .table {
        display: flex;
        justify-content: center;
        align-items: center;
    }
}
</style>