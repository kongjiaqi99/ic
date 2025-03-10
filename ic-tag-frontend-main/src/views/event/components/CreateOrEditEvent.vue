
<script setup lang="ts">
import { ArrowRight, Plus } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"
import { Editor } from "@/components/index";
// import { isEmail } from "@/utils/validate";
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';
import type { UploadUserFile, UploadProps } from 'element-plus'
import dayjs from "dayjs"

import { EventKey } from "@/symbols/event"

interface RuleForm {
    type: string
    title: string
    startTime: string
    city: string
    location: string
    briefIntroduction: string
    language: string
    trans: string
    mainImg: any
    file: any
    link: string
    status?: string
}

const { eId } = injectStrict(EventKey)
const loading = ref(false)


//回调方法
const { func } = injectStrict(PopupKey)

onMounted(async () => {
    await getCityList()
    await getEventLanguage()
    await getEventTrans()
    if (eId.value) {
        getEditEvent2()
        getEditEvent()
    }
})

const cityList = ref([])
const eventType = ref([
    {
        value: 'Online',
        label: 'Online Event',
    },
    {
        value: 'Offline',
        label: 'Offline Event',
    },
    // {
    //     value: 'Sponsor',
    //     label: 'Sponsor event',
    // }
])
const languageOptions = ref([])
const transOptions = ref([])
const imageList = ref<UploadUserFile[]>([])
const fileList = ref<UploadUserFile[]>([])
const ruleFormRef = ref<FormInstance>()
const dialogImageUrl = ref('')
const dialogVisible = ref(false)
const imageShowList = ref('')
const ruleForm = reactive<RuleForm>({
    type: '',
    title: '',
    startTime: '',
    city: '',
    location: '',
    briefIntroduction: '',
    language: '',
    trans: '',
    mainImg: '',
    file: '',
    link: '',
})

const validateImg = (rule: any, value: any, callback: any) => {
    if (imageList.value.length <= 0 && !eId.value) {
        callback(new Error('Please select a picture'))
    } else {
        callback()
    }
}

const rules = reactive<FormRules<RuleForm>>({
    type: [
        { required: true, message: 'Please select Event Type', trigger: 'change' },
    ],
    title: [
        { required: true, message: 'Please input title', trigger: 'blur', },
    ],
    startTime: [
        { required: true, message: 'Please pick a Start Time', trigger: 'change' }
    ],
    city: [
        { required: true, message: 'Please pick a city', trigger: 'change' }
    ],
    location: [
        { required: true, message: 'Please input location', trigger: 'blur', },
    ],
    language: [
        { required: true, message: 'Please pick a language', trigger: 'change', },
    ],
    mainImg: [
        { required: !eId.value ? true : false, validator: validateImg, trigger: 'blur' }
    ]
})

const handleAddEvent = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            ruleForm.mainImg = imageList.value.length > 0 ? imageList.value[0].raw : ''
            ruleForm.file = fileList.value.length > 0 ? fileList.value[0].raw : ''
            console.log('submit!', ruleForm)
            loading.value = true
            if (!eId.value) {
                saveEvent()
            } else {
                editEvent()
            }
        } else {
            ElMessage.error('Please enter correct content!')
            console.log('error submit!', fields)
        }
    })
}

async function getCityList() {
    let params = { type: 'event_city' }
    const [e, r] = await api.queryDictionary(params)
    if (!e && r) {
        cityList.value = r?.data || []
    }
}

async function getEventLanguage() {
    let query = {
        type: 'language'
    }
    const [e, r] = await api.queryDictionary(query)
    if (!e && r) {
        languageOptions.value = r?.data || []
    } else {
        console.log(e);
    }
}

async function getEventTrans() {
    let query = {}
    const [e, r] = await api.queryEventTrans(query)
    if (!e && r) {
        transOptions.value = r?.data || []
    } else {
        console.log(e);
    }

}

