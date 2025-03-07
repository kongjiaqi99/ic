<script setup lang="ts">
import { ArrowRight, CloseBold, CaretBottom } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"
// import { isEmail } from "@/utils/validate";
import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';
import type { UploadUserFile } from 'element-plus'
import dayjs from "dayjs";
import { ReferralKey } from "@/symbols/referral"

interface RuleForm {
    clientId: string
    entityId: string
    fundId: string
    gst: boolean
    commissionRate: string
    currency: string
    referralAgreement: any
    refList: any
}

const { rId } = injectStrict(ReferralKey)
const loading = ref(false)

//回调方法
const { func } = injectStrict(PopupKey)

onMounted(async () => {
    await getClientList()
    await getFundList()
    if (rId.value) {
        getEditReferral()
    }
})

const clientList = ref([])
const fundList = ref([])
const entityList = ref([])
const entityListForm = ref([])
const referralData = ref<AnyObj>({})
const referralAgreementFileList = ref<UploadUserFile[]>([])
const ruleFormRef = ref<FormInstance>()
const formRef = ref<FormInstance>()
const ruleForm = reactive<RuleForm>({
    clientId: '',
    entityId: '',
    fundId: '',
    gst: false,
    commissionRate: '',
    currency: '',
    referralAgreement: '',
    refList: [],
})

const dataSource = ref<AnyObj[]>([
    {
        id: 1,
        label: 'Level one 1',
        children: [
            {
                id: 4,
                label: 'Level two 1-1',
                children: [
                    {
                        id: 9,
                        label: 'Level three 1-1-1',
                    },
                    {
                        id: 10,
                        label: 'Level three 1-1-2',
                    },
                ],
            },
        ],
    },
    {
        id: 2,
        label: 'Level one 2',
        children: [
            {
                id: 5,
                label: 'Level two 2-1',
            },
            {
                id: 6,
                label: 'Level two 2-2',
            },
        ],
    },
    {
        id: 3,
        label: 'Level one 3',
        children: [
            {
                id: 7,
                label: 'Level two 3-1',
            },
            {
                id: 8,
                label: 'Level two 3-2',
            },
        ],
    },
])

const dialogFormVisible = ref(false)
const formType = ref('add')
const editIndex = ref(null)
const selectCurrent = ref(0)
const selectCurrentSub = ref(0)
const level = ref(null)
const form = reactive({
    clientId: '' as any,
    entityId: '' as any,
    id: '',
    financeId: '',
    children: [],
    parentId: ''
})

const rules = reactive<FormRules<RuleForm>>({
    clientId: [
        { required: true, message: 'Please select client', trigger: 'change' },
    ],
    entityId: [
        { required: true, message: 'Please select entity', trigger: 'change', },
    ],
    fundId: [
        { required: true, message: 'Please select fund', trigger: 'change', },
    ],
    gst: [
        { required: true, message: 'Please choose gst', trigger: 'change', },
    ],
    commissionRate: [
        { required: true, message: 'Please input Commission Rate', trigger: 'blur', },
    ],
    refList: [
        { required: true, message: 'Please input Referral', trigger: 'blur', },
    ],
})

