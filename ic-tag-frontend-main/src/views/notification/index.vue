<script setup lang="ts">
import { Search, MoreFilled, ArrowRight } from '@element-plus/icons-vue'
import { useApp } from "@/hooks/useApp";
import { RightPanel } from "@/components/index";
import { ViewNotification, CreateOrEditNotification } from "./components/index";
import { PopupKey } from "@/symbols/index"
import { NotificationKey } from '@/symbols/notification';
import { ElMessage } from 'element-plus';
import dayjs from "dayjs";

const { setBreadcrumbList } = useApp()
const rightPanel = ref<any>()
const loading = ref(true)
const tableHeight = ref(600)

//导入rightPanel数组
const panelComponents = [
    {
        name: 'view',
        component: ViewNotification
    },
    {
        name: 'add',
        component: CreateOrEditNotification
    },
    {
        name: 'edit',
        component: CreateOrEditNotification
    }
]

//设置默认rightPanel
const selectPanel = ref(null)

//filter 过滤select数组
const options = [
    {
        value: 0,
        label: 'Client',
        name: 'clientId'
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

const notificationId = ref(null)

const centerDialogVisible = ref(false)

onMounted(() => {
    getNotificationList()
    nextTick(() => {
        const title = document.getElementById('title').clientHeight
        const fund = document.getElementById('notification').clientHeight
        const tool = document.getElementById('tool').clientHeight
        const pagination = document.getElementById('pagination').clientHeight
        tableHeight.value = fund - title - tool - pagination
    })
})

async function getNotificationList() {
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
    const [e, r] = await api.queryNotificationPage(query, params)
    loading.value = false
    if (!e && r) {
        console.log(r.data?.list);
        listTotal.value = r.data?.total || 0
        tableData.value = r.data?.list || []
    } else {
        console.log(e);
    }

}

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    getNotificationList()
}

//清除条件
const handleClear = () => {
    filterType.value = null
    searchStr.value = ''
    pageNum.value = 1
    getNotificationList()
}

//条件查询
const handleSearch = () => {
    pageNum.value = 1
    getNotificationList()
}

//添加Notification
const handleAddNotification = () => {
    setBreadcrumbList([{
        name: 'Create Notification'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'add'
    })
    notificationId.value = null
    rightPanel.value.handleIsShow()
}

//查看详情
const handleViewNotification = (item: AnyObj) => {
    setBreadcrumbList([{
        name: 'View Notification'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'view'
    })
    notificationId.value = item.id
    rightPanel.value.handleIsShow()
}

//删除Notification
const handleShowDelNotification = () => {
    centerDialogVisible.value = true
}

//删除管理员
const handleDelAdmin = async (item: AnyObj) => {
    const params = {
        id: item.id
    }
    const [e, r] = await api.delNotification(params)
    if (!e && r) {
        if (r.data) {
            ElMessage.success('delete success')
        }
        centerDialogVisible.value = false
        getNotificationList()
    }
}

//关闭RightPanel
const closeRightPanel = () => {
    if (rightPanel.value) {
        rightPanel.value.handleIsShow()
    }
}

//向下抛出回调方法以及弹窗显隐
provide(PopupKey, { func: closeRightPanel })

provide(NotificationKey, { nId: notificationId })
</script>
<template>
    <div class="notification" id="notification" v-loading="loading">
        <div class="title" id="title">Notification List</div>
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
            <div>
                <el-button v-permission="'Notification'" type="primary" color="#4E9F1C" @click="handleAddNotification">
                    New Notification
                    <el-icon>
                        <ArrowRight />
                    </el-icon>
                </el-button>
            </div>
        </div>
        <div class="table" :style="{ height: `${tableHeight}px` }">
            <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                v-if="tableData.length > 0">
                <el-table-column prop="id" label="Notification ID" :align="'center'" width="130">
                    <template #default="scope">
                        <div class="table-name">
                            <span>{{ scope.row.id }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="title" label="Title" :align="'center'" width="200" />
                <el-table-column prop="message" label="Message" :align="'center'" width="300">
                    <template #default="scope">
                        <div class="table-cut">{{ scope.row.message }}</div>
                    </template>
                </el-table-column>
                <el-table-column prop="createdAt" label="Create at" width="200">
                    <template #default="scope">
                        <span>{{ dayjs(scope.row.createdAt).format('DD.MM.YYYY') }}</span>
                    </template>
                </el-table-column>
                <el-table-column prop="clientNameArr" label="Client" width="200">
                    <template #default="scope">
                        <div v-if="scope.row.isAll">All</div>
                        <div v-else>{{ scope.row.clientNameArr.join(',') }}</div>
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
                                <div v-permission="'Notification'" class="action">
                                    <div class="item" @click="handleViewNotification(scope.row)">View</div>
                                    <div class="item" @click="handleShowDelNotification()">Delete</div>
                                    <el-dialog v-model="centerDialogVisible" title="Message" width="30%" align-center>
                                        <span>Are you sure to delete this?</span>
                                        <template #footer>
                                            <span class="dialog-footer">
                                                <el-button @click="centerDialogVisible = false">Cancel</el-button>
                                                <el-button type="primary" @click="handleDelAdmin(scope.row)">
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
            <div></div>
            <el-pagination background layout="total,consists of sizes, prev, pager, next, jumper, ->, slot"
                :total="listTotal" v-model:page-size="pageSize" v-model:current-page="pageNum"
                @current-change="handleCurrentChange" />
        </div>
    </div>
    <RightPanel ref="rightPanel" @back-Fn="getNotificationList">
        <template #content>
            <component :is="panelComponents[selectPanel].component" v-if="selectPanel !== null"></component>
        </template>
    </RightPanel>
</template>

<style lang="scss" scoped>
.notification {
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
</style>