async function saveEvent() {
    let params = ruleForm
    const formData = new FormData()
    Object.keys(params).forEach(keys => {
        if (![null, undefined, ''].includes(params[keys])) {
            formData.append(keys, params[keys])
        }
    })
    const [e, r] = await api.createEvent(formData)
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

async function editEvent() {
    let params = { ...ruleForm, id: eId.value }
    const formData = new FormData()
    Object.keys(params).forEach(keys => {
        if (![null, undefined, ''].includes(params[keys])) {
            formData.append(keys, params[keys])
        }
    })
    const [e, r] = await api.editEvent(formData)
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

async function getEditEvent() {
    let params = {
        id: eId.value
    }
    const [e, r] = await api.queryEventByIdWhenEdit(params)
    // const [e, r] = await api.queryEventById(params)
    if (!e && r) {
        console.log(r?.data);

        if (r.data?.city) {
            const cityItem = cityList.value.find((i: AnyObj) => {
                return i.code === r.data?.city
            })
            ruleForm.city = cityItem.value || ""
        }
        if (r.data?.language) {
            const item = languageOptions.value.find((i: AnyObj) => {
                return i.code.toLowerCase() === r.data?.language.toLowerCase()
            })
            ruleForm.language = item.value || ""
        }
        ruleForm.title = r.data?.title || ""
        ruleForm.type = r.data?.type || ""
        ruleForm.startTime = dayjs(r.data?.startTime).format("YYYY-MM-DD HH:mm:ss") || ""
        ruleForm.location = r.data?.location || ""
        ruleForm.briefIntroduction = r.data?.briefIntroduction || ""
        ruleForm.trans = r.data?.transId || ""
        ruleForm.link = r.data?.link || ""
        ruleForm.status = r.data?.status || ""
    }
}

async function getEditEvent2() {
    let params = {
        id: eId.value
    }
    // const [e, r] = await api.queryEventByIdWhenEdit(params)
    const [e, r] = await api.queryEventById(params)
    if (!e && r) {
        imageShowList.value = r.data?.mainImg || ""
    }
}

//editor输入回调
const onSuccess = (str: string) => {
    ruleForm.briefIntroduction = str

}

const handlePictureCardPreview: UploadProps['onPreview'] = (uploadFile) => {
    dialogImageUrl.value = uploadFile.url!
    dialogVisible.value = true
}

const handleRemove = () => {
    // console.log(fileList);
    imageShowList.value = ''
}

const handleChange: UploadProps['onChange'] = (uploadFile) => {
    // console.log(uploadFile);
    imageShowList.value = URL.createObjectURL(uploadFile.raw!)
    // fileList.value = fileList.value.slice(-3)
    // imageShowList.value = URL.createObjectURL(imageList.value[0].raw!)

}
</script>

<template>
    <div class="pop-top">
        <div class="title">{{ !eId ? 'Create Event' : 'Edit Event' }}</div>
        <div v-loading="loading">
            <el-button type="primary" color="#4E9F1C" @click="handleAddEvent(ruleFormRef)">
                {{ !eId ? 'New Event' : 'Edit Event' }}
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="200px" status-icon>
            <el-form-item label="Event Type" prop="type">
                <el-select v-model="ruleForm.type" placeholder="Event Type">
                    <el-option :label="item.label" :value="item.value" v-for="(item, index) in eventType" :key="index" />
                </el-select>
            </el-form-item>
            <el-form-item label="Title" prop="title">
                <el-input v-model="ruleForm.title" placeholder="Please input title" />
            </el-form-item>
            <el-form-item label="Start Time" prop="startTime">
                <el-date-picker v-model="ruleForm.startTime" type="datetime" format="YYYY-MM-DD HH:mm:ss"
                    value-format="YYYY-MM-DD HH:mm:ss">
                </el-date-picker>
            </el-form-item>
            <el-form-item label="City" prop="city">
                <el-select v-model="ruleForm.city" placeholder="City" clearable filterable>
                    <el-option :label="item.code" :value="item.value" v-for="(item, index) in cityList" :key="index" />
                </el-select>
            </el-form-item>
            <el-form-item label="Location" prop="location">
                <el-input v-model="ruleForm.location" />
            </el-form-item>
            <el-form-item label="Language" prop="language">
                <el-select v-model="ruleForm.language" placeholder="Language">
                    <el-option :label="item.code" :value="item.value" v-for="(item, index) in languageOptions"
                        :key="index" />
                </el-select>
            </el-form-item>
            <el-form-item label="Upload Image" prop="mainImg">
                <div class="detail-img" v-if="imageShowList">
                    <img :src="imageShowList" />
                </div>
                <el-upload v-model:file-list="imageList" :auto-upload="false" :limit="1" list-type="picture-card"
                    accept="image/*" :on-preview="handlePictureCardPreview" :on-remove="handleRemove"
                    :on-change="handleChange">
                    <el-icon>
                        <Plus />
                    </el-icon>
                </el-upload>
            </el-form-item>
            <el-form-item label="Brief Introduction" prop="briefIntroduction">
                <Editor :detail="ruleForm.briefIntroduction" @onSuccess="onSuccess"></Editor>
            </el-form-item>
            <el-form-item label="File" prop="file">
                <el-upload v-model:file-list="fileList" :auto-upload="false" :limit="1" list-type="text">
                    <template #trigger>
                        <el-button type="primary">select file</el-button>
                    </template>
                </el-upload>
            </el-form-item>
            <el-form-item label="Link" prop="link">
                <el-input v-model="ruleForm.link">
                    <!-- <template #prepend>Http://</template> -->
                </el-input>
            </el-form-item>
            <!-- <el-form-item label="Trans" prop="trans">
                <el-select v-model="ruleForm.trans" placeholder="Trans" clearable filterable>
                    <el-option :label="item.title" :value="item.id" v-for="(item, index) in transOptions" :key="index" />
                </el-select>
            </el-form-item> -->
        </el-form>
    </div>
    <el-dialog v-model="dialogVisible">
        <img class="img" :src="dialogImageUrl" alt="Preview Image" />
    </el-dialog>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;
}

.img {
    width: 100%;
    height: 100%;
}

.detail-img {
    width: 134px;
    height: 166px;
    border-radius: 11px;
    overflow: hidden;
    margin-right: 20px;

    img {
        width: 134px;
        height: 166px;
    }
}
</style>