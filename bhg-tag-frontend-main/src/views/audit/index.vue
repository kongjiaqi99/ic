<script setup lang="ts">
import { Search, MoreFilled } from '@element-plus/icons-vue'
import { useApp } from "@/hooks/useApp";
import { RightPanel } from "@/components/index";
import { ViewAudit } from "./components/index";
import { PopupKey } from "@/symbols/index"
import { AuditKey } from '@/symbols/audit';
// import { ElMessage } from 'element-plus';
import dayjs from 'dayjs';

const { setBreadcrumbList } = useApp()
const rightPanel = ref<any>()
const loading = ref(true)
const router: any = useRouter()
const tableHeight = ref(600)

//导入rightPanel数组
const panelComponents = [
    {
        name: 'view',
        component: ViewAudit
    }
]

//设置默认rightPanel
const selectPanel = ref(null)

//filter 过滤select数组
const options = [
    {
        value: 0,
        label: 'Email',
        name: 'email'
    }
]
//filter typeOptions
const typeOptions = ref([
    { code: "Client Update" },
    { code: "Re-Investment Request" },
    { code: "Entity Update" }
])
const statusOptions = ref([
    { code: "Approved" },
    { code: "Rejected" },
    { code: "Pending approval" }
])

//过滤当前选中
const filterType = ref(null)

//当前选中type
const typeSelect = ref(null)
const statusSelect = ref(null)

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

const auditId = ref(null)

const aId = ref(router.currentRoute.value.query?.aId || '')

watch(
    () => router?.currentRoute.value.query?.aId,
    (val) => {
        if (val) {
            console.log('watch', val, selectPanel.value)
            // rightPanel.value.handleIsShow()
            if (selectPanel.value !== null) {
                rightPanel.value.handleIsShow()
            }
            getDetail(val)
        }
    },
)

onMounted(() => {
    getAuditList()
    nextTick(() => {
        const title = document.getElementById('title').clientHeight
        const fund = document.getElementById('audit').clientHeight
        const tool = document.getElementById('tool').clientHeight
        const pagination = document.getElementById('pagination').clientHeight
        tableHeight.value = fund - title - tool - pagination
    })
})

async function getAuditList() {
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
    if (statusSelect.value !== null) {
        query = {
            ...query,
            status: statusSelect.value
        }
    }
    if (typeSelect.value !== null) {
        query = {
            ...query,
            auditType: typeSelect.value
        }
    }
    loading.value = false
    const [e, r] = await api.queryAudit(query, params)
    loading.value = false
    if (!e && r) {
        console.log(r.data?.list);
        listTotal.value = r.data?.total || 0
        tableData.value = r.data?.list || []
        if (aId.value) {
            getDetail(aId.value)
            aId.value = ''
        }
    } else {
        console.log(e);
    }
}

async function getDetail(id: string) {
    let params = {
        id: id
    }
    const [e, r] = await api.queryAuditById(params)
    if (!e && r) {
        console.log(r.data);
        // rightPanel.value.handleIsShow()
        handleViewAudit(r.data)
    }
}

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    getAuditList()
}

//清除条件
const handleClear = () => {
    filterType.value = null
    searchStr.value = ''
    pageNum.value = 1
    getAuditList()
}

//条件查询
const handleSearch = () => {
    pageNum.value = 1
    getAuditList()
}

//查看详情
const handleViewAudit = async (item: AnyObj) => {
    setBreadcrumbList([{
        name: `${item.auditType} Request`
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'view'
    })
    auditId.value = item.id
    rightPanel.value.handleIsShow()
}

//关闭RightPanel
const closeRightPanel = () => {
    if (rightPanel.value) {
        rightPanel.value.handleIsShow()
    }
}

//切换语言查询
const handleChange = () => {
    getAuditList()
}

//向下抛出回调方法以及弹窗显隐
provide(PopupKey, { func: closeRightPanel })

provide(AuditKey, { aId: auditId })
</script>
<template>
    <div class="audit" id="audit" v-loading="loading">
        <div class="title" id="title">Audit List</div>
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
                <el-select class="select m-l-20" v-model="typeSelect" clearable placeholder="Type"
                    @change="handleChange">
                    <el-option v-for="item in typeOptions" :key="item.code" :label="item.code" :value="item.code" />
                </el-select>
                <el-select class="select m-l-20" v-model="statusSelect" clearable placeholder="Status"
                    @change="handleChange">
                    <el-option v-for="item in statusOptions" :key="item.code" :label="item.code" :value="item.code" />
                </el-select>
            </div>
            <div>
            </div>
        </div>
        <div class="table" :style="{ height: `${tableHeight}px` }">
            <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                v-if="tableData.length > 0">
                <el-table-column prop="id" label="Request ID" :align="'center'">
                </el-table-column>
                <el-table-column prop="auditType" label="Type" :align="'left'" />
                <el-table-column prop="creatorName" label="Email" :align="'left'" />
                <el-table-column prop="status" label="Status" />
                <el-table-column prop="updatedAt" label="Request Time">
                    <template #default="scope">
                        <span>{{ dayjs(scope.row.updatedAt).format('YYYY-MM-DD HH:mm:ss') }}</span>
                    </template>
                </el-table-column>
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
                                    <div class="item" @click="handleViewAudit(scope.row)">View</div>
                                </div>
                            </el-popover>
                        </div>
                    </template>
                </el-table-column>
            </el-table>
            <el-empty :image-size="200" v-else />
        </div>
        <div class="pagination" id="pagination">
            <div></div>
            <el-pagination background layout="total,consists of sizes, prev, pager, next, jumper, ->, slot"
                :total="listTotal" v-model:page-size="pageSize" v-model:current-page="pageNum"
                @current-change="handleCurrentChange" />
        </div>
    </div>
    <RightPanel ref="rightPanel" @back-Fn="getAuditList">
        <template #content>
            <component :is="panelComponents[selectPanel].component" v-if="selectPanel !== null"></component>
        </template>
    </RightPanel>
</template>

<style lang="scss" scoped>
.audit {
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

    .status-tab {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 0 0 16px;

        .item {
            cursor: pointer;
            width: 50%;
            height: 60px;
            background: #fff;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #000;
            font-size: 16px;
            font-style: normal;
            font-weight: 600;
            box-shadow: 0px 1px 1px 0px rgba(0, 0, 0, 0.08), 0px 2px 1px 0px rgba(0, 0, 0, 0.06), 0px 1px 3px 0px rgba(0, 0, 0, 0.10);
        }

        .item.act {
            background: $web-color;
            color: #fff;
        }
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
</style>