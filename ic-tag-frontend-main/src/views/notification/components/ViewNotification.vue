<script setup lang="ts">
import { Document } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"

import { NotificationKey } from "@/symbols/notification"

import dayjs from "dayjs";

const { nId } = injectStrict(NotificationKey)


const notificationInfo = ref<AnyObj>({})

onMounted(() => {
    getDetail()
})

async function getDetail() {
    let params = {
        id: nId.value
    }
    const [e, r] = await api.queryNotificationById(params)
    if (!e && r) {
        console.log(r.data);
        notificationInfo.value = r?.data || {}
    }
}
</script>

<template>
    <div class="pop-top">
        <div class="title">View notification</div>
        <div>
        </div>
    </div>
    <div class="form">
        <el-descriptions :column="1" border>
            <el-descriptions-item label="ID" label-align="center" align="center">
                {{ notificationInfo?.id }}
            </el-descriptions-item>
            <el-descriptions-item label="Title" label-align="center" align="center">
                {{ notificationInfo?.title }}
            </el-descriptions-item>
            <el-descriptions-item label="Message" label-align="center" align="center">
                {{ notificationInfo?.message || 'EMPTY' }}
            </el-descriptions-item>
            <el-descriptions-item label="标题" label-align="center" align="center">
                {{ notificationInfo?.titleCn }}
            </el-descriptions-item>
            <el-descriptions-item label="消息" label-align="center" align="center">
                {{ notificationInfo?.messageCn || 'EMPTY' }}
            </el-descriptions-item>
            <el-descriptions-item label="Client" label-align="center" align="center">
                <div v-if="notificationInfo?.isAll">All</div>
                <div v-else>
                    {{ notificationInfo?.clientNameArr ? notificationInfo?.clientNameArr.join(',') : "" }}
                </div>
            </el-descriptions-item>
            <el-descriptions-item label="File" label-align="center" align="center">
                <a :href="notificationInfo?.file" v-if="notificationInfo?.file" target="_blank">
                    <el-icon size="24" class="color-web">
                        <Document />
                    </el-icon>
                </a>
            </el-descriptions-item>
            <el-descriptions-item label="Created At" label-align="center" align="center">
                {{ dayjs(notificationInfo?.createdAt).format('DD.MM.YYYY') }}
            </el-descriptions-item>
            <el-descriptions-item label="Updated At" label-align="center" align="center">
                {{ dayjs(notificationInfo?.updatedAt).format('DD.MM.YYYY') }}
            </el-descriptions-item>
        </el-descriptions>
    </div>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;
}
</style>