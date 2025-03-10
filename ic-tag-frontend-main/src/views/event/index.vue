<script setup lang="ts">
import { Search, MoreFilled, ArrowRight, Document } from '@element-plus/icons-vue'
import { useApp } from "@/hooks/useApp";
import { RightPanel } from "@/components/index";
import { ViewEvent, CreateOrEditEvent } from "./components/index";
import { PopupKey } from "@/symbols/index"
import { EventKey } from '@/symbols/event';
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
        name: 'view',
        component: ViewEvent
    },
    {
        name: 'add',
        component: CreateOrEditEvent
    },
    {
        name: 'edit',
        component: CreateOrEditEvent
    }
]

//设置默认rightPanel
const selectPanel = ref(null)

//filter 过滤select数组
const options = [
    {
        value: 0,
        label: 'Title',
        name: 'title'
    },
    {
        value: 1,
        label: 'Location',
        name: 'location'
    }
]
//filter languageOptions
const languageOptions = ref([])

//过滤当前选中
const filterType = ref(null)

//当前选中语言
const language = ref(null)

const statusChange = [
    {
        value: 'Online',
        label: 'Online Event',
    },
    {
        value: 'Offline',
        label: 'Offline Event',
    },
    // {
    //     value: 'Sponsor',
    //     label: 'Sponsor event',
    // }
]

const selectStatus = ref('Online')

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

const eventId = ref(null)

const centerDialogVisible = ref(false)

onMounted(() => {
    getEventList()
    getEventLanguage()

    nextTick(() => {
        const title = document.getElementById('title').clientHeight
        const sub = document.getElementById('sub').clientHeight
        const event = document.getElementById('event').clientHeight
        const tool = document.getElementById('tool').clientHeight
        const pagination = document.getElementById('pagination').clientHeight
        tableHeight.value = event - title - tool - pagination - sub
    })
})

async function getEventList() {
    selectPanel.value = null
    loading.value = true
    let params = {
        pageSize: pageSize.value,
        pageNum: pageNum.value
    }
    let query: AnyObj = {
        type: selectStatus.value
    }
    if (filterType.value || filterType.value === 0) {
        query = {
            ...query,
            [options[filterType.value].name]: searchStr.value
        }
    }
    if (language.value !== null) {
        query = {
            ...query,
            language: languageOptions.value[language.value]?.value
        }
    }
    const [e, r] = await api.queryEvents(query, params)
    loading.value = false
    if (!e && r) {
        console.log(r.data?.list);
        listTotal.value = r.data?.total || 0
        tableData.value = r.data?.list || []
    } else {
        console.log(e);
    }

}

async function getEventLanguage() {
    let query = {
        type: 'language'
    }
    const [e, r] = await api.queryDictionary(query)
    if (!e && r) {
        languageOptions.value = r?.data || []
    } else {
        console.log(e);
    }

}

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    getEventList()
}

//清除条件
const handleClear = () => {
    filterType.value = null
    searchStr.value = ''
    pageNum.value = 1
    getEventList()
}

//条件查询
const handleSearch = () => {
    pageNum.value = 1
    getEventList()
}

