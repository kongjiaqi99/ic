<script setup lang="ts">
import { injectStrict } from "@/utils"

import { AdminKey } from "@/symbols/admin"

const { aId } = injectStrict(AdminKey)


const userInfo = ref<AnyObj>({})

onMounted(() => {
    getDetail()
})

async function getDetail() {
    let params = {
        id: aId.value
    }
    const [e, r] = await api.queryAdminById(params)
    if (!e && r) {
        userInfo.value = r?.data || {}
    }
}
</script>

<template>
    <div class="pop-top">
        <div class="title">View Admin User</div>
        <div>
        </div>
    </div>
    <div class="form">
        <el-descriptions :column="1" border>
            <el-descriptions-item label="Email" label-align="center" align="center">
                {{ userInfo?.email }}
            </el-descriptions-item>
            <el-descriptions-item label="ID" label-align="center" align="center">
                {{ userInfo?.id }}
            </el-descriptions-item>
            <el-descriptions-item label="Reset PWD Token" label-align="center" align="center">
                {{ userInfo?.resetPwdToken || 'EMPTY' }}
            </el-descriptions-item>
            <el-descriptions-item label="Reset PWD Send at" label-align="center" align="center">
                {{ userInfo?.resetPwdSendAt || 'EMPTY' }}
            </el-descriptions-item>
            <el-descriptions-item label="Create at" label-align="center" align="center">
                {{ userInfo?.createAt }}
            </el-descriptions-item>
            <el-descriptions-item label="Update at" label-align="center" align="center">
                {{ userInfo?.updateAt }}
            </el-descriptions-item>
            <el-descriptions-item label="Role" label-align="center" align="center">
                {{ userInfo?.role }}
            </el-descriptions-item>
        </el-descriptions>
    </div>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;
}
</style>