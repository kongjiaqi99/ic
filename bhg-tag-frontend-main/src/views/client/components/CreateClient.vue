
<script setup lang="ts">
import { ArrowRight } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"
import { isEmail } from "@/utils/validate";
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';

interface RuleForm {
    email: string
    name: string
    password: string
    password2: string
    countryCode: string
    mobile: string
    birth: string
    beaverId: string
    clientType: string
    upperClient: string
    level2UpperClientId: string
    withheldTax: boolean
    tfNum: string
    bsb: string
    accountName: string
    accountNumber: string
    startDate: string
    endDate: string
    targetAmount: any
    linkToValueup: boolean
    investmentCreateRequestList: any
}

//回调方法
const { func } = injectStrict(PopupKey)
const loading = ref(false)

onMounted(async () => {
    // await queryUpperClients()
    await queryClientType()
    await queryInvestmentEnTity()
})

const entityTypeClientOptions = ref([])
const clientTypeList = ref([])
// const upperClientsList = ref([])
const ruleFormRef = ref<FormInstance>()
const ruleForm = reactive<RuleForm>({
    email: "",
    name: "",
    password: 'asdf1234',
    password2: 'asdf1234',
    countryCode: "",
    mobile: "",
    birth: "",
    beaverId: "",
    clientType: "",
    upperClient: "",
    level2UpperClientId: "",
    withheldTax: false,
    tfNum: '',
    bsb: "",
    accountName: "",
    accountNumber: "",
    startDate: "",
    endDate: "",
    targetAmount: '',
    linkToValueup: false,
    investmentCreateRequestList: [],
})

const validatePass2 = (rule: any, value: any, callback: any) => {
    if (value === '') {
        callback(new Error('Please input the Password again'))
    } else if (value !== ruleForm.password) {
        callback(new Error("Two inputs don't match!"))
    } else {
        callback()
    }
}

const validateEmail = (rule: any, value: any, callback: any) => {
    if (value === '') {
        callback(new Error('Please input Email'))
    } else if (!isEmail(value)) {
        callback(new Error("Email format is incorrect!"))
    } else {
        callback()
    }
}

const rules = reactive<FormRules<RuleForm>>({
    email: [
        { required: true, message: 'Please input Email', trigger: 'blur' },
        { validator: validateEmail, trigger: 'blur' },
    ],
    password: [
        { required: true, message: 'Please input Password', trigger: 'blur' },
        { min: 8, max: 16, message: 'Length should be 8 to 16', trigger: 'blur' },
    ],
    password2: [
        { required: true, message: 'Please input Password', trigger: 'blur' },
        { min: 8, max: 16, message: 'Length should be 8 to 16', trigger: 'blur' },
        { validator: validatePass2, trigger: 'blur' }
    ],
})

const handleAddClient = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            console.log('submit!')
            loading.value = true
            saveClient()
        } else {
            ElMessage.error('Please enter correct content!')
            console.log('error submit!', fields)
        }
    })
}

// async function queryUpperClients() {
//     let params = {}
//     const [e, r] = await api.queryUpperClients(params)
//     if (!e && r) {
//         upperClientsList.value = r?.data || []
//     }
// }

async function queryClientType() {
    let params = { type: 'client_type' }
    const [e, r] = await api.queryDictionary(params)
    if (!e && r) {
        clientTypeList.value = r?.data || []
    }
}

async function queryInvestmentEnTity() {
    let params = { type: 'investment_entity_type' }
    const [e, r] = await api.queryDictionary(params)
    if (!e && r) {
        entityTypeClientOptions.value = r?.data || []
    }
}


