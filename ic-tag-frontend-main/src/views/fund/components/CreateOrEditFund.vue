<script setup lang="ts">
import { ArrowRight, Plus, Check, Close, Document, CircleClose, Delete } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';
import type { UploadUserFile, UploadProps } from 'element-plus'
import dayjs from "dayjs"
import { FundKey } from "@/symbols/fund"
import TagsGroup from './TagsGroup.vue';

interface RuleForm {
    language: any
    name: string
    nameCN: string
    fundStatus: any
    description: string
    descriptionCN: string
    amount: string
    currency: string
    currencyCN: string
    fundType: string
    fundTypeCN: string
    investmentType: string
    investmentTypeCN: string
    productType: string
    productTypeCN: string
    bfundCategory: any
    byearlyReturnRate: string
    bprojectDurationMonth: string
    settlementDate: string
    interestStartsDate: string
    applicationFeeRate: string
    managementFeeRate: string
    imFilePath: any
    subImDate: string
    deedDate: string
    subImFilePath: any
    introduceFilePath: any
    eoiFilePath: any
    reportFilePath: any
    additionalInvestmentFile: any
    constitutionFile: any
    applicationForm: any
    purchaseMinAmount: string
    endDate: string
    cover: any
    coverTwo: any
    coverThree: any
    coverFour: any
    coverCn: any
    coverCnThree: any
    coverCnTwo: any
    coverCnFour: any
    coverFile: any
    coverFileTwo: any
    coverFileThree: any
    coverFileFour: any
    coverCnFile: any
    coverCnFileTwo: any
    coverCnFileThree: any
    coverCnFileFour: any

    popular: number
    stateCn: string
    stateEn: string
    stateId: string
    extendStartDate: string
    defaultStartDate: string
    bdelayedGrowthRate: string

    updateImFilePath: any
    updateSubImFilePath: any
    updateIntroduceFilePath: any
    updateEoiFilePath: any
    updateReportFilePath: any
    updateAdditionalInvestmentFile: any
    updateConstitutionFile: any
    updateApplicationForm: any

    company: string
}

const imageListEn1 = ref<UploadUserFile[]>([])
const imageListEn2 = ref<UploadUserFile[]>([])
const imageListEn3 = ref<UploadUserFile[]>([])
const imageListEn4 = ref<UploadUserFile[]>([])

const imageListCn1 = ref<UploadUserFile[]>([])
const imageListCn2 = ref<UploadUserFile[]>([])
const imageListCn3 = ref<UploadUserFile[]>([])
const imageListCn4 = ref<UploadUserFile[]>([])

const imFileList = ref<UploadUserFile[]>([])
const subImFileList = ref<UploadUserFile[]>([])
const introduceFileList = ref<UploadUserFile[]>([])
const eoiFileList = ref<UploadUserFile[]>([])
const reportFileList = ref<UploadUserFile[]>([])
const additionalInvestmentFileList = ref<UploadUserFile[]>([])
const constitutionFileList = ref<UploadUserFile[]>([])
const applicationFormFileList = ref<UploadUserFile[]>([])
const imageShowListEn = ref('')
const imageShowListCn = ref('')
const imageShowList2En = ref('')
const imageShowList2Cn = ref('')
const imageShowList3En = ref('')
const imageShowList3Cn = ref('')
const imageShowList4En = ref('')
const imageShowList4Cn = ref('')
const fundInfo = ref<AnyObj>({})

const { fId } = injectStrict(FundKey)
const loading = ref(false)

const tagsGroup = ref(null)
const currentTag = ref<AnyObj>({})
const addedTag = ref<AnyObj>({});
//回调方法
const { func } = injectStrict(PopupKey)

onMounted(async () => {
    await getLanguage()
    await getFundStatus()
    await getFundCategory()
    await getLocation()
    if (fId.value) {
        getEditFund()
        getEditFund2()
        getFundTags()
    }
})
const languageOptions = ref([])
const fundStatusList = ref([])
const fundCategory = ref([])
const fundLocation = ref([])
const dialogImageUrl = ref('')
const dialogVisible = ref(false)
const ruleFormRef = ref<FormInstance>()
const ruleForm = reactive<RuleForm>({
    popular: 0,
    language: '1',
    name: null,
    nameCN: null,
    fundStatus: null,
    description: null,
    descriptionCN: null,
    amount: null,
    currency: null,
    currencyCN: null,
    fundType: null,
    fundTypeCN: null,
    investmentType: null,
    investmentTypeCN: null,
    productType: null,
    productTypeCN: null,
    bfundCategory: null,
    byearlyReturnRate: null,
    bprojectDurationMonth: null,
    settlementDate: null,
    interestStartsDate: null,
    applicationFeeRate: null,
    managementFeeRate: null,
    subImDate: null,
    deedDate: null,

    imFilePath: null,
    subImFilePath: null,
    introduceFilePath: null,
    eoiFilePath: null,
    reportFilePath: null,
    additionalInvestmentFile: null,
    constitutionFile: null,
    applicationForm: null,

    updateImFilePath: null,
    updateSubImFilePath: null,
    updateIntroduceFilePath: null,
    updateEoiFilePath: null,
    updateReportFilePath: null,
    updateAdditionalInvestmentFile: null,
    updateConstitutionFile: null,
    updateApplicationForm: null,

    purchaseMinAmount: "",
    endDate: '',

    cover: undefined,
    coverTwo: undefined,
    coverThree: undefined,
    coverFour: undefined,
    coverCn: undefined,
    coverCnThree: undefined,
    coverCnTwo: undefined,
    coverCnFour: undefined,

    coverFile: undefined,
    coverFileTwo: undefined,
    coverFileThree: undefined,
    coverFileFour: undefined,
    coverCnFile: undefined,
    coverCnFileTwo: undefined,
    coverCnFileThree: undefined,
    coverCnFileFour: undefined,

    stateCn: '',
    stateEn: '',
    stateId: '',
    extendStartDate: '',
    defaultStartDate: '',
    bdelayedGrowthRate: '',
    company: '',
})

