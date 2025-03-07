<script setup lang="ts">
import { ArrowRight } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"
// import { isEmail } from "@/utils/validate";
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';
import dayjs from "dayjs";

import { ClientKey } from "@/symbols/client"

interface RuleForm {
    name: string
    countryCode: string
    mobile: string
    birth: string
    withheldTax: boolean
    tfNum: string
    bsb: string
    accountName: string
    accountNumber: string
    targetAmount: any
}
const router = useRouter()

const { cId } = injectStrict(ClientKey)
const loading = ref(false)

//回调方法
const { func } = injectStrict(PopupKey)

onMounted(async () => {
    if (cId.value) {
        getEditClient()
        queryEntity()
    }
})
const clientInfo = ref<AnyObj>({})
const entityList = ref([])
const centerDialogVisible = ref(false)

const ruleFormRef = ref<FormInstance>()
const ruleForm = reactive<RuleForm>({
    name: "",
    countryCode: "",
    mobile: "",
    birth: "",
    withheldTax: false,
    tfNum: '',
    bsb: "",
    accountName: "",
    accountNumber: "",
    targetAmount: '',
})

// const validateEmail = (rule: any, value: any, callback: any) => {
//     if (value === '') {
//         callback(new Error('Please input Email'))
//     } else if (!isEmail(value)) {
//         callback(new Error("Email format is incorrect!"))
//     } else {
//         callback()
//     }
// }

const rules = reactive<FormRules<RuleForm>>({
    // email: [
    //     { required: true, message: 'Please input Email', trigger: 'blur' },
    //     { validator: validateEmail, trigger: 'blur' },
    // ]
})

const handleAddClient = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            console.log('submit!')
            loading.value = true
            editClient()
        } else {
            ElMessage.error('Please enter correct content!')
            console.log('error submit!', fields)
        }
    })
}

