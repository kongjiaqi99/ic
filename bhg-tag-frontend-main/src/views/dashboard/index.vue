<script setup lang="ts">
import { CaretBottom } from "@element-plus/icons-vue";
import Investment from "./components/Investment.vue";
import EnquiryList from "./components/EnquiryList.vue";


const info = ref(
    [
        {
            name: 'Number of client',
            number: '0',
            isPop: false
        },
        {
            name: 'Number of enquiry',
            number: '0',
            isPop: false
        },
        {
            name: 'Upcoming birthday reminder',
            number: '0',
            isPop: true
        }
    ]
)

onMounted(() => {
    getDashboardNumInfo()
    getDashboardClients()
})

const getDashboardNumInfo = async () => {
    let params = {}
    const [e, r] = await api.queryDashboardNum(params)
    if (!e && r) {
        info.value[0].number = r.data?.clientNum || 0
        info.value[1].number = r.data?.enquiryNum || 0
    }
}

const getDashboardClients = async () => {
    let params = {}
    const [e, r] = await api.queryDashboardClients(params)
    if (!e && r) {
        gridData.value = r.data || []
        info.value[2].number = r.data.length
    }
}


const gridData = ref([])
</script>
<template>
    <div class="info-box">
        <div class="info-item" v-for="(item, index) in info" :key="index">
            <div class="text">{{ item.name }}</div>
            <div class="number">{{ item.number }}</div>
            <div class="pop" v-if="item.isPop">
                <el-popover placement="bottom" :width="784" trigger="click">
                    <template #reference>
                        <el-icon :size="30" class="color-web">
                            <CaretBottom />
                        </el-icon>
                    </template>
                    <el-table :data="gridData" :show-header="false">
                        <el-table-column property="clientName" label="">
                            <template #default="scope">
                                <div class="table-name">
                                    <span>{{ scope.row.clientName }}</span>
                                </div>
                            </template>
                        </el-table-column>
                        <el-table-column property="birthday" label="">
                        </el-table-column>
                        <el-table-column property="email" label="" />
                    </el-table>
                </el-popover>
            </div>
        </div>
    </div>
    <Investment></Investment>
    <EnquiryList></EnquiryList>
</template>

<style scoped lang="scss">
.info-box {
    width: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
    padding-bottom: 20px;

    .info-item {
        width: calc((100% - 72px) / 3);
        height: 164px;
        border-radius: 8px;
        background: #FFF;
        box-shadow: 0px 5px 12px 0px rgba(106, 106, 106, 0.10);
        // margin: 0 18px;
        display: flex;
        flex-direction: column;
        justify-content: center;
        position: relative;

        .text {
            padding-left: 30px;
            color: #363636;
            font-size: 20px;
            font-style: normal;
            font-weight: 600;
            line-height: 16px;
            letter-spacing: 0.8px;
            text-transform: capitalize;
        }

        .number {
            padding-left: 30px;
            color: #333;
            font-size: 64px;
            font-style: normal;
            font-weight: 500;
            text-transform: capitalize;
        }

        .pop {
            position: absolute;
            top: 25px;
            right: 38px;
            cursor: pointer;
        }
    }

    .info-item+.info-item {
        margin-left: 36px;
    }
}
</style>