const validateImg = (rule: any, value: any, callback: any) => {
    if (imageListEn1.value.length <= 0 && !fId.value && ruleForm.language === '1') {
        callback(new Error('Please select a picture'))
    } else {
        callback()
    }
}

const validateImg2 = (rule: any, value: any, callback: any) => {
    if (imageListCn1.value.length <= 0 && !fId.value && ruleForm.language === '0') {
        callback(new Error('Please select a picture'))
    } else {
        callback()
    }
}

const rules = reactive<FormRules<RuleForm>>({
    name: [
        { required: true, message: 'Please input name', trigger: 'blur', },
    ],
    // nameCN: [
    //     { required: true, message: '请输入基金名称', trigger: 'blur', },
    // ],
    fundStatus: [
        { required: true, message: 'Please select Fund Status', trigger: 'change', },
    ],
    bfundCategory: [
        { required: true, message: 'Please select B Fund Category', trigger: 'change', },
    ],
    stateId: [
        { required: true, message: 'Please select Location', trigger: 'change', },
    ],
    byearlyReturnRate: [
        { required: true, message: 'Please input B yearly return rate', trigger: 'blur', },
    ],
    bprojectDurationMonth: [
        { required: true, message: 'Please input B project duration month', trigger: 'blur', },
    ],
    settlementDate: [
        { required: true, message: 'Please select Settlement date', trigger: 'change', }
    ],
    interestStartsDate: [
        { required: true, message: 'Please select Interest start date', trigger: 'change', }
    ],
    purchaseMinAmount: [
        { required: true, message: 'Please input Minimum Required Investment Amount', trigger: 'blur', },
    ],
    coverFile: [
        { required: !fId.value ? true : false, validator: validateImg, trigger: 'blur' }
    ],
    coverCnFile: [
        { required: !fId.value ? true : false, validator: validateImg2, trigger: 'blur' }
    ]
})