const handleAddAdmin = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            console.log('submit!')
            if (ruleForm.refList.length <= 0) {
                ElMessage.error('Please input Referral')
                return
            }
            ruleForm.referralAgreement = referralAgreementFileList.value.length > 0 ? referralAgreementFileList.value[0].raw : ''
            loading.value = true
            if (!rId.value) {
                saveReferral()
            } else {
                editReferral()
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

async function getFundList() {
    let params = {}
    const [e, r] = await api.getFundsNames(params)
    if (!e && r) {
        fundList.value = r?.data || []
    }
}

const handleSelect = () => {
    if (ruleForm.clientId) {
        queryEntity()
    } else {
        ruleForm.entityId = ''
        entityList.value = []
    }
}

const handleSelectForm = () => {
    if (form.clientId) {
        queryEntityForm()
        form.entityId = ''
        entityListForm.value = []
    } else {
        form.entityId = ''
        entityListForm.value = []
    }
}

const handleSelectFormEntity = () => {
    if (level.value === 3) {
        console.log(form.entityId, ruleForm.refList[selectCurrent.value].entityId);
        if (form.entityId === ruleForm.refList[selectCurrent.value].entityId) {
            ElMessage.warning('existed')
            form.entityId = ''
        }
        const findIndex = ruleForm.refList[selectCurrent.value].children.findIndex(item => {
            return item.entityId === form.entityId
        })
        if (findIndex !== -1) {
            ElMessage.warning('existed')
            form.entityId = ''
        }
    } else if (level.value === 2) {
        const findIndex = ruleForm.refList.findIndex(item => {
            return item.entityId === form.entityId
        })
        if (findIndex !== -1) {
            ElMessage.warning('existed')
            form.entityId = ''
        }
    }
}

async function queryEntity() {
    if (!ruleForm.clientId) return
    let params = {
        clientId: ruleForm.clientId
    }
    const [e, r] = await api.queryEntity(params)
    if (!e && r) {
        entityList.value = r?.data || []
    }
}
async function queryEntityForm() {
    if (!form.clientId) return
    let params = {
        clientId: form.clientId
    }
    const [e, r] = await api.queryEntity(params)
    if (!e && r) {
        entityListForm.value = r?.data || []
    }
}

async function saveReferral() {
    let params = ruleForm
    const [e, r] = await api.createReferral(params)
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

async function editReferral() {
    let params = { ...ruleForm, id: rId.value }
    console.log(params);
    loading.value = false

    // const [e, r] = await api.updateReferral(params)
    // loading.value = false
    // if (!e && r) {
    //     if (r.success) {
    //         ElMessage.success('Edit successfully')
    //         setTimeout(() => {
    //             func()
    //         }, 1000)
    //     }
    // }
}

async function getEditReferral() {
    let params = {
        id: rId.value
    }
    const [e, r] = await api.queryFinancingById(params)
    if (!e && r) {
        console.log("🚀 ~ file: CreateOrEditReferral.vue:233 ~ getEditReferral ~ r:", r?.data)
        // console.log(r.data);
        if (r.data?.refList && r.data?.refList.length > 0) {
            const pList = []
            r.data?.refList.map(item => {
                if (item.parentId === 0) {
                    item.children = []
                    pList.push(item)
                }
                else {
                    pList.map(i => {
                        if (i.id === item.parentId) {
                            i.children.push(item)
                        }
                    })
                }
            })
            // console.log(pList);
            ruleForm.refList = pList || []
        }
        if (r.data?.refList && r.data?.refList.length > 0) {
            const pList = []
            r.data?.refList.map(item => {
                if (item.parentId === 0) {
                    item.children = []
                    item.label = item.entityName
                    pList.push(item)
                }
                else {
                    pList.map(i => {
                        if (i.id === item.parentId) {
                            item.children = []
                            item.label = item.entityName
                            i.children.push(item)
                        }
                    })
                }
            })
            // console.log(pList);
            dataSource.value = pList
        }
        console.log(dataSource.value);

        referralData.value = r.data
        ruleForm.clientId = r.data?.clientId || ""
        ruleForm.entityId = r.data?.entityId || ""
        ruleForm.fundId = r.data?.fundId || ""
        ruleForm.gst = r.data?.gst || false
        ruleForm.commissionRate = r.data?.commissionRate || ""
        ruleForm.currency = r.data?.currency || ""
    }
}

const handleSetCurrent = (index: number) => {
    selectCurrent.value = index
}

const handleShowAddReferral = (index) => {
    formType.value = 'add'
    level.value = index
    entityListForm.value = []
    form.clientId = ""
    form.entityId = ""
    form.children = []
    dialogFormVisible.value = true
}

const handleAddReferral = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            // console.log('submit!', form)
            const clientItem = clientList.value.find(item => {
                return item.id === form.clientId
            })
            const entityItem = entityListForm.value.find(item => {
                return item.id === form.entityId
            })
            if (formType.value === 'add') {
                if (level.value === 2) {
                    ruleForm.refList.push({
                        clientId: form.clientId,
                        clientName: clientItem.name,
                        entityId: form.entityId,
                        entityName: entityItem.entityName,
                        level: level.value,
                        children: form.children
                    })
                } else if (level.value === 3) {
                    const item = {
                        clientId: form.clientId,
                        clientName: clientItem.name,
                        entityId: form.entityId,
                        entityName: entityItem.entityName,
                        level: level.value
                    }
                    ruleForm.refList[selectCurrent.value].children.push(item)
                }

            } else {
                console.log('edit');
                if (level.value === 2) {
                    ruleForm.refList[editIndex.value].clientId = form.clientId
                    ruleForm.refList[editIndex.value].clientName = clientItem.name
                    ruleForm.refList[editIndex.value].entityName = entityItem.entityName
                    ruleForm.refList[editIndex.value].entityId = form.entityId
                } else if (level.value === 3) {
                    const item = {
                        clientId: form.clientId,
                        clientName: clientItem.name,
                        entityId: form.entityId,
                        entityName: entityItem.entityName,
                        level: level.value,
                        id: form.id,
                        parentId: form.parentId,
                        financeId: form.financeId
                    }
                    ruleForm.refList[selectCurrent.value].children[selectCurrentSub.value] = item
                }
            }

            // console.log(ruleForm.refList);
            dialogFormVisible.value = false
        } else {
            console.log('error submit!', fields)
        }
    })
}

