<script setup lang="ts">
import { MoreFilled, ArrowRight } from '@element-plus/icons-vue'
import { TagsFilter, AddTagsFunds } from "./components/index";
import { ElMessageBox } from 'element-plus'

import { TagsKey } from "@/symbols/tags"

const router = useRouter()
const loading = ref(false)
const tableHeight = ref(600)

//funds list数组
const tableData = ref([
])

const centerDialogVisible = ref(false)

const tagList = ref<AnyObj[]>([])
const selectTags = ref<AnyObj[]>([])
const selectFunds = ref([])


onMounted(() => {
    queryTagsPage()
    nextTick(() => {
        const title = document.getElementById('title')?.clientHeight || 0
        const fund = document.getElementById('audit')?.clientHeight || 0
        const tool = document.getElementById('tool')?.clientHeight || 0
        const pagination = document.getElementById('pagination')?.clientHeight || 20
        tableHeight.value = fund - title - tool - pagination
    })
})

async function queryTagsPage() {
    const [e, r] = await api.queryTags({})
    if (!e && r) {
        const data: any = r
        tagList.value = data
        console.log(data);

    }
}

async function queryTagsFund() {
    loading.value = true
    let ids = selectTags.value.map((item => {
        return item.tagId
    })).join(',')
    let params = {
        ids
    }
    const [e, r] = await api.getFundsWithTags(params)
    loading.value = false
    if (!e && r) {
        const data: any = r
        tableData.value = data?.funds || []
        // console.log(tableData.value);
    }
}

const handleViewFund = (item) => {
    router.push({ path: `/fund/index`, query: { fundId: item.id, status: 'view' } }).catch((err) => {
        console.warn(err)
    })
}
const handleEditFund = (item) => {
    router.push({ path: `/fund/index`, query: { fundId: item.id, status: 'edit' } }).catch((err) => {
        console.warn(err)
    })
}
const handleShowDelFund = () => {
    centerDialogVisible.value = !centerDialogVisible.value
}

const handleDelFund = async (item) => {
    console.log(item);
    let params = {
        fundId: [item.id],
        tagId: item.tagId
    }
    console.log(params);
    await api.deleteTagFunds(params)
    centerDialogVisible.value = false
    queryTagsFund()
}

const handleSelectionChange = async (val) => {
    selectFunds.value = val.map(item => {
        return item.id
    })
}

const handleEditAll = async () => {
    if (selectFunds.value.length <= 0) return
    ElMessageBox.confirm(`Are you sure you want to delete?`, 'Warning', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
    })
        .then(async () => {
            let params = {
                fundId: selectFunds.value,
                tagId: selectTags.value[0].tagId
            }
            console.log(params);
            await api.deleteTagFunds(params)
            queryTagsFund()
        })
        .catch(() => { })
}

//向下抛出数据
provide(TagsKey, { selectTags: selectTags, tagList, getTags: queryTagsPage, getTagFunds: queryTagsFund })
</script>
<template>
    <div class="audit" id="audit" v-loading="loading">
        <div class="title" id="title">Tag List</div>
        <div class="tool-box" id="tool">
            <div class="flex">
            </div>
            <div>
                <el-button class="color-web-bg text-white margin-l-20" v-permission="'Client'"
                    v-show="selectTags.length === 1" @click.stop="handleEditAll">
                    Delete Fund
                    <el-icon>
                        <ArrowRight />
                    </el-icon>
                </el-button>
                <AddTagsFunds></AddTagsFunds>
            </div>
        </div>
        <div class="container">
            <div :style="{ height: `${tableHeight}px` }">
                <TagsFilter></TagsFilter>
            </div>
            <div class="table" :style="{ height: `${tableHeight}px` }">
                <el-table :data="tableData" :height="tableHeight" :row-style="{ height: '80px' }"
                    v-if="tableData.length > 0" @selection-change="handleSelectionChange">
                    <el-table-column type="selection" width="55" v-if="selectTags.length === 1" />
                    <el-table-column prop="name" label="Fund" :align="'left'">
                        <template #default="scope">
                            <div class="table-name pointer" @click="handleViewFund(scope.row)">
                                <span>{{ scope.row.name }}</span>
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column prop="fundType" label="Fund Category" :align="'center'" width="150">
                    </el-table-column>
                    <el-table-column prop="endDate" label="Fund End Date" :align="'center'" width="150" />
                    <el-table-column prop="" label="Action" :align="'center'" width="100">
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
                                        <div v-permission="'Fund'" class="item" @click="handleEditFund(scope.row)">
                                            Edit
                                        </div>
                                        <div v-permission="'Fund'" class="item" @click="handleShowDelFund()">
                                            Delete
                                        </div>
                                        <el-dialog v-model="centerDialogVisible" title="Message" width="30%"
                                            align-center>
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

    .tool-box {
        min-height: 48px;
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

    .container {
        display: flex;
        align-items: center;
        padding: 0 56px 0;
    }

    .table {
        display: flex;
        justify-content: center;
        align-items: center;
        width: calc(100% - 420px);
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

.margin-l-20 {
    margin-left: 20px;
}
</style>