async function getLanguage() {
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

async function getFundStatus() {
    let query = {
        type: 'fund_status'
    }
    const [e, r] = await api.queryDictionary(query)
    if (!e && r) {
        fundStatusList.value = r?.data || []
    } else {
        console.log(e);
    }
}

async function getFundCategory() {
    let query = {
        type: 'fund_category'
    }
    const [e, r] = await api.queryDictionary(query)
    if (!e && r) {
        fundCategory.value = r?.data || []
    } else {
        console.log(e);
    }
}

async function getLocation() {
    let query = {
        type: 'state'
    }
    const [e, r] = await api.queryDictionary(query)
    if (!e && r) {
        console.log("🚀 ~ getLocation ~ r:", r?.data)
        fundLocation.value = r?.data || []
    } else {
        console.log(e);
    }
}

async function getFundTags() {
    let params = {
        fundId: fId.value
    }

    const [e, r] = await api.getFundTagsDetail({}, params)
    if (!e && r) {
        const data: any = r || {}
        if (data?.id) {
            addedTag.value = {
                tagId: data.id,
                name: data.name,
                abn: data.abn
            }
            currentTag.value = JSON.parse(JSON.stringify(addedTag.value))
            tagsGroup.value.setTag(addedTag.value)
        }
    }
}

const handleAddFund = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            if (imageListEn1.value.length > 0) {
                ruleForm.coverFile = imageListEn1.value[0].raw
            } else {
                ruleForm.cover = imageShowListEn.value
            }
            if (imageListEn2.value.length > 0) {
                ruleForm.coverFileTwo = imageListEn2.value[0].raw
            } else {
                ruleForm.coverTwo = imageShowList2En.value
            }
            if (imageListEn3.value.length > 0) {
                ruleForm.coverFileThree = imageListEn3.value[0].raw
            } else {
                ruleForm.coverThree = imageShowList3En.value
            }
            if (imageListEn4.value.length > 0) {
                ruleForm.coverFileFour = imageListEn4.value[0].raw
            } else {
                ruleForm.coverFour = imageShowList4En.value
            }
            if (imageListCn1.value.length > 0) {
                ruleForm.coverCnFile = imageListCn1.value[0].raw
            } else {
                ruleForm.coverCn = imageShowListCn.value
            }
            if (imageListCn2.value.length > 0) {
                ruleForm.coverCnFileTwo = imageListCn2.value[0].raw
            } else {
                ruleForm.coverCnTwo = imageShowList2Cn.value
            }
            if (imageListCn3.value.length > 0) {
                ruleForm.coverCnFileThree = imageListCn3.value[0].raw
            } else {
                ruleForm.coverCnThree = imageShowList3Cn.value
            }
            if (imageListCn4.value.length > 0) {
                ruleForm.coverCnFileFour = imageListCn4.value[0].raw
            } else {
                ruleForm.coverCnFour = imageShowList4Cn.value
            }

            if (imFileList.value.length > 0) {
                ruleForm.imFilePath = imFileList.value[0].raw
            } else {
                if (fundInfo.value?.imFilePath) {
                    ruleForm.updateImFilePath = fundInfo.value?.imFilePath
                }
            }
            if (subImFileList.value.length > 0) {
                ruleForm.subImFilePath = subImFileList.value[0].raw
            } else {
                if (fundInfo.value?.subImFilePath) {
                    ruleForm.updateSubImFilePath = fundInfo.value?.subImFilePath
                }
            }
            if (introduceFileList.value.length > 0) {
                ruleForm.introduceFilePath = introduceFileList.value[0].raw
            } else {
                if (fundInfo.value?.introduceFilePath) {
                    ruleForm.updateIntroduceFilePath = fundInfo.value?.introduceFilePath
                }
            }
            if (eoiFileList.value.length > 0) {
                ruleForm.eoiFilePath = eoiFileList.value[0].raw
            } else {
                if (fundInfo.value?.eoiFilePath) {
                    ruleForm.updateEoiFilePath = fundInfo.value?.eoiFilePath
                }
            }
            if (reportFileList.value.length > 0) {
                ruleForm.reportFilePath = reportFileList.value[0].raw
            } else {
                if (fundInfo.value?.reportFilePath) {
                    ruleForm.updateReportFilePath = fundInfo.value?.reportFilePath
                }
            }
            if (additionalInvestmentFileList.value.length > 0) {
                ruleForm.additionalInvestmentFile = additionalInvestmentFileList.value[0].raw
            } else {
                if (fundInfo.value?.additionalInvestmentFile) {
                    ruleForm.updateAdditionalInvestmentFile = fundInfo.value?.additionalInvestmentFile
                }
            }
            if (constitutionFileList.value.length > 0) {
                ruleForm.constitutionFile = constitutionFileList.value[0].raw
            } else {
                if (fundInfo.value?.constitutionFile) {
                    ruleForm.updateConstitutionFile = fundInfo.value?.constitutionFile
                }
            }
            if (applicationFormFileList.value.length > 0) {
                ruleForm.applicationForm = applicationFormFileList.value[0].raw
            } else {
                if (fundInfo.value?.applicationForm) {
                    ruleForm.updateApplicationForm = fundInfo.value?.applicationForm
                }
            }
            // ruleForm.imFilePath = imFileList.value.length > 0 ? imFileList.value[0].raw : fundInfo.value?.imFilePath
            // ruleForm.subImFilePath = subImFileList.value.length > 0 ? subImFileList.value[0].raw : fundInfo.value?.subImFilePath
            // ruleForm.introduceFilePath = introduceFileList.value.length > 0 ? introduceFileList.value[0].raw : fundInfo.value?.introduceFilePath
            // ruleForm.eoiFilePath = eoiFileList.value.length > 0 ? eoiFileList.value[0].raw : fundInfo.value?.eoiFilePath
            // ruleForm.reportFilePath = reportFileList.value.length > 0 ? reportFileList.value[0].raw : fundInfo.value?.reportFilePath
            // ruleForm.additionalInvestmentFile = additionalInvestmentFileList.value.length > 0 ? additionalInvestmentFileList.value[0].raw : fundInfo.value?.additionalInvestmentFile
            // ruleForm.constitutionFile = constitutionFileList.value.length > 0 ? constitutionFileList.value[0].raw : fundInfo.value?.constitutionFile
            // ruleForm.applicationForm = applicationFormFileList.value.length > 0 ? applicationFormFileList.value[0].raw : fundInfo.value?.applicationForm
            console.log('submit!', ruleForm)
            loading.value = true
            if (!fId.value) {
                saveFund()
            } else {
                saveFundToTag()
                editFund()
            }
        } else {
            ElMessage.error('Please enter correct content!')
            console.log('error submit!', fields)
        }
    })
}