//添加event
const handleAddEvent = () => {
    setBreadcrumbList([{
        name: 'Create Event'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'add'
    })
    eventId.value = null
    rightPanel.value.handleIsShow()
}

//查看详情
const handleViewEvent = (item: AnyObj) => {
    setBreadcrumbList([{
        name: 'View Event'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'view'
    })
    eventId.value = item.id
    rightPanel.value.handleIsShow()
}

const handleChangeStatus = (item: AnyObj) => {
    selectStatus.value = item.value
    pageNum.value = 1
    getEventList()
}

//编辑Event
const handleEditEvent = (item: AnyObj) => {
    setBreadcrumbList([{
        name: 'Edit Event'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'edit'
    })
    eventId.value = item.id
    rightPanel.value.handleIsShow()
}

//删除event
const handleShowDelEvent = () => {
    centerDialogVisible.value = true
}

//删除管理员
const handleDelAdmin = async (item: AnyObj) => {
    const params = {
        id: item.id
    }
    const [e, r] = await api.delEvent(params)
    if (!e && r) {
        if (r.data) {
            ElMessage.success('delete success')
        }
        centerDialogVisible.value = false
        getEventList()
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
    getEventList()
}

const exportEvent = async (str: string) => {
    const name = 'event'
    let query: AnyObj = {
        type: selectStatus.value
    }
    if (filterType.value || filterType.value === 0) {
        query = {
            ...query,
            [options[filterType.value].name]: searchStr.value
        }
    }
    if (language.value !== null) {
        query = {
            ...query,
            language: languageOptions.value[language.value]?.value
        }
    }
    if (str === 'csv') {
        api.exportEventsCsv(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'xml') {
        api.exportEventsXml(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    } else if (str === 'json') {
        api.exportEventsJson(query)
            .then(res => {
                downloadFile(res, str, name)
            })
    }
}

//向下抛出回调方法以及弹窗显隐
provide(PopupKey, { func: closeRightPanel })
provide(EventKey, { eId: eventId })
</script>
<template>
    <div class="event" id="event" v-loading="loading">
        <div class="title" id="title">Event List</div>
        <div class="status-tab" id="sub">
            <div :class="item.value === selectStatus ? 'item act' : 'item'" v-for="(item, index) in statusChange"
                :key="index" @click="handleChangeStatus(item)">
                {{ item.label }}
            </div>
        </div>
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
                <el-select class="select m-l-20" v-model="language" clearable placeholder="Language"
                    @change="handleChangeLan">
                    <el-option v-for="item in languageOptions" :key="item.value" :label="item.code"
                        :value="item.value" />
                </el-select>
            </div>
            <div>
                <el-button v-permission="'Event'" type="primary" color="#4E9F1C" @click="handleAddEvent">
                    New Event
                    <el-icon>
                        <ArrowRight />
                    </el-icon>
                </el-button>
            </div>
        </div>
        <div class="table" :style="{ height: `${tableHeight}px` }">
            <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                v-if="tableData.length > 0">
                <el-table-column prop="id" label="Event ID" :align="'center'" width="100" fixed="left">

                </el-table-column>
                <el-table-column prop="title" label="Title" :align="'left'" width="180" fixed="left">
                    <template #default="scope">
                        <div class="table-name">
                            <span>{{ scope.row.title }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="startTime" label="Start Time" :align="'left'" width="180" />
                <el-table-column prop="location" label="Location" width="180" />
                <el-table-column prop="briefIntroduction" label="Introduction" width="200">
                    <template #default="scope">
                        <div class="table-cut">
                            <div v-html="scope.row?.briefIntroduction"></div>
                            <!-- {{ scope.row.briefIntroduction }} -->
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="language" label="Language" :align="'center'" width="100" />
                <el-table-column prop="mainImg" label="Image" :align="'center'" width="150">
                    <template #default="scope">
                        <div class="table-img">
                            <el-image style="width: 100px; height: 100px" :src="scope.row.mainImg" fit="contain"
                                v-if="scope.row.mainImg" />
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="link" label="Link" width="200" />
                <el-table-column prop="fileUrl" label="File" width="100">
                    <template #default="scope">
                        <a :href="scope.row.fileUrl" v-if="scope.row.fileUrl" target="_blank">
                            <el-icon size="24" class="color-web">
                                <Document />
                            </el-icon>
                        </a>
                    </template>
                </el-table-column>
                <el-table-column prop="status" label="Status" width="150" />
                <el-table-column prop="" label="Action" :align="'center'" fixed="right">
                    <template #default="scope">
                        <div class="pointer">
                            <el-popover placement="bottom" :width="170" trigger="hover">
                                <template #reference>
                                    <el-icon :size="30" color="#969696">
                                        <MoreFilled />
                                    </el-icon>
                                </template>
                                <div v-permission="'Event'" class="action">
                                    <div class="item" @click="handleViewEvent(scope.row)">View</div>
                                    <div class="item" @click="handleEditEvent(scope.row)">Edit</div>
                                    <div class="item" @click="handleShowDelEvent()">Delete</div>
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
            <div class="down-area">
                <template v-if="tableData.length > 0">
                    <div class="">Download:</div>
                    <div class="download-link" @click="exportEvent('csv')">CSV</div>
                    <div class="download-link" @click="exportEvent('xml')">XML</div>
                    <div class="download-link" @click="exportEvent('json')">JSON</div>
                </template>
            </div>
            <el-pagination background layout="total,consists of sizes, prev, pager, next, jumper, ->, slot"
                :total="listTotal" v-model:page-size="pageSize" v-model:current-page="pageNum"
                @current-change="handleCurrentChange" />
        </div>
    </div>
    <RightPanel ref="rightPanel" @back-Fn="getEventList">
        <template #content>
            <component :is="panelComponents[selectPanel].component" v-if="selectPanel !== null"></component>
        </template>
    </RightPanel>
</template>

<style lang="scss" scoped>
.event {
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
            height: 40px;
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
    display: flex;
    justify-content: center;
    align-items: center;

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