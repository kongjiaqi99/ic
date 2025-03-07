
<script setup lang="ts">
import { ArrowRight } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';
import { NotificationKey } from "@/symbols/notification"
import type { UploadUserFile } from 'element-plus'

interface RuleForm {
    isAll: boolean
    clientIdArr: any
    clientNameArr: any
    message: string
    title: string
    messageCn: string
    titleCn: string
    file: any
}

const { nId } = injectStrict(NotificationKey)
const loading = ref(false)
const lang = ref('en')

//回调方法
const { func } = injectStrict(PopupKey)

onMounted(() => {
    getClientList()
    if (nId.value) {
        // getEditEvent()
    }
})
const fileList = ref<UploadUserFile[]>([])
const clientList = ref([])
const ruleFormRef = ref<FormInstance>()
const ruleForm = reactive<RuleForm>({
    isAll: false,
    clientIdArr: [],
    clientNameArr: [],
    title: "",
    message: '',
    titleCn: "",
    messageCn: '',
    file: '',
})

const rules = reactive<FormRules<RuleForm>>({
    isAll: [
        { required: true, message: 'Please select client', trigger: 'change' }
    ],
    title: [
        { required: true, message: 'Please input title', trigger: 'blur', },
    ],
    message: [
        { required: true, message: 'Please input message', trigger: 'blur', },
    ],
    titleCn: [
        { required: true, message: '清输入中文标题', trigger: 'blur', },
    ],
    messageCn: [
        { required: true, message: '清输入中文消息', trigger: 'blur', },
    ]
})

const handleAddAdmin = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            console.log('submit!')
            // if (!ruleForm.isAll) {
            //     ruleForm.clientNameArr =
            // }
            ruleForm.file = fileList.value.length > 0 ? fileList.value[0].raw : ''
            loading.value = true
            if (!nId.value) {
                saveAdmin()
            } else {
                // editAdmin()
            }
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

async function saveAdmin() {
    let params = ruleForm
    const formData = new FormData()
    Object.keys(params).forEach(keys => {
        if (![null, undefined, ''].includes(params[keys])) {
            formData.append(keys, params[keys])
        }
    })
    const [e, r] = await api.createNotification(formData)
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

const handleChange = () => {
    if (ruleForm.isAll) {
        ruleForm.clientNameArr = []
        ruleForm.clientIdArr = []
    }
}

const handleSelectClient = (e) => {
    let array = []
    for (let i = 0; i < clientList.value.length; i++) {
        for (let j = 0; j < e.length; j++) {
            if (clientList.value[i].id === e[j]) {
                array.push(clientList.value[i].name)
            }
        }
    }
    ruleForm.clientNameArr = array
}

</script>

<template>
    <div class="pop-top">
        <div class="title">{{ !nId ? 'Create notification' : 'Edit notification' }}</div>
        <div v-loading="loading">
            <el-button type="primary" color="#4E9F1C" @click="handleAddAdmin(ruleFormRef)">
                {{ !nId ? 'New notification' : 'Edit notification' }}
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="200px" status-icon>
            <el-form-item label="Client" prop="isAll">
                <div class="flex-select">
                    <el-switch v-model="ruleForm.isAll" active-text="All" inactive-text="No" @change="handleChange" />
                    <el-select v-model="ruleForm.clientIdArr" multiple placeholder="Select" filterable style="width: 500px"
                        v-if="!ruleForm.isAll" @change="handleSelectClient">
                        <el-option v-for="item in clientList" :key="item.id" :label="item.name" :value="item.id" />
                    </el-select>
                </div>
            </el-form-item>
            <el-form-item label="Language">
                <el-radio-group v-model="lang">
                    <el-radio-button label="en"></el-radio-button>
                    <el-radio-button label="cn"></el-radio-button>
                </el-radio-group>
            </el-form-item>
            <div v-show="lang === 'en'">
                <el-form-item label="Title" prop="title">
                    <el-input v-model="ruleForm.title" />
                </el-form-item>
                <el-form-item label="Message" prop="message">
                    <el-input v-model="ruleForm.message" type="textarea" autosize />
                </el-form-item>
            </div>
            <div v-show="lang === 'cn'">
                <el-form-item label="标题" prop="titleCn">
                    <el-input v-model="ruleForm.titleCn" />
                </el-form-item>
                <el-form-item label="消息" prop="messageCn">
                    <el-input v-model="ruleForm.messageCn" type="textarea" autosize />
                </el-form-item>
            </div>
            <el-form-item label="File" prop="file">
                <el-upload v-model:file-list="fileList" :auto-upload="false" :limit="1" list-type="text">
                    <template #trigger>
                        <el-button type="primary">select file</el-button>
                    </template>
                </el-upload>
            </el-form-item>
        </el-form>
    </div>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;
}

.flex-select {
    display: flex;
    flex-direction: column;
}
</style>