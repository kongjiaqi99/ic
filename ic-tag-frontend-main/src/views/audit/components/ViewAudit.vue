<script setup lang="ts">
import { getFilenameFromUrl } from '@/utils'
import { injectStrict } from "@/utils"

import { AuditKey } from "@/symbols/audit"
import { useApp } from "@/hooks/useApp";
import { PopupKey } from "@/symbols/index"
import { ElMessage } from 'element-plus';

const { breadcrumbList } = useApp()
const { aId } = injectStrict(AuditKey)
const loading = ref(false)

//回调方法
const { func } = injectStrict(PopupKey)

const AuditInfo = ref<AnyObj>({})

onMounted(() => {
    getDetail()
})

async function getDetail() {
    let params = {
        id: aId.value
    }
    const [e, r] = await api.queryAuditById(params)
    if (!e && r) {
        console.log(r.data);
        if (r.data?.newEntity) {
            r.data.newEntity = JSON.parse(r.data?.newEntity)
        }
        if (r.data?.entityContent && r?.data.auditType !== 'Re-Investment Request') {
            r.data.entityContent = JSON.parse(r.data?.entityContent)
            let entriesList = Object.entries(r.data.entityContent)
            const list = []
            for (let i = 0; i < entriesList.length; i++) {
                let select = Object.entries(entriesList[i][1])
                let item = {
                    name: `Current ${entriesList[i][0]}`,
                    value: select[0][0]
                }
                let item2 = {
                    name: `New ${entriesList[i][0]}`,
                    value: select[0][1]
                }
                list.push(item)
                list.push(item2)
            }
            console.log(list);
            r.data.entityContentShow = list
        } else if (r?.data.auditType === 'Re-Investment Request') {
            r.data.reShow = JSON.parse(r.data.entityContent)
        }
        AuditInfo.value = r?.data || {}
    }
}

const handleChange = async (status: string) => {
    loading.value = true
    let params = {
        id: aId.value,
        status: status
    }
    const [e, r] = await api.editAudit(params)
    loading.value = false
    if (!e && r) {
        ElMessage.success('Change successfully')
        setTimeout(() => {
            func()
        }, 1000)
    }
}

const handleBack = () => {
    func()
}

const handleShowFile = (item) => {
    window.open(item, '_blank');
}
</script>

<template>
    <div class="pop-top">
        <div class="title">
            <span v-for="(item, index) in breadcrumbList" :key="index">{{ item.name }}</span>
            <span> - ID:{{ aId }}</span>
        </div>
        <div>
        </div>
    </div>
    <div class="form">
        <div class="block padding-b-20">
            <el-descriptions title="" :column="1" border>
                <el-descriptions-item label="Account Email" label-align="center" align="center">
                    {{ AuditInfo?.creatorName }}
                </el-descriptions-item>
                <el-descriptions-item label="Client ID" label-align="center" align="center">
                    {{ AuditInfo?.creator }}
                </el-descriptions-item>
                <template v-if="AuditInfo.auditType === 'Re-Investment Request'">
                    <el-descriptions-item label="Client Name" label-align="center" align="center">
                        {{ AuditInfo?.reShow?.clientName || '' }}
                    </el-descriptions-item>
                    <el-descriptions-item label="Entity Name" label-align="center" align="center">
                        {{ AuditInfo?.reShow?.entityName || '' }}
                    </el-descriptions-item>
                    <el-descriptions-item label="Re-investment amount" label-align="center" align="center">
                        {{ AuditInfo?.reShow?.amount || '' }}
                    </el-descriptions-item>
                </template>
            </el-descriptions>
        </div>
        <div class="block padding-t-20 padding-b-20" v-if="AuditInfo.auditType !== 'Re-Investment Request'">
            <el-descriptions :title="AuditInfo.auditType" :column="1" border>
                <el-descriptions-item label="ic ID" label-align="center" align="center"
                    v-if="AuditInfo.auditType === 'Entity Update'">
                    {{ AuditInfo?.newEntity?.icId }}
                </el-descriptions-item>
                <el-descriptions-item :label="item.name" label-align="center" align="center"
                    v-for="(item, index) in AuditInfo.entityContentShow" :key="index">
                    {{ item.value }}
                </el-descriptions-item>
            </el-descriptions>
        </div>
        <div class="block padding-t-20 padding-b-20" v-else>
            <el-descriptions title="Related files" :column="1" border>
                <el-descriptions-item :label="item ? getFilenameFromUrl(item) : ''" label-align="center" align="center"
                    v-for="(item, index) in AuditInfo.reShow.fileUrl" :key="index">
                    <el-link type="info" @click="handleShowFile(item)">Download</el-link>
                </el-descriptions-item>
            </el-descriptions>
        </div>
        <div class="btn-group">
            <div v-permission="'Audit'" v-loading="loading">
                <el-button color="#4E9F1C" @click="handleChange('Approved')"
                    v-if="AuditInfo.status !== 'Approved'">Approve</el-button>
                <el-button color="#DC0000" @click="handleChange('Rejected')"
                    v-if="AuditInfo.status !== 'Approved'">Reject</el-button>
            </div>
            <el-button class="text-white m-l-20" color="#BDBDBD" @click="handleBack">Cancel</el-button>
        </div>
    </div>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;

    .block+.block {
        border-top: 1px solid #DEDEDE;
    }

    .padding-t-20 {
        padding-top: 20px;
    }

    .padding-b-20 {
        padding-bottom: 20px;
    }
}

.btn-group {
    border-top: 1px solid #DEDEDE;
    padding: 20px 0;
    display: flex;

    .text-white {
        color: #fff;
    }

    .m-l-20 {
        margin-left: 10px;
    }
}
</style>