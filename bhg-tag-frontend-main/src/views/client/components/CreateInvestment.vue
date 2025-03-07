
<script setup lang="ts">
import { ArrowRight } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"
// import { isEmail } from "@/utils/validate";
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';
import type { UploadUserFile } from 'element-plus'
import { InvestmentKey } from "@/symbols/investment"

interface RuleForm {
    clientId: string
    fundId: string
    investmentEntityId: string
    transactionDate: string
    purchasedAmount: string
    unitCertificateDate: string
    purchaseEndDate: string
    applicationFormSigned: any
}

const { info } = injectStrict(InvestmentKey)
const loading = ref(false)

//回调方法
const { func } = injectStrict(PopupKey)

onMounted(async () => {
    await getClientList()
    await getFundList()
    ruleForm.clientId = info.value.clientId
    ruleForm.investmentEntityId = info.value.entityId
})

const clientList = ref([])
const fundList = ref([])
const applicationFormSignedFileList = ref<UploadUserFile[]>([])
const ruleFormRef = ref<FormInstance>()
const ruleForm = reactive<RuleForm>({
    clientId: '',
    fundId: '',
    investmentEntityId: '',
    transactionDate: '',
    purchasedAmount: '',
    unitCertificateDate: '',
    purchaseEndDate: '',
    applicationFormSigned: ''
})

const rules = reactive<FormRules<RuleForm>>({
    // clientId: [
    //     { required: true, message: 'Please select client', trigger: 'blur' },
    // ],
    fundId: [
        { required: true, message: 'Please select fund', trigger: 'change', },
    ],
    // investmentEntityId: [
    //     { required: true, message: 'Please select entity', trigger: 'blur' },
    // ],
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
            ruleForm.applicationFormSigned = applicationFormSignedFileList.value.length > 0 ? applicationFormSignedFileList.value[0].raw : ''
            loading.value = true
            saveInvestment()
        } else {
            ElMessage.error('Please enter correct content!')
            console.log('error submit!', fields)
        }
    })
}

async function getClientList() {
    let params = {}
    const [e, r] = await api.getClientsNames(params)
    if (!e && r) {
        clientList.value = r?.data || []
    }
}

async function getFundList() {
    let params = {}
    const [e, r] = await api.getFundsNames(params)
    if (!e && r) {
        fundList.value = r?.data || []
    }
}

async function saveInvestment() {
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
</script>

<template>
    <div class="pop-top">
        <div class="title">Create Investment</div>
        <div v-loading="loading">
            <el-button type="primary" color="#4E9F1C" @click="handleAddAdmin(ruleFormRef)">
                New Investment
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="200px" status-icon>
            <!-- <el-form-item label="Client" prop="clientId">
                <el-select v-model="ruleForm.clientId" placeholder="Please Client" filterable clearable>
                    <el-option :label="item.name" :value="item.id" v-for="(item, index) in clientList" :key="index" />
                </el-select>
            </el-form-item> -->
            <el-form-item label="Client" prop="clientId">
                {{ info?.clientName || '' }}
            </el-form-item>
            <el-form-item label="Entity Name" prop="investmentEntityId">
                {{ info?.entityName || '' }}
            </el-form-item>
            <el-form-item label="Fund" prop="fundId">
                <el-select v-model="ruleForm.fundId" placeholder="Please Fund" filterable clearable>
                    <el-option :label="item.name" :value="item.id" v-for="(item, index) in fundList" :key="index" />
                </el-select>
            </el-form-item>
            <el-form-item label="Transaction Date" prop="transactionDate">
                <el-date-picker v-model="ruleForm.transactionDate" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
                    clearable>
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
                <el-date-picker v-model="ruleForm.purchaseEndDate" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
                    clearable>
                </el-date-picker>
            </el-form-item>
            <el-form-item label="Application form signed" prop="applicationFormSigned">
                <el-upload v-model:file-list="applicationFormSignedFileList" :auto-upload="false" :limit="1"
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