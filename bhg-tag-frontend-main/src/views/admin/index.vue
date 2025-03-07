<script setup lang="ts">
import { ArrowRight, Search, MoreFilled } from '@element-plus/icons-vue'
import { RightPanel } from "@/components/index";
import { ViewAdmin, CreateOrEditAdmin } from "./components";
import { useApp } from "@/hooks/useApp";
import { PopupKey } from "@/symbols/index"
import { AdminKey } from "@/symbols/admin"
import { ElMessage } from 'element-plus';

const { setBreadcrumbList } = useApp()
const rightPanel = ref<any>()
const tableHeight = ref(600)

//导入rightPanel数组
const panelComponents = [
    {
        name: 'add',
        component: CreateOrEditAdmin
    },
    {
        name: 'view',
        component: ViewAdmin
    },
    {
        name: 'edit',
        component: CreateOrEditAdmin
    }
]

//设置默认rightPanel
const selectPanel = ref(null)

//filter 过滤select数组
const options = [
    {
        value: 0,
        label: 'Contains',
    },
    {
        value: 1,
        label: 'Equals',
    },
    {
        value: 2,
        label: 'Starts with',
    },
    {
        value: 3,
        label: 'Ends with',
    }
]

//admin list数组
const tableData = ref([
])

//table 数据总数
const listTotal = ref(0)
//每页几条
const pageSize = ref(10)
//第几页
const pageNum = ref(1)

//过滤当前选中
const filterType = ref(null)
//搜索字段
const searchStr = ref('')

const centerDialogVisible = ref(false)

const adminId = ref(null)

onMounted(() => {
    getAdminList()
    nextTick(() => {
        const title = document.getElementById('title').clientHeight
        const fund = document.getElementById('admin').clientHeight
        const tool = document.getElementById('tool').clientHeight
        const pagination = document.getElementById('pagination').clientHeight
        tableHeight.value = fund - title - tool - pagination
    })
})

/**
 * @description: 获取管理员列表
 * @return {*}
 */
async function getAdminList() {
    selectPanel.value = null
    let params = {
        pageSize: pageSize.value,
        pageNum: pageNum.value
    }
    let query = {
        filterType: filterType.value,
        adminUserEmail: searchStr.value
    }
    const [e, r] = await api.queryAdminUsers(query, params)
    if (!e && r) {
        console.log(r.data);
        listTotal.value = r.data?.total || 0
        tableData.value = r.data?.list || []
    } else {
        console.log(e);
    }
}

//添加管理员
const handleAddAdmin = () => {
    setBreadcrumbList([{
        name: 'Create Admin User'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'add'
    })
    adminId.value = null
    rightPanel.value.handleIsShow()
}

//编辑管理员
const handleEditAdmin = (item: AnyObj) => {
    setBreadcrumbList([{
        name: 'Edit Admin User'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'edit'
    })
    adminId.value = item.id
    rightPanel.value.handleIsShow()
}

//查看管理员
const handleViewAdmin = (item: AnyObj) => {
    setBreadcrumbList([{
        name: 'View Admin User'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'view'
    })
    adminId.value = item.id
    rightPanel.value.handleIsShow()
}

//删除管理员
const handleShowDelAdmin = () => {
    centerDialogVisible.value = true
}

//删除管理员
const handleDelAdmin = async (item: AnyObj) => {
    const params = {
        id: item.id
    }
    const [e, r] = await api.delAdmin(params)
    if (!e && r) {
        if (r.data) {
            ElMessage.success('delete success')
        }
        centerDialogVisible.value = false
        getAdminList()
    }
}

//查询管理员
const handleSearch = () => {
    console.log(filterType.value);
    pageNum.value = 1
    getAdminList()
}

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    getAdminList()
}

//清楚查询管理员
const handleClear = () => {
    filterType.value = null
    searchStr.value = ''
    pageNum.value = 1
    getAdminList()
}

//关闭RightPanel
const closeRightPanel = () => {
    if (rightPanel.value) {
        rightPanel.value.handleIsShow()
    }
}

//向下抛出回调方法以及弹窗显隐
provide(PopupKey, { func: closeRightPanel })
provide(AdminKey, { aId: adminId })
</script>
<template>
    <div class="admin" id="admin">
        <div class="title" id="title">Admin List</div>
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
                <el-button v-permission="'Admin'" type="primary" color="#4E9F1C" @click="handleAddAdmin">
                    New Admin User
                    <el-icon>
                        <ArrowRight />
                    </el-icon>
                </el-button>
            </div>
        </div>
        <div class="table" :style="{ height: `${tableHeight}px` }">
            <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                v-if="tableData.length > 0">
                <el-table-column prop="id" label="Admin ID" :align="'center'">
                    <template #default="scope">
                        <div class="table-name">
                            <span>{{ scope.row.id }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="email" label="Email" :align="'left'" />
                <el-table-column prop="createAt" label="Create at" :align="'left'" />
                <el-table-column prop="role" label="Role" />
                <el-table-column prop="" label="Action" :align="'center'">
                    <template #default="scope">
                        <div class="pointer">
                            <el-popover placement="bottom" :width="170" trigger="hover">
                                <template #reference>
                                    <el-icon :size="30" color="#969696">
                                        <MoreFilled />
                                    </el-icon>
                                </template>
                                <div v-permission="'Admin'" class="action">
                                    <div class="item" @click="handleViewAdmin(scope.row)">View</div>
                                    <div class="item" @click="handleEditAdmin(scope.row)">Edit</div>
                                    <div class="item" @click="handleShowDelAdmin()">Delete</div>
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
    <RightPanel ref="rightPanel" @back-Fn="getAdminList">
        <template #content>
            <component :is="panelComponents[selectPanel].component" v-if="selectPanel !== null"></component>
        </template>
    </RightPanel>
</template>
<style lang="scss" scoped>
.admin {
    height: 100%;
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
    }

    .table {
        display: flex;
        justify-content: center;
        align-items: center;
    }
}

.action {
    display: flex;
    flex-direction: column;
    justify-content: center;

    .item {
        color: #000;
        font-size: 16px;
        font-style: normal;
        font-weight: 400;
        cursor: pointer;
    }

    .item:hover {
        color: $web-color;
    }

    .item+.item {
        padding-top: 12px;
    }
}
</style>