<script lang="ts" setup>
// import { Bell, ArrowRight } from '@element-plus/icons-vue'

const tableData = ref([
])

//table 数据总数
const listTotal = ref(0)
//每页几条
const pageSize = ref(10)
//第几页
const pageNum = ref(1)

onMounted(() => {
    getEnquiryList()
})

async function getEnquiryList() {
    let params = {
        pageSize: pageSize.value,
        pageNum: pageNum.value
    }
    let query = {}
    const [e, r] = await api.queryEnquiries(query, params)
    if (!e && r) {
        // console.log(r.data);
        listTotal.value = r.data?.total || 0
        tableData.value = r.data?.list || []
    } else {
        console.log(e);
    }

}

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    getEnquiryList()
}
</script>

<template>
    <div class="enquiry">
        <div class="top">
            <div>
                <div class="title">Enquiry List</div>
                <div class="sub-title">You Have requests awaiting your approval</div>
            </div>
            <div></div>
        </div>
        <div class="table">
            <el-table :data="tableData" height="532" :row-style="{ height: '80px' }" v-if="tableData.length > 0">
                <el-table-column prop="id" label="Enquiry ID" :align="'center'">
                    <template #default="scope">
                        <div class="table-name">
                            <span>{{ scope.row.id }}</span>
                        </div>
                    </template>
                </el-table-column>
                <el-table-column prop="email" label="Email" :align="'left'" />
                <el-table-column prop="name" label="Name" :align="'left'" />
                <el-table-column prop="message" label="Message" />
                <el-table-column prop="createAt" label="Create at" />
            </el-table>
            <el-empty :image-size="200" v-else />
        </div>
        <div class="pagination">
            <div></div>
            <el-pagination background layout="total,consists of sizes, prev, pager, next, jumper, ->, slot"
                :total="listTotal" v-model:page-size="pageSize" v-model:current-page="pageNum"
                @current-change="handleCurrentChange" />
        </div>
    </div>
</template>

<style lang="scss" scoped>
.enquiry {
    width: 100%;
    height: 762px;
    margin-top: 20px;
    border-radius: 12px;
    background: #FFF;
    box-shadow: 0px 1px 1px 0px rgba(0, 0, 0, 0.08), 0px 2px 1px 0px rgba(0, 0, 0, 0.06), 0px 1px 3px 0px rgba(0, 0, 0, 0.10);

    .top {
        display: flex;
        justify-content: space-between;
        align-items: center;
        padding: 48px 56px;

        .title {
            color: #1C1C1C;
            font-size: 24px;
            font-style: normal;
            font-weight: 700;
        }

        .sub-title {
            color: #9FA1A6;
            font-size: 16px;
            font-style: normal;
            font-weight: 400;
            line-height: 16px;
            padding-top: 6px;
        }
    }

    .pagination {
        display: flex;
        align-items: center;
        justify-content: space-between;
        padding: 15px 80px;
    }
}
</style>
