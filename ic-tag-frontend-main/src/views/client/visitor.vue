<script setup lang="ts">
import { Search } from '@element-plus/icons-vue'
// import { ElMessage } from 'element-plus';
import dayjs from 'dayjs';

const loading = ref(true)
const tableHeight = ref(600)

//设置默认rightPanel
const selectPanel = ref(null)

//filter 过滤select数组
const options = [
    {
        value: 0,
        label: 'Email',
        name: 'email'
    },
    // {
    //     value: 1,
    //     label: 'Status',
    //     name: 'status'
    // },
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

onMounted(() => {
    // getAuditList()
    queryOperateLogPage()
    nextTick(() => {
        const title = document.getElementById('title').clientHeight
        const fund = document.getElementById('audit').clientHeight
        const tool = document.getElementById('tool').clientHeight
        const pagination = document.getElementById('pagination').clientHeight
        tableHeight.value = fund - title - tool - pagination
    })
})

async function queryOperateLogPage() {
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
    const [e, r] = await api.queryVisitorLogPage(query, params)
    loading.value = false
    if (!e && r) {
        console.log("🚀 ~ queryOperateLogPage ~ r:", r.data?.list)
        listTotal.value = r.data?.total || 0
        tableData.value = r.data?.list || []
    } else {
        console.log(e);
    }
}

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    queryOperateLogPage()
}

//清除条件
const handleClear = () => {
    filterType.value = null
    searchStr.value = ''
    pageNum.value = 1
    queryOperateLogPage()
}

//条件查询
const handleSearch = () => {
    pageNum.value = 1
    queryOperateLogPage()
}
</script>
<template>
    <div class="audit" id="audit" v-loading="loading">
        <div class="title" id="title">Visitor List</div>
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
            </div>
            <div>
            </div>
        </div>
        <div class="table" :style="{ height: `${tableHeight}px` }">
            <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                v-if="tableData.length > 0">
                <el-table-column prop="email" label="Email" :align="'center'">
                </el-table-column>
                <el-table-column prop="loginTime" label="Login Time" :align="'center'">
                    <template #default="scope">
                        <span>{{ dayjs(scope.row.loginTime).format('YYYY-MM-DD HH:mm:ss') }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="status" label="status" :align="'center'" />
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
</style>