async function editClient() {
    let params = { ...ruleForm, id: cId.value }
    const [e, r] = await api.editClient(params)
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

async function getEditClient() {
    let params = {
        id: cId.value
    }
    const [e, r] = await api.queryClientDetailById(params)
    if (!e && r) {
        console.log(r.data);
        clientInfo.value = r.data
        ruleForm.birth = dayjs(r.data?.birth).format("YYYY-MM-DD") || ""
        ruleForm.name = r.data?.name || ""
        ruleForm.countryCode = r.data?.countryCode || ""
        ruleForm.mobile = r.data?.mobile || ""
        ruleForm.withheldTax = r.data?.withheldTax || false
        ruleForm.tfNum = r.data?.tfNum || ""
        ruleForm.bsb = r.data?.bsb || ""
        ruleForm.accountName = r.data?.accountName || ""
        ruleForm.accountNumber = r.data?.accountNumber || ""
        ruleForm.targetAmount = r.data?.targetAmount || ""
    }
}

async function queryEntity() {
    let params = {
        id: cId.value
    }
    const [e, r] = await api.queryInvestmentEntityKycById(params)
    if (!e && r) {
        console.log(r?.data);
        // r.data[0].file1Front = 'https://fuss10.elemecdn.com/a/3f/3302e58f9a181d2509f3dc0fa68b0jpeg.jpeg'
        // r.data[0].file1Back = 'https://fuss10.elemecdn.com/a/3f/3302e58f9a181d2509f3dc0fa68b0jpeg.jpeg'
        // r.data[0].livePhoto = 'https://fuss10.elemecdn.com/a/3f/3302e58f9a181d2509f3dc0fa68b0jpeg.jpeg'
        entityList.value = r?.data || []
    }
}

const limitTargetAmount = () => {
    if (ruleForm.targetAmount > 999999.99) {
        ruleForm.targetAmount = 999999.99
    } else {
        ruleForm.targetAmount = ruleForm.targetAmount.replace(/^\./, '0.').match(/^\d*(\.?\d{0,2})/g)[0] || ''
    }
}

//删除Client
const handleShowDelClient = () => {
    centerDialogVisible.value = true
}

//删除管理员
const handleDelClient = async () => {
    const params = {
        id: clientInfo.value.id
    }
    const [e, r] = await api.delClient(params)
    if (!e && r) {
        if (r.data) {
            ElMessage.success('delete success')
        }
        centerDialogVisible.value = false
        router.push({ path: `/client/index` }).catch((err) => {
            console.warn(err)
        })
    }
}
</script>

<template>
    <div class="pop-top">
        <div>
            <div class="title">Edit Client</div>
            <div class="sub-title">Client ID: {{ clientInfo.id }}</div>
            <div class="sub-title">DOB: {{ dayjs(clientInfo?.birth || "").format('DD.MM.YYYY') }}</div>
        </div>
        <div v-loading="loading">
            <el-button type="primary" color="#4E9F1C" @click="handleAddClient(ruleFormRef)">
                Edit Client
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="200px" status-icon>
            <div class="table-title">Personal Information</div>
            <el-form-item label="Name" prop="name">
                <el-input v-model="ruleForm.name" />
            </el-form-item>
            <el-form-item label="Mobile number" prop="mobile">
                <el-input v-model="ruleForm.mobile" />
            </el-form-item>
            <el-form-item label="Country code" prop="countryCode">
                <el-input v-model="ruleForm.countryCode" />
            </el-form-item>
            <el-form-item label="Birth" prop="birth">
                <el-date-picker v-model="ruleForm.birth" type="date" format="YYYY-MM-DD" value-format="YYYY-MM-DD"
                    clearable>
                </el-date-picker>
            </el-form-item>
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
            <el-form-item label="Target amount" prop="targetAmount">
                <el-input v-model="ruleForm.targetAmount" type="number" @input="limitTargetAmount" />
            </el-form-item>

            <div class="block padding-t-20">
                <div class="table-title">Account Setting</div>
                <el-form-item label="Login Account">
                    {{ clientInfo.email }}
                    <!-- <el-input v-model="ruleForm.targetAmount" type="number" @input="limitTargetAmount" /> -->
                </el-form-item>
                <el-form-item size="small">
                    <el-link @click="handleShowDelClient">Delete Account</el-link>
                    <el-dialog v-model="centerDialogVisible" title="Message" width="30%" align-center>
                        <span>Are you sure to delete this?</span>
                        <template #footer>
                            <span class="dialog-footer">
                                <el-button @click="centerDialogVisible = false">Cancel</el-button>
                                <el-button type="primary" @click="handleDelClient">
                                    Confirm
                                </el-button>
                            </span>
                        </template>
                    </el-dialog>
                </el-form-item>
            </div>
            <div class="block padding-t-20">
                <!-- <div class="table-title">Commission Payment Records</div> -->
                <el-table :data="entityList" height="300" :row-style="{ height: '90px' }"
                    header-cell-class-name="table-sell-style" :cell-style="{ 'z-index': 'auto' }">
                    <el-table-column prop="entityType" label="Investor Type" :align="'center'" />
                    <el-table-column prop="entityName" label="Investor Name" :align="'center'" />
                    <el-table-column prop="kycResult" label="KYC Result" :align="'center'" />
                    <el-table-column prop="file1Front" label="Document 1 Front" :align="'center'">
                        <template #default="scope">
                            <div class="position">
                                <el-image style="width: 100px; height: 100px" :src="scope.row.file1Front"
                                    :preview-src-list="[scope.row.file1Front]" fit="contain" />
                            </div>
                        </template>
                    </el-table-column>
                    <el-table-column prop="file1Back" label="Document 1 Back" :align="'center'">
                        <template #default="scope">
                            <el-image style="width: 100px; height: 100px" :src="scope.row.file1Back"
                                :preview-src-list="[scope.row.file1Back]" fit="contain" />
                        </template>
                    </el-table-column>
                    <el-table-column prop="livePhoto" label="Live Photo" :align="'center'">
                        <template #default="scope">
                            <el-image style="width: 100px; height: 100px" :src="scope.row.file2Front"
                                :preview-src-list="[scope.row.file2Front]" fit="contain" />
                        </template>
                    </el-table-column>
                </el-table>
            </div>
        </el-form>
    </div>
</template>

<style lang="scss">
.form {
    padding: 20px;

    .block {
        border-top: 1px solid #DEDEDE;
    }

    .table-title {
        color: #4F4F4F;
        font-size: 16px;
        font-style: normal;
        font-weight: 600;
        padding-bottom: 15px;
    }

    .padding-t-20 {
        padding-top: 20px;
    }
}

.position {
    position: relative;
    z-index: 100;
}
</style>