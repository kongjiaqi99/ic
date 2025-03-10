<script setup lang="ts">
import { ArrowRight, Document } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"
// import { isEmail } from "@/utils/validate";
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';
import { InvestmentKey } from "@/symbols/investment"
import dayjs from 'dayjs';
import type { UploadUserFile } from 'element-plus'

interface RuleForm {
    clientId: string
    fundId: string
    investmentEntityId: string
    transactionDate: string
    purchasedAmount: string
    unitCertificateDate: string
    purchaseEndDate: string
    applicationFormSigned: any
    applicationFormSignedTwo: any
    applicationFormSignedThree: any
    applicationFormSignedFour: any
    applicationFormSignedFile: any
    applicationFormSignedFileTwo: any
    applicationFormSignedFileThree: any
    applicationFormSignedFileFour: any
}

const { iId, info } = injectStrict(InvestmentKey)
console.log("🚀 ~ file: CreatePurchase.vue:25 ~ info:", info.value)

const loading = ref(false)

//回调方法
const { func } = injectStrict(PopupKey)


onMounted(() => {
    if (iId.value) {
        getList()
    } else {
        ruleForm.clientId = info.value?.clientId
        ruleForm.fundId = info.value?.fundId
        ruleForm.investmentEntityId = info.value?.entityId
        getEditFund(ruleForm.fundId)
    }
})
const fundData = ref<AnyObj>({})
const listData = ref<AnyObj>({})
const applicationFormSignedFileList = ref<UploadUserFile[]>([])
const applicationFormSignedFileList2 = ref<UploadUserFile[]>([])
const applicationFormSignedFileList3 = ref<UploadUserFile[]>([])
const applicationFormSignedFileList4 = ref<UploadUserFile[]>([])
const ruleFormRef = ref<FormInstance>()
const ruleForm = reactive<RuleForm>({
    clientId: '',
    fundId: '',
    investmentEntityId: '',
    transactionDate: '',
    purchasedAmount: '',
    unitCertificateDate: '',
    purchaseEndDate: '',
    applicationFormSigned: '',
    applicationFormSignedTwo: '',
    applicationFormSignedThree: '',
    applicationFormSignedFour: '',
    applicationFormSignedFile: "",
    applicationFormSignedFileTwo: "",
    applicationFormSignedFileThree: "",
    applicationFormSignedFileFour: "",
})

const rules = reactive<FormRules<RuleForm>>({
    unitCertificateDate: [
        {
            type: 'date',
            required: true,
            message: 'Please pick a unitCertificateDate',
            trigger: 'change',
        },
    ],
    purchasedAmount: [
        { required: true, message: 'Please input Purchase Amount', trigger: 'blur' },
    ],
    transactionDate: [
        { type: 'date', required: fundData.value?.bfundCategory === 'Direct', message: 'Please pick a Transaction Date', trigger: 'change' }
    ]
})

const handleAddAdmin = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            console.log('submit!')
            if (applicationFormSignedFileList.value.length > 0) {
                ruleForm.applicationFormSignedFile = applicationFormSignedFileList.value[0].raw
            } else {
                ruleForm.applicationFormSigned = listData.value?.applicationFormSigned
            }
            if (applicationFormSignedFileList2.value.length > 0) {
                ruleForm.applicationFormSignedFileTwo = applicationFormSignedFileList2.value[0].raw
            } else {
                ruleForm.applicationFormSignedTwo = listData.value?.applicationFormSignedTwo
            }
            if (applicationFormSignedFileList3.value.length > 0) {
                ruleForm.applicationFormSignedFileThree = applicationFormSignedFileList3.value[0].raw
            } else {
                ruleForm.applicationFormSignedThree = listData.value?.applicationFormSignedThree
            }
            if (applicationFormSignedFileList4.value.length > 0) {
                ruleForm.applicationFormSignedFileFour = applicationFormSignedFileList4.value[0].raw
            } else {
                ruleForm.applicationFormSignedFour = listData.value?.applicationFormSignedFour
            }
            loading.value = true
            if (!iId.value) {
                savePurchase()
            } else {
                editPurchase()
            }
        } else {
            ElMessage.error('Please enter correct content!')
            console.log('error submit!', fields)
        }
    })
}

