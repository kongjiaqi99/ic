<script setup lang="ts">
import { Document } from '@element-plus/icons-vue'

import { injectStrict } from "@/utils"

import { EventKey } from "@/symbols/event"

const { eId } = injectStrict(EventKey)


const eventInfo = ref<AnyObj>({})

onMounted(() => {
    getDetail()
})

async function getDetail() {
    let params = {
        id: eId.value
    }
    const [e, r] = await api.queryEventById(params)
    if (!e && r) {
        console.log(r.data);

        eventInfo.value = r?.data || {}
    }
}
</script>

<template>
    <div class="pop-top">
        <div class="title">View Event</div>
        <div>
        </div>
    </div>
    <div class="view">
        <el-descriptions :column="1" border>
            <el-descriptions-item label="ID" label-align="center" align="center">
                {{ eventInfo?.id }}
            </el-descriptions-item>
            <el-descriptions-item label="Title" label-align="center" align="center">
                {{ eventInfo?.title }}
            </el-descriptions-item>
            <el-descriptions-item label="Start Time" label-align="center" align="center">
                {{ eventInfo?.startTime || 'EMPTY' }}
            </el-descriptions-item>
            <el-descriptions-item label="Location" label-align="center" align="center">
                {{ eventInfo?.location }}
            </el-descriptions-item>
            <el-descriptions-item label="Introduction" label-align="center" align="left">
                <div v-html="eventInfo?.briefIntroduction"></div>
            </el-descriptions-item>
            <el-descriptions-item label="Language" label-align="center" align="center">
                {{ eventInfo?.language || 'EMPTY' }}
            </el-descriptions-item>
            <el-descriptions-item label="Image" label-align="center" align="center">
                <el-image style="width: 100px; height: 100px" :src="eventInfo?.mainImg" fit="contain"
                    v-if="eventInfo?.mainImg" />
            </el-descriptions-item>
            <el-descriptions-item label="Link" label-align="center" align="center">
                {{ eventInfo?.link || 'EMPTY' }}
            </el-descriptions-item>
            <el-descriptions-item label="File" label-align="center" align="center">
                <a :href="eventInfo?.fileUrl" v-if="eventInfo?.fileUrl" target="_blank">
                    <el-icon size="24" class="color-web">
                        <Document />
                    </el-icon>
                </a>
            </el-descriptions-item>
            <el-descriptions-item label="Status" label-align="center" align="center">
                {{ eventInfo?.status || 'EMPTY' }}
            </el-descriptions-item>
        </el-descriptions>
    </div>
</template>

<style lang="scss" scoped>
.view {
    padding: 20px;
}
</style>