async function saveClient() {
    let params = ruleForm
    const [e, r] = await api.createClient(params)
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

// const addInvestmentCreateRequest = () => {
//     ruleForm.investmentCreateRequestList.push({
//         entityName: '',
//         entityType: '',
//         kycResult: false
//     })
// }

// const removeInvestmentCreateRequest = (index) => {
//     ruleForm.investmentCreateRequestList.splice(index, 1)
// }

const limitTargetAmount = () => {
    if (ruleForm.targetAmount > 999999.99) {
        ruleForm.targetAmount = 999999.99
    } else {
        ruleForm.targetAmount = ruleForm.targetAmount.replace(/^\./, '0.').match(/^\d*(\.?\d{0,2})/g)[0] || ''
    }
}
</script>

<template>
    <div class="pop-top">
        <div class="title">Create Client</div>
        <div v-loading="loading">
            <el-button type="primary" color="#4E9F1C" @click="handleAddClient(ruleFormRef)">
                New Client
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="200px" status-icon>
            <el-form-item label="Email" prop="email">
                <el-input v-model="ruleForm.email" />
            </el-form-item>
            <el-form-item label="Password" prop="password">
                <el-input v-model="ruleForm.password" type="password" placeholder="Please input password" show-password />
            </el-form-item>
            <el-form-item label="Password confirmation" prop="password2">
                <el-input v-model="ruleForm.password2" type="password" placeholder="Please input password" show-password />
            </el-form-item>
            <el-form-item label="Name" prop="name">
                <el-input v-model="ruleForm.name" />
            </el-form-item>
            <el-form-item label="Country code" prop="countryCode">
                <el-input v-model="ruleForm.countryCode" />
            </el-form-item>
            <el-form-item label="Mobile" prop="mobile">
                <el-input v-model="ruleForm.mobile" />
            </el-form-item>
            <el-form-item label="Birth" prop="birth">
                <el-date-picker v-model="ruleForm.birth" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
                    clearable>
                </el-date-picker>
            </el-form-item>
            <!-- <el-form-item label="Beaver id" prop="beaverId">
                <el-input v-model="ruleForm.beaverId" />
            </el-form-item> -->
            <!-- <el-form-item label="Client type" prop="clientType">
                <el-select v-model="ruleForm.clientType" placeholder="Select Client type">
                    <el-option :label="item.code" :value="item.value" v-for="(item, index) in clientTypeList"
                        :key="index" />
                </el-select>
            </el-form-item> -->
            <!-- <el-form-item label="Level1 Upper Client" prop="upperClient">
                <el-select v-model="ruleForm.upperClient" placeholder="Please Select">
                    <el-option :label="item.name" :value="item.id" v-for="(item, index) in upperClientsList" :key="index" />
                </el-select>
            </el-form-item>
            <el-form-item label="Level2 Upper Client" prop="level2UpperClientId">
                <el-select v-model="ruleForm.level2UpperClientId" placeholder="Please Select">
                    <el-option :label="item.name" :value="item.id" v-for="(item, index) in upperClientsList" :key="index" />
                </el-select>
            </el-form-item> -->
            <el-form-item label="withheldTax" prop="withheldTax">
                <el-switch v-model="ruleForm.withheldTax" active-text="Yes" inactive-text="No" />
            </el-form-item>
            <el-form-item label="TFN" prop="tfNum">
                <el-input v-model="ruleForm.tfNum" />
            </el-form-item>
            <el-form-item label="Bsb" prop="bsb">
                <el-input v-model="ruleForm.bsb" />
            </el-form-item>
            <el-form-item label="Account name" prop="accountName">
                <el-input v-model="ruleForm.accountName" />
            </el-form-item>
            <el-form-item label="Account number" prop="accountNumber">
                <el-input v-model="ruleForm.accountNumber" />
            </el-form-item>
            <!-- <el-form-item label="Start date" prop="startDate">
                <el-date-picker v-model="ruleForm.startDate" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
                    clearable>
                </el-date-picker>
            </el-form-item>
            <el-form-item label="End date" prop="endDate">
                <el-date-picker v-model="ruleForm.endDate" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
                    clearable>
                </el-date-picker>
            </el-form-item> -->
            <el-form-item label="Target amount" prop="targetAmount">
                <el-input v-model="ruleForm.targetAmount" type="number" @input="limitTargetAmount" />
            </el-form-item>
            <el-form-item label="Link to valueup" prop="linkToValueup">
                <el-switch v-model="ruleForm.linkToValueup" />
            </el-form-item>
            <!-- <el-form-item label="Investment Entities" prop="investmentCreateRequestList">
                <div class="add-container">
                    <el-button type="success" @click="addInvestmentCreateRequest">Add</el-button>
                </div>
                <div class="inner-form" v-for="(item, index) in ruleForm.investmentCreateRequestList" :key="index">
                    <el-form-item label="Entity type">
                        <el-select filterable clearable v-model="item.entityType" placeholder="please select"
                            no-data-text="no data">
                            <el-option v-for="item in entityTypeClientOptions" :key="item.code" :label="item.code"
                                :value="item.value">
                            </el-option>
                        </el-select>
                    </el-form-item>
                    <el-form-item label="Entity name">
                        <el-input v-model="item.entityName"></el-input>
                    </el-form-item>
                    <el-form-item label="Kyc result">
                        <el-switch v-model="item.kycResult">
                        </el-switch>
                    </el-form-item>
                    <el-button type="danger" @click="removeInvestmentCreateRequest(index)">Remove</el-button>
                </div>
            </el-form-item> -->
        </el-form>
    </div>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;

    .inner-form {
        margin-bottom: 20px;

        .el-form-item {
            margin-bottom: 10px;
        }
    }

    .add-container {
        width: 100%;
    }
}
</style>