async function savePurchase() {
    let params = ruleForm
    const formData = new FormData()
    Object.keys(params).forEach(keys => {
        if (![null, undefined, ''].includes(params[keys])) {
            formData.append(keys, params[keys])
        }
    })
    const [e, r] = await api.createPurchasedFund(formData)
    loading.value = false
    if (!e && r) {
        if (r.success) {
            ElMessage.success('Created successfully')
            setTimeout(() => {
                func()
            }, 1000)
        }
    }
}

async function editPurchase() {
    let params = { ...ruleForm, id: iId.value }
    const formData = new FormData()
    Object.keys(params).forEach(keys => {
        if (![null, undefined, ''].includes(params[keys])) {
            formData.append(keys, params[keys])
        }
    })
    const [e, r] = await api.editPurchasedFund(formData)
    loading.value = false
    if (!e && r) {
        if (r.success) {
            ElMessage.success('Edit successfully')
            setTimeout(() => {
                func()
            }, 1000)
        }
    }
}

async function getList() {
    let params = {
        id: iId.value
    }
    const [e, r] = await api.queryPurchasedFundById(params)
    if (!e && r) {
        getEditFund(r.data?.fundId)
        console.log("getList", r.data);
        ruleForm.clientId = r.data?.clientId || ''
        ruleForm.fundId = r.data?.fundId || ''
        ruleForm.investmentEntityId = r.data?.investmentEntityId || ''
        listData.value = r.data
        ruleForm.transactionDate = r.data?.transactionDate ? dayjs(r.data?.transactionDate).format('YYYY-MM-DD') : ''
        ruleForm.purchasedAmount = r.data?.purchasedAmount || ''
        ruleForm.unitCertificateDate = r.data?.unitCertificateDate ? dayjs(r.data?.unitCertificateDate).format('YYYY-MM-DD') : ''
        ruleForm.purchaseEndDate = r.data?.purchaseEndDate ? dayjs(r.data?.purchaseEndDate).format('YYYY-MM-DD') : ''
    }
}

async function getEditFund(id: string) {
    let params = {
        id: id
    }
    const [e, r] = await api.queryFundById(params)
    if (!e && r) {
        console.log("🚀 ~ file: CreatePurchase.vue:154 ~ getEditFund ~ r:", r.data)
        fundData.value = r.data
        rules.transactionDate = [
            { type: 'date', required: fundData.value?.bfundCategory === 'Direct', message: 'Please pick a Transaction Date', trigger: 'change' }
        ]
    }
}
</script>

