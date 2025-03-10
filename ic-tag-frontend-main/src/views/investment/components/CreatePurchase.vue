<script setup lang="ts">
import { ArrowRight } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"
// import { isEmail } from "@/utils/validate";
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';
import { InvestmentKey } from "@/symbols/investment"

import type { UploadUserFile } from 'element-plus'

interface RuleForm {
    clientId: string
    fundId: string
    investmentEntityId: string
    transactionDate: string
    purchasedAmount: string
    unitCertificateDate: string
    purchaseEndDate: string
    applicationFormSignedFile: any
    applicationFormSignedFileTwo: any
    applicationFormSignedFileThree: any
    applicationFormSignedFileFour: any
}

const { info } = injectStrict(InvestmentKey)


//回调方法
const { func } = injectStrict(PopupKey)
// eslint-disable-next-line @typescript-eslint/no-unused-vars
const emit = defineEmits(["showEntity"])
const loading = ref(false)

onMounted(() => {
    ruleForm.clientId = info.value.clientId
    ruleForm.fundId = info.value.fundId
    ruleForm.investmentEntityId = info.value.entityId
})
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
    // applicationFormSigned: '',
    // applicationFormSignedTwo: '',
    // applicationFormSignedThree: '',
    // applicationFormSignedFour: '',
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
})

const handleAddAdmin = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            console.log('submit!')
            ruleForm.applicationFormSignedFile = applicationFormSignedFileList.value.length > 0 ? applicationFormSignedFileList.value[0].raw : ''
            ruleForm.applicationFormSignedFileTwo = applicationFormSignedFileList2.value.length > 0 ? applicationFormSignedFileList2.value[0].raw : ''
            ruleForm.applicationFormSignedFileThree = applicationFormSignedFileList3.value.length > 0 ? applicationFormSignedFileList3.value[0].raw : ''
            ruleForm.applicationFormSignedFileFour = applicationFormSignedFileList4.value.length > 0 ? applicationFormSignedFileList4.value[0].raw : ''
            loading.value = true
            savePurchase()
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
        if (![null, undefined].includes(params[keys])) {
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
</script>

<template>
    <div class="pop-top">
        <div class="title">Create Purchase</div>
        <div>
            <el-button type="primary" color="#4E9F1C" @click="handleAddAdmin(ruleFormRef)">
                Create Purchase
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="200px" status-icon>
            <el-form-item label="Client" prop="clientId">
                {{ info.clientName }}
            </el-form-item>
            <el-form-item label="Fund" prop="fundId">
                {{ info.fundName }}
            </el-form-item>
            <el-form-item label="Entity Name" prop="entityName">
                {{ info.entityName }}
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
            <el-form-item label="Application form signed2" prop="applicationFormSignedFileTwo">
                <el-upload v-model:file-list="applicationFormSignedFileList2" :auto-upload="false" :limit="1"
                    list-type="text">
                    <template #trigger>
                        <el-button type="primary">Choose file</el-button>
                    </template>
                </el-upload>
            </el-form-item>
            <el-form-item label="Application form signed3" prop="applicationFormSignedFileThree">
                <el-upload v-model:file-list="applicationFormSignedFileList3" :auto-upload="false" :limit="1"
                    list-type="text">
                    <template #trigger>
                        <el-button type="primary">Choose file</el-button>
                    </template>
                </el-upload>
            </el-form-item>
            <el-form-item label="Application form signed4" prop="applicationFormSignedFileFour">
                <el-upload v-model:file-list="applicationFormSignedFileList4" :auto-upload="false" :limit="1"
                    list-type="text">
                    <template #trigger>
                        <el-button type="primary">Choose file</el-button>
                    </template>
                </el-upload>
            </el-form-item>
        </el-form>
    </div>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;

    .p-t-10 {
        margin: 0 20px;
    }
}
</style>