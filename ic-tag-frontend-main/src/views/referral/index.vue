<script setup lang="ts">
import { Search, MoreFilled, ArrowRight } from '@element-plus/icons-vue'
import { useApp } from "@/hooks/useApp";
import { RightPanel } from "@/components/index";
import { CreateOrEditReferral } from "./components/index";
import { PopupKey } from "@/symbols/index"
import { ReferralKey } from '@/symbols/referral';
import { ElMessage } from 'element-plus';
import { useDownLoad } from "@/hooks/useDownload";

const { setBreadcrumbList } = useApp()
const { downloadFile } = useDownLoad()
const rightPanel = ref<any>()
const loading = ref(true)
const tableHeight = ref(600)

//导入rightPanel数组
const panelComponents = [
    {
        name: 'add',
        component: CreateOrEditReferral
    },
    {
        name: 'edit',
        component: CreateOrEditReferral
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
    },
    {
        value: 1,
        label: 'Entity',
        name: 'entityId'
    },
    {
        value: 2,
        label: 'Fund',
        name: 'fundId'
    }
]

//过滤当前选中
const filterType = ref(null)

//搜索字段
const searchStr = ref('')

//Referral list数组
const tableData = ref([
])

//table 数据总数
const listTotal = ref(0)
//每页几条
const pageSize = ref(10)
//第几页
const pageNum = ref(1)

const referralId = ref(null)

const centerDialogVisible = ref(false)

onMounted(() => {
    getReferralList()
    nextTick(() => {
        const title = document.getElementById('title').clientHeight
        const fund = document.getElementById('referral').clientHeight
        const tool = document.getElementById('tool').clientHeight
        const pagination = document.getElementById('pagination').clientHeight
        tableHeight.value = fund - title - tool - pagination
    })
})

async function getReferralList() {
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
    const [e, r] = await api.queryReferral(query, params)
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
    getReferralList()
}

//清除条件
const handleClear = () => {
    filterType.value = null
    searchStr.value = ''
    pageNum.value = 1
    getReferralList()
}

//条件查询
const handleSearch = () => {
    pageNum.value = 1
    getReferralList()
}

//添加Referral
const handleAddReferral = () => {
    setBreadcrumbList([{
        name: 'Create Referral'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'add'
    })
    referralId.value = null
    rightPanel.value.handleIsShow()
}

//编辑Referral
const handleEditReferral = (item: AnyObj) => {
    setBreadcrumbList([{
        name: 'Edit Referral'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'edit'
    })
    referralId.value = item.id
    rightPanel.value.handleIsShow()
}

//删除Referral
const handleShowDelReferral = () => {
    centerDialogVisible.value = true
}

//删除Referral
const handleDelReferral = async (item: AnyObj) => {
    const params = {
        id: item.id
    }
    const [e, r] = await api.delReferral(params)
    if (!e && r) {
        if (r.data) {
            ElMessage.success('delete success')
        }
        centerDialogVisible.value = false
        getReferralList()
    }
}

//关闭RightPanel
const closeRightPanel = () => {
    if (rightPanel.value) {
        rightPanel.value.handleIsShow()
    }
}

const exportReferral = async (str: string) => {
    const name = 'referral'
    let query = {}
    if (filterType.value || filterType.value === 0) {
        query = {
            [options[filterType.value].name]: searchStr.value
        }
    }
    if (str === 'csv') {
        api.exportFinancingsCsv(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'xml') {
        api.exportFinancingsXml(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'json') {
        api.exportFinancingsJson(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    }
}

//向下抛出回调方法以及弹窗显隐
provide(PopupKey, { func: closeRightPanel })
provide(ReferralKey, { rId: referralId })

</script>
<template>
    <div class="referral" id="referral" v-loading="loading">
        <div class="title" id="title">Referral List</div>
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
                <el-button v-permission="'Referral'" type="primary" color="#4E9F1C" @click="handleAddReferral">
                    New Referral
                    <el-icon>
                        <ArrowRight />
                    </el-icon>
                </el-button>
            </div>
        </div>
        <div class="table" :style="{ height: `${tableHeight}px` }">
            <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                v-if="tableData.length > 0">
                <el-table-column prop="id" label="Referral ID" :align="'center'" width="100" fixed="left">
                </el-table-column>
                <el-table-column prop="name" label="Entity" :align="'left'" width="150" fixed="left">
                    <template #default="scope">
                        <div class="table-name">
                            <span>{{ scope.row.entityName }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="clientName" label="Client" :align="'left'" width="150" />
                <el-table-column prop="fundName" label="Fund" width="200" />
                <el-table-column prop="commissionRate" label="Commission Rate" width="150" :align="'center'">
                </el-table-column>
                <el-table-column prop="commissionAmount" label="Commission Amount" width="200" :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.commissionAmount" :precision="2"
                            :value-style="{ fontSize: '14px' }" prefix="$"
                            v-if="scope.row.commissionAmount"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="financingAmount" label="Total Financing Amount" width="200" :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.financingAmount" :precision="2"
                            :value-style="{ fontSize: '14px' }" prefix="$"
                            v-if="scope.row.financingAmount"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="currency" label="Currency" width="150" :align="'center'">
                </el-table-column>
                <el-table-column prop="createAt" label="Create at" width="200" />
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
                                    <div class="item" @click="handleEditReferral(scope.row)">Edit</div>
                                    <div v-permission="'Referral'" class="item" @click="handleShowDelReferral()">Delete
                                    </div>
                                    <el-dialog v-model="centerDialogVisible" title="Message" width="30%" align-center>
                                        <span>Are you sure to delete this?</span>
                                        <template #footer>
                                            <span class="dialog-footer">
                                                <el-button @click="centerDialogVisible = false">Cancel</el-button>
                                                <el-button type="primary" @click="handleDelReferral(scope.row)">
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
                    <div class="download-link" @click="exportReferral('csv')">CSV</div>
                    <div class="download-link" @click="exportReferral('xml')">XML</div>
                    <div class="download-link" @click="exportReferral('json')">JSON</div>
                </template>
            </div>
            <el-pagination background layout="total,consists of sizes, prev, pager, next, jumper, ->, slot"
                :total="listTotal" v-model:page-size="pageSize" v-model:current-page="pageNum"
                @current-change="handleCurrentChange" />
        </div>
    </div>
    <RightPanel ref="rightPanel" @back-Fn="getReferralList">
        <template #content>
            <component :is="panelComponents[selectPanel].component" v-if="selectPanel !== null"></component>
        </template>
    </RightPanel>
</template>

<style lang="scss" scoped>
.referral {
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

            .select-250 {
                width: 250px;
            }

            .select-280 {
                width: 280px;
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