const handleDelList = (type, index) => {
    if (type === 'level1') {
        ruleForm.refList.splice(index, 1)
    } else {
        ruleForm.refList[selectCurrent.value].children.splice(index, 1)
    }
}

const handleShowReferral = (item, index) => {
    console.log(item);
    if (item.level === 2) {
        editIndex.value = index
    } else {
        selectCurrentSub.value = index
    }
    formType.value = 'edit'
    form.clientId = Number(item.clientId)
    form.entityId = Number(item.entityId)
    level.value = item.level
    if (item?.id) {
        form.id = item?.id
    }
    if (item?.financeId) {
        form.financeId = item?.financeId
    }
    if (item?.parentId) {
        form.parentId = item?.parentId
    }
    entityListForm.value = []
    queryEntityForm()
    dialogFormVisible.value = true
}

const handleDownloadEmailById = async (item) => {
    console.log(item);

    let params = {
        date: dayjs(item.paymentDate).subtract(1, 'month').format("YYYY-MM-DD"),
        id: rId.value,
    }
    console.log("🚀 ~ file: detail.vue:383 ~ handleDownloadEmailById ~ params:", params)
    downloadEmail(params)
}

async function downloadEmail(params) {
    api.financingsExportPdf(params)
        .then(res => {
            // console.log(res);
            ElMessage.success('download success')
            // handleShowStatement()
            const a = document.createElement('a')
            a.style.display = 'none'
            const date = dayjs().format('YYYY-MM-DD')
            a.setAttribute('download', `referral-${date}.pdf`)
            a.setAttribute('href', window.URL.createObjectURL(new Blob([res])))
            document.body.appendChild(a)
            a.click()
            document.body.removeChild(a)
        })
}

const append = (data) => {
    console.log(data);
}
</script>

