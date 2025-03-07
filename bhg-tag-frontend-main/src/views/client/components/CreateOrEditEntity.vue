<script setup lang="ts">
import { ArrowRight, CirclePlus, CircleClose, Document } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"
// import { isEmail } from "@/utils/validate";
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';

import { EntityKey } from "@/symbols/client"
import type { UploadUserFile } from 'element-plus'


interface RuleForm {
    addressLine: string
    bhgId: string
    emailList: any[]
    entityName: string
    suburb: string
    state: string
    postcode: string
    entityType: string
    accountName: string
    accountNumber: string
    tfNum: string
    withheldTax: string
    bsb: string
    applicationFormList: any[]
    applicationFormSigned: any
    applicationFormSignedTwo: any
    applicationFormSignedThree: any
    applicationFormSignedFour: any
    applicationFormSignedFile: any
    applicationFormSignedFileTwo: any
    applicationFormSignedFileThree: any
    applicationFormSignedFileFour: any
}

const { eId, clientInfo, entityInfo } = injectStrict(EntityKey)

//回调方法
const { func } = injectStrict(PopupKey)
const loading = ref(false)

//上传需要参数
const headers = {
    'Content-Type': 'multipart/form-data'
}

const jsonData = {
    entityId: 1,
    fundId: 1
}
const investorTypeList = ref([])
const applicationFormSignedFileList = ref<UploadUserFile[]>([])
const applicationFormSignedFileList2 = ref<UploadUserFile[]>([])
const applicationFormSignedFileList3 = ref<UploadUserFile[]>([])
const applicationFormSignedFileList4 = ref<UploadUserFile[]>([])
const ruleFormRef = ref<FormInstance>()
const ruleForm = reactive<RuleForm>({
    addressLine: "",
    bhgId: "",
    emailList: [],
    entityName: "",
    suburb: "",
    state: "",
    postcode: "",
    entityType: "",
    accountName: "",
    accountNumber: "",
    tfNum: "",
    withheldTax: "",
    bsb: "",
    applicationFormList: [],
    applicationFormSigned: undefined,
    applicationFormSignedTwo: undefined,
    applicationFormSignedThree: undefined,
    applicationFormSignedFour: undefined,
    applicationFormSignedFile: undefined,
    applicationFormSignedFileTwo: undefined,
    applicationFormSignedFileThree: undefined,
    applicationFormSignedFileFour: undefined,
})

const rules = reactive<FormRules<RuleForm>>({
    entityName: [
        { required: true, message: 'Please input Entity Name', trigger: 'blur' },
    ],
    bhgId: [
        { required: true, message: 'Please input BHG ID', trigger: 'blur' },
    ],
    suburb: [
        { required: true, message: 'Please input Suburb', trigger: 'blur' },
    ],
    addressLine: [
        { required: true, message: 'Please input Address line', trigger: 'blur' },
    ],
    state: [
        { required: true, message: 'Please input State', trigger: 'blur' },
    ],
    entityType: [
        { required: true, message: 'Please select Investor Type', trigger: 'change' },
    ],
    postcode: [
        { required: true, message: 'Please input Postcode', trigger: 'blur' },
    ],
    emailList: [
        { type: 'array', required: true, message: 'Please input email', trigger: 'blur' },
    ],
})

onMounted(async () => {
    const emailList = [{ email: clientInfo.value.email }]
    ruleForm.emailList = emailList
    await queryInvestmentEnTity()
    if (eId.value) {
        getEditEntity()
    }
})

const handleAddClient = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            console.log('submit!')
            // if (applicationFormSignedFileList.value.length > 0) {
            //     ruleForm.applicationFormSignedFile = applicationFormSignedFileList.value[0].raw
            // } else {
            //     ruleForm.applicationFormSigned = entityInfo.value?.applicationFormSigned
            // }
            // if (applicationFormSignedFileList2.value.length > 0) {
            //     ruleForm.applicationFormSignedFileTwo = applicationFormSignedFileList2.value[0].raw
            // } else {
            //     ruleForm.applicationFormSignedTwo = entityInfo.value?.applicationFormSignedTwo
            // }
            // if (applicationFormSignedFileList3.value.length > 0) {
            //     ruleForm.applicationFormSignedFileThree = applicationFormSignedFileList3.value[0].raw
            // } else {
            //     ruleForm.applicationFormSignedThree = entityInfo.value?.applicationFormSignedThree
            // }
            // if (applicationFormSignedFileList4.value.length > 0) {
            //     ruleForm.applicationFormSignedFileFour = applicationFormSignedFileList4.value[0].raw
            // } else {
            //     ruleForm.applicationFormSignedFour = entityInfo.value?.applicationFormSignedFour
            // }
            loading.value = true
            if (!eId.value) {
                saveEntity()
            } else {
                editEntity()
            }
        } else {
            ElMessage.error('Please enter correct content!')
            console.log('error submit!', fields)
        }
    })
}