async function saveFund() {
    let params = ruleForm
    // console.log(ruleForm);
    const formData = new FormData()
    Object.keys(params).forEach(keys => {
        if (![null, undefined].includes(params[keys])) {
            formData.append(keys, params[keys])
        }
    })
    const [e, r] = await api.createFund(formData)
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

// Function to save the fund with the added tag
async function saveFundToTag() {
    if (!fId.value || !addedTag.value?.tagId) {
        ElMessage.warning('Please select a tag before saving');
        loading.value = false
        return;
    }
    //判断当前选中fund是否关联过tag
    if (currentTag.value?.tagId) {
        let params = { fundId: fId.value, tagId: addedTag.value.tagId };
        await api.updateFundToTag(params);
    } else {
        let params = { fundId: [fId.value], tagId: addedTag.value.tagId };
        await api.addFundToTag(params);
    }
}

async function editFund() {
    let params = { ...ruleForm, id: fId.value }
    console.log(params);

    params.language = Number(params.language)
    params.bfundCategory = Number(params.bfundCategory)
    params.fundStatus = params.fundStatus ? Number(params.fundStatus) : params.fundStatus
    // params.fundStatus = null

    const formData = new FormData()
    Object.keys(params).forEach(keys => {
        if (![null, undefined].includes(params[keys])) {
            formData.append(keys, params[keys])
        }
    })
    const [e, r] = await api.editFund(formData)
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

async function getEditFund() {
    let params = {
        id: fId.value
    }
    const [e, r] = await api.queryFundByIdWhenEdit(params)
    if (!e && r) {
        console.log(r?.data);

        // if (r.data?.language) {
        //     ruleForm.language = r.data?.language === 'en' ? '1' : '0'
        // }
        ruleForm.language = r.data?.language
        ruleForm.name = r.data?.name || ""
        ruleForm.nameCN = r.data?.nameCN || ""
        ruleForm.fundStatus = r.data?.fundStatus || ""
        ruleForm.description = r.data?.description || ""
        ruleForm.descriptionCN = r.data?.descriptionCN || ""
        ruleForm.amount = r.data?.amount || ""
        ruleForm.currency = r.data?.currency || ""
        ruleForm.currencyCN = r.data?.currencyCN || ""
        ruleForm.fundType = r.data?.fundType || ""
        ruleForm.fundTypeCN = r.data?.fundTypeCN || ""
        ruleForm.investmentType = r.data?.investmentType || ""
        ruleForm.investmentTypeCN = r.data?.investmentTypeCN || ""
        ruleForm.productType = r.data?.productType || ""
        ruleForm.productTypeCN = r.data?.productTypeCN || ""
        ruleForm.bfundCategory = r.data?.bfundCategory || ""
        ruleForm.byearlyReturnRate = r.data?.byearlyReturnRate || ""
        ruleForm.bprojectDurationMonth = r.data?.bprojectDurationMonth || ""
        ruleForm.settlementDate = r.data?.settlementDate ? dayjs(r.data?.settlementDate).format("YYYY-MM-DD") : ""
        ruleForm.interestStartsDate = r.data?.interestStartsDate ? dayjs(r.data?.interestStartsDate).format("YYYY-MM-DD") : ""
        ruleForm.applicationFeeRate = r.data?.applicationFeeRate || ""
        ruleForm.managementFeeRate = r.data?.managementFeeRate || ""
        ruleForm.imFilePath = r.data?.imFilePath || undefined
        ruleForm.subImDate = r.data?.subImDate || ""
        ruleForm.deedDate = r.data?.deedDate || ""
        ruleForm.subImFilePath = r.data?.subImFilePath || undefined
        ruleForm.introduceFilePath = r.data?.introduceFilePath || undefined
        ruleForm.eoiFilePath = r.data?.eoiFilePath || undefined
        ruleForm.reportFilePath = r.data?.reportFilePath || undefined
        ruleForm.additionalInvestmentFile = r.data?.additionalInvestmentFile || undefined
        ruleForm.constitutionFile = r.data?.constitutionFile || undefined
        ruleForm.applicationForm = r.data?.applicationForm || undefined
        ruleForm.purchaseMinAmount = r.data?.purchaseMinAmount || ""
        ruleForm.popular = r.data?.popular
        ruleForm.endDate = r.data?.endDate ? dayjs(r.data?.endDate).format("YYYY-MM-DD") : ""
        ruleForm.stateId = r.data?.stateId || ""
        ruleForm.stateCn = r.data?.stateCn || ""
        ruleForm.stateEn = r.data?.stateEn || ""
        ruleForm.extendStartDate = r.data?.extendStartDate ? dayjs(r.data?.extendStartDate).format("YYYY-MM-DD") : ""
        ruleForm.defaultStartDate = r.data?.defaultStartDate ? dayjs(r.data?.defaultStartDate).format("YYYY-MM-DD") : ""
        ruleForm.bdelayedGrowthRate = r.data?.bdelayedGrowthRate || ""
        ruleForm.company = r.data?.company || ""
    }
}

async function getEditFund2() {
    let params = {
        id: fId.value
    }
    const [e, r] = await api.queryFundById(params)
    if (!e && r) {
        fundInfo.value = r.data
        console.log("🚀 ~ getEditFund2 ~ data:", r.data)
        imageShowListEn.value = r.data?.cover || ""
        imageShowListCn.value = r.data?.coverCn || ""
        imageShowList2En.value = r.data?.coverTwo || ""
        imageShowList2Cn.value = r.data?.coverCnTwo || ""
        imageShowList3En.value = r.data?.coverThree || ""
        imageShowList3Cn.value = r.data?.coverCnThree || ""
        imageShowList4En.value = r.data?.coverFour || ""
        imageShowList4Cn.value = r.data?.coverCnFour || ""
    }
}

const handlePictureCardPreview: UploadProps['onPreview'] = (uploadFile) => {
    dialogImageUrl.value = uploadFile.url!
    dialogVisible.value = true
}

const handleRemove1 = () => {
    imageShowListEn.value = ''
}
const handleRemove2 = () => {
    imageShowList2En.value = ''
}
const handleRemove3 = () => {
    imageShowList3En.value = ''
}
const handleRemove4 = () => {
    imageShowList4En.value = ''
}

const handleRemove1Cn = () => {
    imageShowListCn.value = ''
}
const handleRemove2Cn = () => {
    imageShowList2Cn.value = ''
}
const handleRemove3Cn = () => {
    imageShowList3Cn.value = ''
}
const handleRemove4Cn = () => {
    imageShowList4Cn.value = ''
}

const handleChange1: UploadProps['onChange'] = (uploadFile) => {
    imageShowListEn.value = URL.createObjectURL(uploadFile.raw)
}
const handleChange2: UploadProps['onChange'] = (uploadFile) => {
    imageShowList2En.value = URL.createObjectURL(uploadFile.raw)
}
const handleChange3: UploadProps['onChange'] = (uploadFile) => {
    imageShowList3En.value = URL.createObjectURL(uploadFile.raw)
}
const handleChange4: UploadProps['onChange'] = (uploadFile) => {
    imageShowList4En.value = URL.createObjectURL(uploadFile.raw)
}
const handleChangeCn1: UploadProps['onChange'] = (uploadFile) => {
    imageShowListCn.value = URL.createObjectURL(uploadFile.raw)
}
const handleChangeCn2: UploadProps['onChange'] = (uploadFile) => {
    imageShowList2Cn.value = URL.createObjectURL(uploadFile.raw)
}
const handleChangeCn3: UploadProps['onChange'] = (uploadFile) => {
    imageShowList3Cn.value = URL.createObjectURL(uploadFile.raw)
}
const handleChangeCn4: UploadProps['onChange'] = (uploadFile) => {
    imageShowList4Cn.value = URL.createObjectURL(uploadFile.raw)
}

const handleChangeLan = () => {
    if (!fId.value) {
        imageShowListEn.value = ''
        imageShowListCn.value = ''
        imageShowList2En.value = ""
        imageShowList2Cn.value = ""
        imageShowList3En.value = ""
        imageShowList3Cn.value = ""
        imageShowList4En.value = ""
        imageShowList4Cn.value = ""
    } else {
        imageShowListEn.value = fundInfo.value?.cover || ""
        imageShowListCn.value = fundInfo.value?.coverCn || ""
        imageShowList2En.value = fundInfo.value?.coverTwo || ""
        imageShowList2Cn.value = fundInfo.value?.coverCnTwo || ""
        imageShowList3En.value = fundInfo.value?.coverThree || ""
        imageShowList3Cn.value = fundInfo.value?.coverCnThree || ""
        imageShowList4En.value = fundInfo.value?.coverFour || ""
        imageShowList4Cn.value = fundInfo.value?.coverCnFour || ""
    }
}

const handleDelImg = (type: string) => {
    if (type === 'en1') {
        imageShowListEn.value = ""
        imageListEn1.value = []
    } else if (type === 'en2') {
        imageShowList2En.value = ""
        imageListEn2.value = []
    } else if (type === 'en3') {
        imageShowList3En.value = ""
        imageListEn3.value = []
    } else if (type === 'en4') {
        imageShowList4En.value = ""
        imageListEn4.value = []
    }

    if (type === 'cn1') {
        imageShowListCn.value = ""
        imageListCn1.value = []
    } else if (type === 'cn2') {
        imageShowList2Cn.value = ""
        imageListCn2.value = []
    } else if (type === 'cn3') {
        imageShowList3Cn.value = ""
        imageListCn3.value = []
    } else if (type === 'cn4') {
        imageShowList4Cn.value = ""
        imageListCn4.value = []
    }

}

const handleLocation = (e) => {
    let item: AnyObj = {}
    fundLocation.value.map((i) => {
        if (i.id === e) {
            item = i
        }
    })
    ruleForm.stateCn = item.value
    ruleForm.stateEn = item.code
}

const handleDeleteFile = (str) => {
    fundInfo.value[str] = ''
}
const handleAddedTags = (tag: AnyObj) => {
    addedTag.value = tag;
    console.log(addedTag.value);
};
</script>

<template>
    <div class="pop-top">
        <div class="title">{{ !fId ? 'Create Fund' : 'Edit Fund' }}</div>
        <div v-loading="loading">
            <el-button type="primary" color="#4E9F1C" @click="handleAddFund(ruleFormRef)">
                {{ !fId ? 'New Fund' : 'Edit Fund' }}
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="300px" status-icon>
            <el-form-item label="Language" prop="language">
                <el-radio-group v-model="ruleForm.language" @change="handleChangeLan">
                    <el-radio-button :value="item.value" v-for="(item, index) in languageOptions" :key="index">
                        {{ item.code }}
                    </el-radio-button>
                </el-radio-group>
            </el-form-item>
            <el-form-item label="Popular" prop="popular">
                <el-switch v-model="ruleForm.popular" class="mt-2" :active-value="1" :inactive-value="0"
                    style="margin-left: 24px" inline-prompt :active-icon="Check" :inactive-icon="Close" />
            </el-form-item>
            <el-form-item label="Location" prop="stateId">
                <el-select v-model="ruleForm.stateId" placeholder="Select Location" @change="handleLocation" clearable>
                    <el-option :label="item.code" :value="item.id" v-for="(item, index) in fundLocation" :key="index" />
                </el-select>
            </el-form-item>
            <div class="block-ts" v-if="ruleForm.language === '1'">
                <el-form-item label="Upload Image1" prop="coverFile">
                    <div class="detail-img" v-if="imageShowListEn">
                        <!-- <div class="close-tag" @click="handleDelImg('en1')">
                            <el-icon :size="20">
                                <CircleClose />
                            </el-icon>
                        </div> -->
                        <img :src="imageShowListEn" />
                    </div>
                    <el-upload v-model:file-list="imageListEn1" :auto-upload="false" :limit="1" list-type="picture-card"
                        accept="image/*" :on-preview="handlePictureCardPreview" :on-remove="handleRemove1"
                        :on-change="handleChange1">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Upload Image2" prop="coverFileTwo">
                    <div class="detail-img" v-if="imageShowList2En">
                        <div class="close-tag" @click="handleDelImg('en2')">
                            <el-icon :size="20">
                                <CircleClose />
                            </el-icon>
                        </div>
                        <img :src="imageShowList2En" />
                    </div>
                    <el-upload v-model:file-list="imageListEn2" :auto-upload="false" :limit="1" list-type="picture-card"
                        accept="image/*" :on-preview="handlePictureCardPreview" :on-remove="handleRemove2"
                        :on-change="handleChange2">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Upload Image3" prop="coverFileThree">
                    <div class="detail-img" v-if="imageShowList3En">
                        <div class="close-tag" @click="handleDelImg('en3')">
                            <el-icon :size="20">
                                <CircleClose />
                            </el-icon>
                        </div>
                        <img :src="imageShowList3En" />
                    </div>
                    <el-upload v-model:file-list="imageListEn3" :auto-upload="false" :limit="1" list-type="picture-card"
                        accept="image/*" :on-preview="handlePictureCardPreview" :on-remove="handleRemove3"
                        :on-change="handleChange3">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Upload Image4" prop="coverFileFour">
                    <div class="detail-img" v-if="imageShowList4En">
                        <div class="close-tag" @click="handleDelImg('en4')">
                            <el-icon :size="20">
                                <CircleClose />
                            </el-icon>
                        </div>
                        <img :src="imageShowList4En" />
                    </div>
                    <el-upload v-model:file-list="imageListEn4" :auto-upload="false" :limit="1" list-type="picture-card"
                        accept="image/*" :on-preview="handlePictureCardPreview" :on-remove="handleRemove4"
                        :on-change="handleChange4">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Name" prop="name">
                    <el-input v-model="ruleForm.name" />
                </el-form-item>
                <el-form-item label="Fund Status" prop="fundStatus">
                    <el-select v-model="ruleForm.fundStatus" placeholder="Select Status" clearable>
                        <el-option :label="item.code" :value="item.value" v-for="(item, index) in fundStatusList"
                            :key="index" />
                    </el-select>
                </el-form-item>
                <el-form-item label="Description" prop="description">
                    <el-input v-model="ruleForm.description" placeholder="Please input description" type="textarea"
                        autosize />
                </el-form-item>
                <el-form-item label="Amount" prop="amount">
                    <el-input v-model="ruleForm.amount" type="number" placeholder="Please input amount" />
                </el-form-item>
                <el-form-item label="Currency" prop="currency">
                    <el-input v-model="ruleForm.currency" placeholder="Please input currency" />
                </el-form-item>
                <el-form-item label="Fund Category" prop="fundType">
                    <el-input v-model="ruleForm.fundType" placeholder="Please input Fund Category" />
                </el-form-item>
                <el-form-item label="Investment Type" prop="investmentType">
                    <el-input v-model="ruleForm.investmentType" placeholder="Please input Investment Type" />
                </el-form-item>
                <el-form-item label="Product Type" prop="productType">
                    <el-input v-model="ruleForm.productType" placeholder="Please input Product Type" />
                </el-form-item>
            </div>
            <div class="block-ts" v-if="ruleForm.language === '0'">
                <el-form-item label="Upload Image1" prop="coverCnFile">
                    <div class="detail-img" v-if="imageShowListCn">
                        <!-- <div class="close-tag" @click="handleDelImg('cn1')">
                            <el-icon :size="20">
                                <CircleClose />
                            </el-icon>
                        </div> -->
                        <img :src="imageShowListCn" />
                    </div>
                    <el-upload v-model:file-list="imageListCn1" :auto-upload="false" :limit="1" list-type="picture-card"
                        accept="image/*" :on-preview="handlePictureCardPreview" :on-remove="handleRemove1Cn"
                        :on-change="handleChangeCn1">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Upload Image2" prop="coverCnFileTwo">
                    <div class="detail-img" v-if="imageShowList2Cn">
                        <div class="close-tag" @click="handleDelImg('cn2')">
                            <el-icon :size="20">
                                <CircleClose />
                            </el-icon>
                        </div>
                        <img :src="imageShowList2Cn" />
                    </div>
                    <el-upload v-model:file-list="imageListCn2" :auto-upload="false" :limit="1" list-type="picture-card"
                        accept="image/*" :on-preview="handlePictureCardPreview" :on-remove="handleRemove2Cn"
                        :on-change="handleChangeCn2">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Upload Image3" prop="coverCnFileThree">
                    <div class="detail-img" v-if="imageShowList3Cn">
                        <div class="close-tag" @click="handleDelImg('cn3')">
                            <el-icon :size="20">
                                <CircleClose />
                            </el-icon>
                        </div>
                        <img :src="imageShowList3Cn" />
                    </div>
                    <el-upload v-model:file-list="imageListCn3" :auto-upload="false" :limit="1" list-type="picture-card"
                        accept="image/*" :on-preview="handlePictureCardPreview" :on-remove="handleRemove3Cn"
                        :on-change="handleChangeCn3">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Upload Image4" prop="coverCnFileFour">
                    <div class="detail-img" v-if="imageShowList4Cn">
                        <div class="close-tag" @click="handleDelImg('cn4')">
                            <el-icon :size="20">
                                <CircleClose />
                            </el-icon>
                        </div>
                        <img :src="imageShowList4Cn" />
                    </div>
                    <el-upload v-model:file-list="imageListCn4" :auto-upload="false" :limit="1" list-type="picture-card"
                        accept="image/*" :on-preview="handlePictureCardPreview" :on-remove="handleRemove4Cn"
                        :on-change="handleChangeCn4">
                        <el-icon>
                            <Plus />
                        </el-icon>
                    </el-upload>
                </el-form-item>
                <el-form-item label="基金名称" prop="nameCN">
                    <el-input v-model="ruleForm.nameCN" />
                </el-form-item>
                <el-form-item label="基金状态" prop="fundStatus">
                    <el-select v-model="ruleForm.fundStatus" placeholder="Select Status" clearable>
                        <el-option :label="item.code" :value="item.value" v-for="(item, index) in fundStatusList"
                            :key="index" />
                    </el-select>
                </el-form-item>
                <el-form-item label="描述" prop="descriptionCN">
                    <el-input v-model="ruleForm.descriptionCN" placeholder="" type="textarea" autosize />
                </el-form-item>
                <el-form-item label="金额" prop="amount">
                    <el-input v-model="ruleForm.amount" type="number" placeholder="" />
                </el-form-item>
                <el-form-item label="货币" prop="currencyCN">
                    <el-input v-model="ruleForm.currencyCN" placeholder="" />
                </el-form-item>
                <el-form-item label="基金类型" prop="fundTypeCN">
                    <el-input v-model="ruleForm.fundTypeCN" placeholder="" />
                </el-form-item>
                <el-form-item label="投资类型" prop="investmentTypeCN">
                    <el-input v-model="ruleForm.investmentTypeCN" placeholder="" />
                </el-form-item>
                <el-form-item label="产品类型" prop="productTypeCN">
                    <el-input v-model="ruleForm.productTypeCN" placeholder="" />
                </el-form-item>
            </div>

            <div class="block-ts padding-t-20" v-if="fId">
                <el-form-item label="Add Fund Tag" prop="fundTags">
                    <TagsGroup ref="tagsGroup" @addedTag="handleAddedTags" />
                </el-form-item>
            </div>

            <div class="block-ts padding-t-20">
                <el-form-item label="B Fund Category" prop="bfundCategory">
                    <el-select v-model="ruleForm.bfundCategory" placeholder="Select B Fund Category" clearable>
                        <el-option :label="item.code" :value="item.value" v-for="(item, index) in fundCategory"
                            :key="index" />
                    </el-select>
                </el-form-item>
                <el-form-item label="B yearly return rate" prop="byearlyReturnRate">
                    <el-input v-model="ruleForm.byearlyReturnRate" type="number" placeholder="eg,0.08"></el-input>
                </el-form-item>
                <el-form-item label="B project duration month" prop="bprojectDurationMonth">
                    <el-input v-model="ruleForm.bprojectDurationMonth" type="number" placeholder="eg,6"></el-input>
                </el-form-item>
                <el-form-item label="Settlement date" prop="settlementDate">
                    <el-date-picker v-model="ruleForm.settlementDate" type="date" format="YYYY-MM-DD"
                        value-format="YYYY-MM-DD">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="Interest start date" prop="interestStartsDate">
                    <el-date-picker v-model="ruleForm.interestStartsDate" type="date" format="YYYY-MM-DD"
                        value-format="YYYY-MM-DD">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="End date" prop="endDate">
                    <el-date-picker v-model="ruleForm.endDate" type="date" format="YYYY-MM-DD"
                        value-format="YYYY-MM-DD">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="Minimum Required Investment Amount" prop="purchaseMinAmount">
                    <el-input v-model="ruleForm.purchaseMinAmount" placeholder=""></el-input>
                </el-form-item>
                <el-form-item label="Application fee rate" prop="applicationFeeRate">
                    <el-input v-model="ruleForm.applicationFeeRate" placeholder=""></el-input>
                </el-form-item>
                <el-form-item label="Management fee rate" prop="managementFeeRate">
                    <el-input v-model="ruleForm.managementFeeRate" placeholder=""></el-input>
                </el-form-item>
                <el-form-item label="Extend start date" prop="extendStartDate">
                    <el-date-picker v-model="ruleForm.extendStartDate" type="date" format="YYYY-MM-DD"
                        value-format="YYYY-MM-DD">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="Default start date" prop="defaultStartDate">
                    <el-date-picker v-model="ruleForm.defaultStartDate" type="date" format="YYYY-MM-DD"
                        value-format="YYYY-MM-DD">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="B delayed growth rate" prop="bdelayedGrowthRate">
                    <el-input v-model="ruleForm.bdelayedGrowthRate" type="number"></el-input>
                </el-form-item>
                <el-form-item label="Platform" prop="company">
                    <el-input v-model="ruleForm.company"></el-input>
                </el-form-item>
            </div>

            <div class="block-ts padding-t-20">
                <el-form-item label="Im file path" prop="imFilePath">
                    <el-upload v-model:file-list="imFileList" :auto-upload="false" :limit="1" list-type="text">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Now Im file" v-if="fundInfo?.imFilePath">
                    <div class="file-flex">
                        <a :href="fundInfo?.imFilePath" v-if="fundInfo?.imFilePath" target="_blank">
                            <el-icon size="24" class="color-web">
                                <Document />
                            </el-icon>
                        </a>
                        <el-icon size="24" @click="handleDeleteFile('imFilePath')">
                            <Delete />
                        </el-icon>
                    </div>
                </el-form-item>
                <el-form-item label="Sub Im date" prop="subImDate">
                    <el-date-picker v-model="ruleForm.subImDate" type="date" format="YYYY-MM-DD"
                        value-format="YYYY-MM-DD">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="Deed date" prop="deedDate">
                    <el-date-picker v-model="ruleForm.deedDate" type="date" format="YYYY-MM-DD"
                        value-format="YYYY-MM-DD">
                    </el-date-picker>
                </el-form-item>
                <el-form-item label="sub file path" prop="subImFilePath">
                    <el-upload v-model:file-list="subImFileList" :auto-upload="false" :limit="1" list-type="text">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Now sub file" v-if="fundInfo?.subImFilePath">
                    <div class="file-flex">
                        <a :href="fundInfo?.subImFilePath" v-if="fundInfo?.subImFilePath" target="_blank">
                            <el-icon size="24" class="color-web">
                                <Document />
                            </el-icon>
                        </a>
                        <el-icon size="24" @click="handleDeleteFile('subImFilePath')">
                            <Delete />
                        </el-icon>
                    </div>
                </el-form-item>
                <el-form-item label="Introduce file path" prop="introduceFilePath">
                    <el-upload v-model:file-list="introduceFileList" :auto-upload="false" :limit="1" list-type="text">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Now Introduce file" v-if="fundInfo?.introduceFilePath">
                    <div class="file-flex">
                        <a :href="fundInfo?.introduceFilePath" v-if="fundInfo?.introduceFilePath" target="_blank">
                            <el-icon size="24" class="color-web">
                                <Document />
                            </el-icon>
                        </a>
                        <el-icon size="24" @click="handleDeleteFile('introduceFilePath')">
                            <Delete />
                        </el-icon>
                    </div>
                </el-form-item>
                <el-form-item label="EOI file path" prop="eoiFilePath">
                    <el-upload v-model:file-list="eoiFileList" :auto-upload="false" :limit="1" list-type="text">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Now EOI file" v-if="fundInfo?.eoiFilePath">
                    <div class="file-flex">
                        <a :href="fundInfo?.eoiFilePath" v-if="fundInfo?.eoiFilePath" target="_blank">
                            <el-icon size="24" class="color-web">
                                <Document />
                            </el-icon>
                        </a>
                        <el-icon size="24" @click="handleDeleteFile('eoiFilePath')">
                            <Delete />
                        </el-icon>
                    </div>
                </el-form-item>
                <el-form-item label="Report file" prop="reportFilePath">
                    <el-upload v-model:file-list="reportFileList" :auto-upload="false" :limit="1" list-type="text">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Now Report file" v-if="fundInfo?.reportFilePath">
                    <div class="file-flex">
                        <a :href="fundInfo?.reportFilePath" v-if="fundInfo?.reportFilePath" target="_blank">
                            <el-icon size="24" class="color-web">
                                <Document />
                            </el-icon>
                        </a>
                        <el-icon size="24" @click="handleDeleteFile('reportFilePath')">
                            <Delete />
                        </el-icon>
                    </div>
                </el-form-item>
                <el-form-item label="Additional investment file" prop="additionalInvestmentFile">
                    <el-upload v-model:file-list="additionalInvestmentFileList" :auto-upload="false" :limit="1"
                        list-type="text">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Now Additional investment form" v-if="fundInfo?.additionalInvestmentFile">
                    <div class="file-flex">
                        <a :href="fundInfo?.additionalInvestmentFile" v-if="fundInfo?.additionalInvestmentFile"
                            target="_blank">
                            <el-icon size="24" class="color-web">
                                <Document />
                            </el-icon>
                        </a>
                        <el-icon size="24" @click="handleDeleteFile('additionalInvestmentFile')">
                            <Delete />
                        </el-icon>
                    </div>
                </el-form-item>
                <el-form-item label="Constitution file" prop="constitutionFile">
                    <el-upload v-model:file-list="constitutionFileList" :auto-upload="false" :limit="1"
                        list-type="text">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Now Constitution form" v-if="fundInfo?.constitutionFile">
                    <div class="file-flex">
                        <a :href="fundInfo?.constitutionFile" v-if="fundInfo?.constitutionFile" target="_blank">
                            <el-icon size="24" class="color-web">
                                <Document />
                            </el-icon>
                        </a>
                        <el-icon size="24" @click="handleDeleteFile('constitutionFile')">
                            <Delete />
                        </el-icon>
                    </div>
                </el-form-item>
                <el-form-item label="Application form" prop="applicationForm">
                    <el-upload v-model:file-list="applicationFormFileList" :auto-upload="false" :limit="1"
                        list-type="text">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
                    </el-upload>
                </el-form-item>
                <el-form-item label="Now Application form" v-if="fundInfo?.applicationForm">
                    <div class="file-flex">
                        <a :href="fundInfo?.applicationForm" v-if="fundInfo?.applicationForm" target="_blank">
                            <el-icon size="24" class="color-web">
                                <Document />
                            </el-icon>
                        </a>
                        <el-icon size="24" @click="handleDeleteFile('applicationForm')">
                            <Delete />
                        </el-icon>
                    </div>
                </el-form-item>
            </div>
        </el-form>
    </div>
    <el-dialog v-model="dialogVisible">
        <img class="img" :src="dialogImageUrl" alt="Preview Image" />
    </el-dialog>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;

    .block-ts {
        border-bottom: 1px solid #DEDEDE;
    }

    .padding-t-20 {
        padding-top: 20px;
    }
}

.radio-group {
    width: 272px;

    .item {
        width: 136px;
    }
}

.img {
    width: 100%;
    height: 100%;
}

.flex {
    display: flex;
    align-items: center;
}

.detail-img {
    width: 250px;
    height: 196px;
    border-radius: 10px 10px 0px 0px;
    overflow: hidden;
    margin-right: 20px;
    position: relative;

    img {
        width: 250px;
        height: 196px;
    }

    .close-tag {
        position: absolute;
        right: 10px;
        top: 10px;
        color: #fff;
        cursor: pointer;
    }
}

.file-flex {
    display: flex;
    cursor: pointer;
}
</style>