<template>
    <div class="pop-top">
        <div class="title">{{ !rId ? 'Create Referral' : 'Edit Referral' }}</div>
        <div v-permission="'Referral'" v-loading="loading">
            <el-button type="primary" color="#4E9F1C" @click="handleAddAdmin(ruleFormRef)">
                {{ !rId ? 'New Referral' : 'Edit Referral' }}
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="200px" status-icon>
            <div class="block padding-t-20">
                <el-form-item label="Client" prop="clientId">
                    <el-select v-model="ruleForm.clientId" placeholder="Please Client" filterable clearable
                        @change="handleSelect">
                        <el-option :label="item.name" :value="item.id" v-for="(item, index) in clientList"
                            :key="index" />
                    </el-select>
                </el-form-item>
                <el-form-item label="Entity Name" prop="entityId">
                    <el-select v-model="ruleForm.entityId" placeholder="Please Entity Name" filterable clearable>
                        <el-option :label="item.entityName" :value="item.id" v-for="(item, index) in entityList"
                            :key="index" />
                    </el-select>
                </el-form-item>
                <el-form-item label="Fund" prop="fundId">
                    <el-select v-model="ruleForm.fundId" placeholder="Please Fund" filterable clearable>
                        <el-option :label="item.name" :value="item.id" v-for="(item, index) in fundList" :key="index" />
                    </el-select>
                </el-form-item>
                <el-form-item label="GST" prop="gst">
                    <el-switch v-model="ruleForm.gst" active-text="Yes" inactive-text="No" />
                </el-form-item>
            </div>
            <div class="block padding-t-20">
                <el-form-item label="Referral" prop="refList">
                    <div class="flex">
                        <div class="level">
                            <div class="line" v-for="(item, index) in ruleForm.refList" :key="index">
                                <div class="list">
                                    <div :class="index === selectCurrent ? 'item item-act' : 'item'"
                                        @click="handleSetCurrent(index)">
                                        <div class="text-cut">{{ item.clientName }},{{ item.entityName }}</div>
                                        <el-icon @click.stop="handleShowReferral(item, index)">
                                            <CaretBottom />
                                        </el-icon>
                                    </div>
                                    <el-icon class="bg-grey" size="14" color="#fff"
                                        @click="handleDelList('level1', index)">
                                        <CloseBold />
                                    </el-icon>
                                </div>
                            </div>
                            <el-button class="margin-t-10" @click="handleShowAddReferral(2)">
                                +Add level1
                            </el-button>
                        </div>
                        <div class="level" v-if="ruleForm.refList[selectCurrent]?.children">
                            <div class="line" v-for="(item, index) in ruleForm.refList[selectCurrent].children"
                                :key="index">
                                <div class="list">
                                    <div class="item">
                                        <div class="text-cut">{{ item.clientName }},{{ item.entityName }}</div>
                                        <el-icon @click.stop="handleShowReferral(item, index)">
                                            <CaretBottom />
                                        </el-icon>
                                    </div>
                                    <el-icon class="bg-grey" size="14" color="#fff"
                                        @click="handleDelList('level2', index)">
                                        <CloseBold />
                                    </el-icon>
                                </div>
                            </div>
                            <el-button v-if="ruleForm.refList[selectCurrent]?.children.length < 2" class="margin-t-10"
                                @click="handleShowAddReferral(3)">
                                +Add level2
                            </el-button>
                        </div>
                    </div>
                </el-form-item>
                <el-form-item>
                    <el-tree style="min-width: 600px" :data="dataSource" node-key="id">
                        <template #default="{ node, data }">
                            <span class="custom-tree-node">
                                <span>{{ node.label }}</span>
                                <span>
                                    <a style="color: #000;" @click.stop="append(data)"> Edit </a>
                                    <a style="color: #000;margin-left: 8px" @click.stop="append(data)"> Add Level </a>
                                    <a style="color: #000;margin-left: 8px" @click.stop="append(data)"> Delete </a>
                                </span>
                            </span>
                        </template>
                    </el-tree>
                </el-form-item>
            </div>
            <div class="block padding-t-20">
                <el-form-item label="Total Financing Amount">
                    ${{ referralData?.financingAmount || 0 }}
                </el-form-item>
                <el-form-item label="Commission Rate" prop="commissionRate">
                    <el-input v-model="ruleForm.commissionRate" type="number" />
                </el-form-item>
                <el-form-item label="Currency" prop="currency">
                    <el-input v-model="ruleForm.currency" />
                </el-form-item>
                <el-form-item label="Referral Agreement" prop="referralAgreement">
                    <el-upload v-model:file-list="referralAgreementFileList" :auto-upload="false" :limit="1"
                        list-type="text">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
                    </el-upload>
                </el-form-item>
            </div>
        </el-form>
        <div class="block padding-t-20" v-if="rId">
            <div class="table-title">Current Total Amount</div>
            <el-table :data="referralData.subClientsCurrentTotalReturnResponses" height="240"
                :row-style="{ height: '30px' }" header-cell-class-name="table-sell-style">
                <el-table-column prop="clientName" label="Client Name" :align="'center'" />
                <el-table-column prop="entityName" label="Entity" :align="'center'" />
                <el-table-column prop="purchaseAmount" label="Financing Amount" :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.purchaseAmount" :precision="2"
                            :value-style="{ fontSize: '14px' }" prefix="$"
                            v-if="scope.row.purchaseAmount"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="currentTotalReturn" label="Interest Return" :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.currentTotalReturn" :precision="2"
                            :value-style="{ fontSize: '14px' }" prefix="$"
                            v-if="scope.row.currentTotalReturn"></el-statistic>
                    </template>
                </el-table-column>
            </el-table>
        </div>
        <div class="block padding-t-20" v-if="rId">
            <div class="table-title">Commission Payment Records</div>
            <el-table :data="referralData.commissionHistoryResponses" height="240" :row-style="{ height: '30px' }"
                header-cell-class-name="table-sell-style">
                <el-table-column prop="dividendDate" label="Commission Payment Date" :align="'center'" />
                <el-table-column prop="dividendAmount" label="Commission Return" :align="'center'">
                    <template #default="scope">
                        <el-statistic :value="scope.row.dividendAmount" :precision="2"
                            :value-style="{ fontSize: '14px' }" prefix="$"
                            v-if="scope.row.dividendAmount"></el-statistic>
                    </template>
                </el-table-column>
                <el-table-column prop="" label="Action" :align="'center'" fixed="right">
                    <template #default="scope">
                        <div class="pointer">
                            <el-link type="info" @click="handleDownloadEmailById(scope.row)">Download</el-link>
                        </div>
                    </template>
                </el-table-column>
            </el-table>
        </div>
    </div>
    <el-dialog v-model="dialogFormVisible" title="">
        <el-form :model="form" ref="formRef" :rules="rules">
            <el-form-item label="Client" prop="clientId">
                <el-select v-model="form.clientId" placeholder="Please Client" filterable clearable
                    @change="handleSelectForm">
                    <el-option :label="item.name" :value="item.id" v-for="(item, index) in clientList" :key="index" />
                </el-select>
            </el-form-item>
            <el-form-item label="Entity" prop="entityId">
                <el-select v-model="form.entityId" placeholder="Please Entity Name" filterable clearable
                    @change="handleSelectFormEntity">
                    <el-option :label="item.entityName" :value="item.id" v-for="(item, index) in entityListForm"
                        :key="index" />
                </el-select>
            </el-form-item>
        </el-form>
        <template #footer>
            <span class="dialog-footer">
                <el-button @click="dialogFormVisible = false">Cancel</el-button>
                <el-button type="primary" @click="handleAddReferral(formRef)">
                    Confirm
                </el-button>
            </span>
        </template>
    </el-dialog>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;

    .block {
        border-bottom: 1px solid #DEDEDE;

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

    .flex {
        display: flex;

        .level {
            width: 260px;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: flex-start;

            .list {
                display: flex;
                align-items: center;
                justify-content: center;
                gap: 5px;
                cursor: pointer;
                margin-bottom: 10px;

                .item {
                    width: 160px;
                    padding: 2px 14px;
                    background: #F3F3F3;
                    border-radius: 3px;
                    height: 24px;
                    color: #4F4F4F;
                    font-size: 12px;
                    font-style: normal;
                    font-weight: 400;
                    display: flex;
                    align-items: center;
                    justify-content: center;

                    .text-cut {
                        width: 100px;
                        text-overflow: ellipsis;
                        white-space: nowrap;
                        overflow: hidden;
                    }
                }

                .item-act {
                    background: $web-color;
                    color: #fff;
                }
            }
        }

        .level+.level {
            border-left: 1px solid #BDBDBD;
        }
    }
}

.bg-grey {
    background: rgba(207, 207, 207, 0.90);
    border-radius: 50%;
    width: 21px;
    height: 21px;
}

.margin-t-10 {
    margin-top: 10px;
}

::v-deep(.el-statistic__prefix) {
    font-size: 14px;
}

.custom-tree-node {
    flex: 1;
    display: flex;
    align-items: center;
    justify-content: space-between;
    font-size: 14px;
    padding-right: 8px;
}
</style>