async function queryInvestmentEnTity() {
    let params = { type: 'investment_entity_type' }
    const [e, r] = await api.queryDictionary(params)
    if (!e && r) {
        investorTypeList.value = r?.data || []
    }
}


async function saveEntity() {
    let params = { ...ruleForm, clientId: clientInfo.value.id }
    const list = ruleForm.emailList.map(item => {
        return item.email
    })
    params.emailList = list
    let formData = new FormData()
    Object.keys(params).forEach(keys => {
        // console.log(keys);
        if (keys === 'emailList') {
            ruleForm.emailList.forEach((value, index) => {
                formData.append(`emailList[${index}]`, value.email);
            });
        } else if (keys === 'applicationFormList') {
            ruleForm.applicationFormList.forEach((value, index) => {
                formData.append(`applicationFormList[${index}]`, value.url);
            });
        }
        else {
            if (![null, undefined].includes(params[keys])) {
                formData.append(keys, params[keys])
            }
        }
    })
    const [e, r] = await api.createEntity(formData)
    loading.value = false
    if (!e && r) {
        if (r.success) {
            ElMessage.success('Created successfully')
            setTimeout(() => {
                func('entity')
            }, 1000)
        }
    }
}

async function editEntity() {
    let params = { ...ruleForm, id: eId.value, clientId: clientInfo.value.id }
    const list = ruleForm.emailList.map(item => {
        return item.email
    })
    params.emailList = list
    console.log(params);

    let formData = new FormData()
    Object.keys(params).forEach(keys => {
        // console.log(keys);
        if (keys === 'emailList') {
            ruleForm.emailList.forEach((value, index) => {
                formData.append(`emailList[${index}]`, value.email);
            });
        } else if (keys === 'applicationFormList') {
            if (ruleForm.applicationFormList.length > 0) {
                ruleForm.applicationFormList.forEach((value, index) => {
                    formData.append(`applicationFormList[${index}]`, value.url);
                });
            } else {
                formData.append(`applicationFormList`, "");
            }

        } else {
            if (![null, undefined].includes(params[keys])) {
                formData.append(keys, params[keys])
            }
        }
    })
    const [e, r] = await api.editEntity(formData)
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

function getEditEntity() {
    console.log(entityInfo.value);
    if (entityInfo.value.emailList.length > 0) {
        const list = entityInfo.value.emailList.map(item => {
            return { email: item }
        })
        ruleForm.emailList = list
    }
    if (entityInfo.value.entityType) {
        const item = investorTypeList.value.find((i: AnyObj) => {
            return i.code.toUpperCase() === entityInfo.value.entityType.replace('_', ' ').toUpperCase()
        })
        ruleForm.entityType = item?.value || ""
    }
    ruleForm.addressLine = entityInfo.value.addressLine
    ruleForm.bhgId = entityInfo.value.bhgId
    ruleForm.entityName = entityInfo.value.entityName
    ruleForm.suburb = entityInfo.value.suburb
    ruleForm.state = entityInfo.value.state
    ruleForm.postcode = entityInfo.value.postcode
    ruleForm.accountName = entityInfo.value.accountName
    ruleForm.accountNumber = entityInfo.value.accountNumber
    ruleForm.tfNum = entityInfo.value.tfNum
    ruleForm.withheldTax = entityInfo.value.withheldTax
    ruleForm.bsb = entityInfo.value.bsb || ""
    if (entityInfo.value.applicationFormList) {
        let list = []
        for (let i = 0; i < entityInfo.value.applicationFormList.length; i++) {
            let lastOf = entityInfo.value.applicationFormList[i].lastIndexOf('/') // '/'所在的最后位置
            var str = entityInfo.value.applicationFormList[i].substr(lastOf + 1)
            let params = {
                name: str,
                url: entityInfo.value.applicationFormList[i]
            }
            list.push(params)
        }
        ruleForm.applicationFormList = list
    }
}

const handleAddEmail = () => {
    ruleForm.emailList.push({
        email: '',
    })
}

const handleDelEmail = (index) => {
    ruleForm.emailList.splice(index, 1)
}

//上传成功回调
const uploadFileSuccess = (response) => {
    const length = ruleForm.applicationFormList.length - 1
    ruleForm.applicationFormList[length].url = response?.data || ''
}

const handlePictureCardPreview = (uploadFile) => {
    console.log(uploadFile);
    if (uploadFile?.url) {
        window.open(uploadFile?.url, '_blank')
    }
}

//删除成功回调
const handleRemove = () => {
    console.log(ruleForm.applicationFormList);
}
</script>

<template>
    <div class="pop-top">
        <div class="title">{{ !eId ? 'Create Entity' : 'Edit Entity' }}</div>
        <div v-loading="loading">
            <el-button type="primary" color="#4E9F1C" @click="handleAddClient(ruleFormRef)">
                {{ !eId ? 'Create Entity' : 'Edit Entity' }}
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="200px" status-icon>
            <el-form-item label="BHG ID" prop="bhgId">
                <el-input v-model="ruleForm.bhgId" />
            </el-form-item>
            <el-form-item label="Investor Type" prop="entityType">
                <el-select v-model="ruleForm.entityType" placeholder="Select Investor Type">
                    <el-option :label="item.code" :value="item.value" v-for="(item, index) in investorTypeList"
                        :key="index" />
                </el-select>
            </el-form-item>
            <el-form-item label="Entity Name" prop="entityName">
                <el-input v-model="ruleForm.entityName" />
            </el-form-item>
            <el-form-item label="Email" prop="emailList">
                <div class="email-list">
                    <div v-for="(item, index) in ruleForm.emailList" :key="index">
                        <div class="flex" v-if="index === 0">
                            <el-input v-model="item.email" :disabled="true" />
                            <el-icon class="pointer" color="#4E9F1C" size="20" @click="handleAddEmail">
                                <CirclePlus />
                            </el-icon>
                        </div>
                        <div class="flex" v-else>
                            <el-input v-model="item.email" />
                            <el-icon class="pointer" color="#E92C2C" size="20" @click="handleDelEmail(index)">
                                <CircleClose />
                            </el-icon>
                        </div>
                    </div>
                </div>
            </el-form-item>
            <el-form-item label="Address line" prop="addressLine">
                <el-input v-model="ruleForm.addressLine" />
            </el-form-item>
            <el-form-item label="Suburb" prop="suburb">
                <el-input v-model="ruleForm.suburb" />
            </el-form-item>
            <el-form-item label="State" prop="state">
                <el-input v-model="ruleForm.state" />
            </el-form-item>
            <el-form-item label="Postcode" prop="postcode">
                <el-input v-model="ruleForm.postcode" />
            </el-form-item>
            <el-form-item label="Bsb" prop="bsb">
                <el-input v-model="ruleForm.bsb" />
            </el-form-item>
            <el-form-item label="Account Name" prop="accountName">
                <el-input v-model="ruleForm.accountName" />
            </el-form-item>
            <el-form-item label="Account Number" prop="accountNumber">
                <el-input v-model="ruleForm.accountNumber" />
            </el-form-item>
            <el-form-item label="TFN" prop="tfNum">
                <el-input v-model="ruleForm.tfNum" />
            </el-form-item>
            <el-form-item label="withheldTax" prop="withheldTax">
                <el-switch v-model="ruleForm.withheldTax" active-text="Yes" inactive-text="No" />
            </el-form-item>
            <el-form-item label="Application form signed" prop="applicationFormList">
                <div class="application">
                    <el-upload v-model:file-list="ruleForm.applicationFormList"
                        action="https://portal.bhgglobal.com.au/api/v1/investment/upload" :data="jsonData" name="file"
                        :auto-upload="true" list-type="text" :on-preview="handlePictureCardPreview"
                        :on-remove="handleRemove" :on-success="uploadFileSuccess">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
                    </el-upload>
                </div>
            </el-form-item>
            <!-- <el-form-item label="Application form signed1" prop="applicationFormSignedFile">
                <el-upload v-model:file-list="applicationFormSignedFileList" :auto-upload="false" :limit="1"
                    list-type="text">
                    <template #trigger>
                        <el-button type="primary">Choose file</el-button>
                    </template>
                </el-upload>
            </el-form-item>
            <el-form-item label="" v-if="entityInfo?.applicationFormSigned">
                <a :href="entityInfo?.applicationFormSigned" v-if="entityInfo?.applicationFormSigned" target="_blank">
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
            <el-form-item label="" v-if="entityInfo?.applicationFormSignedTwo">
                <a :href="entityInfo?.applicationFormSignedTwo" v-if="entityInfo?.applicationFormSignedTwo"
                    target="_blank">
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
            <el-form-item label="" v-if="entityInfo?.applicationFormSignedThree">
                <a :href="entityInfo?.applicationFormSignedThree" v-if="entityInfo?.applicationFormSignedThree"
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
            <el-form-item label="" v-if="entityInfo?.applicationFormSignedFour">
                <a :href="entityInfo?.applicationFormSignedFour" v-if="entityInfo?.applicationFormSignedFour"
                    target="_blank">
                    <el-icon size="24" class="color-web">
                        <Document />
                    </el-icon>
                </a>
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

.email-list {
    display: flex;
    flex-wrap: wrap;
    flex-direction: column;
    gap: 10px;
}

.flex {
    display: flex;
    align-items: center;
    gap: 10px;
}

.application {
    width: 400px;
}
</style>