<template>
    <div class="pop-top">
        <div class="title">{{ !iId ? 'Create Purchase' : 'Edit Purchase' }}</div>
        <div v-loading="loading">
            <el-button type="primary" color="#4E9F1C" @click="handleAddAdmin(ruleFormRef)">
                {{ !iId ? 'New Purchase' : 'Edit Purchase' }}
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="200px" status-icon>
            <el-form-item label="Client" prop="clientId">
                {{ info?.clientName || listData.clientName || '' }}
            </el-form-item>
            <el-form-item label="Fund" prop="fundId">
                {{ info?.fundName || listData.fundName || '' }}
            </el-form-item>
            <el-form-item label="Entity Name" prop="entityName">
                {{ info?.entityName || listData.investmentEntityName || '' }}
            </el-form-item>
            <el-form-item label="Transaction Date" prop="transactionDate">
                <el-date-picker v-model="ruleForm.transactionDate" type="date" format="YYYY-MM-DD"
                    value-format="YYYY-MM-DD" clearable>
                </el-date-picker>
            </el-form-item>
            <el-form-item label="Purchase Amount" prop="purchasedAmount">
                <el-input v-model="ruleForm.purchasedAmount" type="number" />
            </el-form-item>
            <el-form-item label="U/C Date" prop="unitCertificateDate">
                <el-date-picker v-model="ruleForm.unitCertificateDate" type="date" format="YYYY-MM-DD"
                    value-format="YYYY-MM-DD" clearable>
                </el-date-picker>
            </el-form-item>
            <el-form-item label="Purchase End Date" prop="purchaseEndDate">
                <el-date-picker v-model="ruleForm.purchaseEndDate" type="date" format="YYYY-MM-DD"
                    value-format="YYYY-MM-DD" clearable>
                </el-date-picker>
            </el-form-item>
            <el-form-item label="Application form signed1" prop="applicationFormSignedFile">
                <el-upload v-model:file-list="applicationFormSignedFileList" :auto-upload="false" :limit="1"
                    list-type="text">
                    <template #trigger>
                        <el-button type="primary">Choose file</el-button>
                    </template>
                </el-upload>
            </el-form-item>
            <el-form-item label="" v-if="listData?.applicationFormSigned">
                <a :href="listData?.applicationFormSigned" v-if="listData?.applicationFormSigned" target="_blank">
                    <el-icon size="24" class="color-web">
                        <Document />
                    </el-icon>
                </a>
            </el-form-item>
            <el-form-item label="Application form signed2" prop="applicationFormSignedFileTwo">
                <el-upload v-model:file-list="applicationFormSignedFileList2" :auto-upload="false" :limit="1"
                    list-type="text">
                    <template #trigger>
                        <el-button type="primary">Choose file</el-button>
                    </template>
                </el-upload>
            </el-form-item>
            <el-form-item label="" v-if="listData?.applicationFormSignedTwo">
                <a :href="listData?.applicationFormSignedTwo" v-if="listData?.applicationFormSignedTwo" target="_blank">
                    <el-icon size="24" class="color-web">
                        <Document />
                    </el-icon>
                </a>
            </el-form-item>
            <el-form-item label="Application form signed3" prop="applicationFormSignedFileThree">
                <el-upload v-model:file-list="applicationFormSignedFileList3" :auto-upload="false" :limit="1"
                    list-type="text">
                    <template #trigger>
                        <el-button type="primary">Choose file</el-button>
                    </template>
                </el-upload>
            </el-form-item>
            <el-form-item label="" v-if="listData?.applicationFormSignedThree">
                <a :href="listData?.applicationFormSignedThree" v-if="listData?.applicationFormSignedThree"
                    target="_blank">
                    <el-icon size="24" class="color-web">
                        <Document />
                    </el-icon>
                </a>
            </el-form-item>
            <el-form-item label="Application form signed4" prop="applicationFormSignedFileFour">
                <el-upload v-model:file-list="applicationFormSignedFileList4" :auto-upload="false" :limit="1"
                    list-type="text">
                    <template #trigger>
                        <el-button type="primary">Choose file</el-button>
                    </template>
                </el-upload>
            </el-form-item>
            <el-form-item label="" v-if="listData?.applicationFormSignedFour">
                <a :href="listData?.applicationFormSignedFour" v-if="listData?.applicationFormSignedFour"
                    target="_blank">
                    <el-icon size="24" class="color-web">
                        <Document />
                    </el-icon>
                </a>
            </el-form-item>
        </el-form>
        <div class="block padding-t-20" v-if="iId">
            <div class="table-title">Interest Payment Records</div>
            <el-table :data="listData.dividendHistory" height="240" :row-style="{ height: '30px' }"
                header-cell-class-name="table-sell-style">
                <el-table-column prop="dividendDate" label="Interest Payment Date" :align="'center'" />
                <el-table-column prop="dividendAmount" label="Interest Amount" :align="'center'" />
            </el-table>
        </div>
    </div>
</template>

<style lang="scss">
.form {
    padding: 20px;

    .p-t-10 {
        margin: 0 20px;
    }

    .block {
        border-top: 1px solid #DEDEDE;

        .table-title {
            color: #4F4F4F;
            font-size: 16px;
            font-style: normal;
            font-weight: 600;
            padding-bottom: 15px;
        }
    }

    .padding-t-20 {
        padding-top: 20px;
    }
}
</style>