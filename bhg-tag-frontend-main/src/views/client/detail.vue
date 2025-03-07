<script setup lang="ts">
import { Message, Iphone, ArrowRight, Location, EditPen, ArrowDown, MoreFilled, ArrowUp } from '@element-plus/icons-vue'
import dayjs from 'dayjs';
import { useApp } from "@/hooks/useApp";
import { RightPanel } from "@/components/index";
import { CreateOrEditEntity, CreatePurchase, CreateInvestment, EditClient } from "./components/index";
import { PopupKey } from "@/symbols/index"
import { EntityKey, ClientKey } from '@/symbols/client';

import { InvestmentKey } from '@/symbols/investment';

import { ElButton, ElMessage, ElMessageBox } from 'element-plus';
import { wrapperEnv } from '@/utils/env'

const { VITE_WEB_ENV } = wrapperEnv

const { setBreadcrumbList } = useApp()

const rightPanel = ref<any>()
const loading = ref(true)
const showStatement = ref(false)
const showStatementYear = ref(false)
const showPurchaseRecord = ref(true)
const webColor = VITE_WEB_ENV === 'ic' ? '#BE9670' : '#AD262F'


//导入rightPanel数组
const panelComponents = [
    {
        name: 'add',
        component: CreateOrEditEntity
    },
    {
        name: 'edit',
        component: CreateOrEditEntity
    },
    {
        name: 'investment',
        component: CreateInvestment
    },
    {
        name: 'purchase',
        component: CreatePurchase
    },
    {
        name: 'editClient',
        component: EditClient
    }
]

//设置默认rightPanel
const selectPanel = ref(null)

const entityId = ref(null)


const router: any = useRouter()

const clientInfo = ref<AnyObj>({})
const entityList = ref([])
const selectEntity = ref(0)
const selectEntityItem = ref({})

const investmentType = ref([{
    name: 'Ongoing Investment',
    value: 'On-Going'
}, {
    name: 'Investment History',
    value: 'Completed'
}])

const investmentList = ref([])
const selectInvestmentType = ref(0)
const currentInvestment = ref(0)
const pinkDate = ref(null)
const pinkYear = ref([])
//admin list数组
const tableData = ref([])
const purchasedFundsData = ref([])
//table 数据总数
const listTotal = ref(0)
//每页几条
const pageSize = ref(10)
//第几页
const pageNum = ref(1)
const selectInvestmentInfo = ref({})
const purchasedId = ref(null)
const centerDialogVisible = ref(false)
const clientId = ref(null)

onMounted(async () => {
    const eId = router.currentRoute.value.query?.eId || ''
    await getDetail()
    await queryEntity(eId)
})

async function getDetail() {
    loading.value = true
    let params = {
        id: router.currentRoute.value.params.id
    }
    const [e, r] = await api.queryClientDetailById(params)
    loading.value = false
    if (!e && r) {
        console.log("🚀 ~ file: detail.vue:98 ~ getDetail ~ r:", r.data)
        clientInfo.value = r?.data || {}
    }
}

async function queryEntity(eId?: string) {
    selectPanel.value = null
    let params = {
        clientId: router.currentRoute.value.params.id
    }
    const [e, r] = await api.queryEntity(params)
    if (!e && r) {
        console.log("🚀 ~ file: detail.vue:110 ~ queryEntity ~ r:", r.data)
        entityList.value = r?.data || []
        if (eId) {
            const index = entityList.value.findIndex(item => {
                return item.id === Number(eId)
            })
            selectEntity.value = index !== -1 ? index : 0
        }
        if (entityList.value.length > 0) {
            getInvestmentList()
        }
    }
}

async function getInvestmentList() {
    let params = {
        pageSize: 1000,
        pageNum: 1
    }
    let query = {
        investmentEntityId: entityList.value[selectEntity.value].id
    }
    const [e, r] = await api.queryInvestment(query, params)
    loading.value = false
    if (!e && r) {
        console.log("🚀 ~ file: detail.vue:135 ~ getInvestmentList ~ r:", r.data?.list)
        let list = r.data?.list || []
        let list2 = list.filter((item: AnyObj) => {
            return item.status === investmentType.value[selectInvestmentType.value].value
        })
        investmentList.value = list2
        if (list2.length > 0) {
            queryAnnualApprove()
            getPurchasedFundsByEn()
            getPurchasedFundsByClient()
        }
    } else {
        console.log(e);
    }
}

async function getPurchasedFundsByEn() {
    let query = {
        entityId: entityList.value[selectEntity.value].id,
        fundId: investmentList.value[currentInvestment.value].fundId
    }
    const [e, r] = await api.investmentRecord(query)
    if (!e && r) {
        console.log("🚀 ~ file: detail.vue:157 ~ getPurchasedFundsByEn2222 ~ r:", r.data)
        tableData.value = r?.data || []
    } else {
        console.log(e);
    }
}

async function getPurchasedFundsByClient() {
    console.log(investmentList.value[currentInvestment.value]);

    let params = {
        pageSize: pageSize.value,
        pageNum: pageNum.value
    }
    let query = {
        idList: investmentList.value[currentInvestment.value].pfId,
        // entityId: entityList.value[selectEntity.value].id,
        // clientId: clientInfo.value.id,
    }
    const [e, r] = await api.queryPurchasedFunds(query, params)
    if (!e && r) {
        console.log("🚀 ~ file: detail.vue:178 ~ getPurchasedFundsByClient ~ r:", r.data.list)
        purchasedFundsData.value = r.data?.list || []
        listTotal.value = r.data?.total || 0
    } else {
        console.log(e);
    }
}

async function queryAnnualApprove() {
    let params = {
        clientId: clientInfo.value.id,
        entityId: entityList.value[selectEntity.value].id,
        fundId: investmentList.value[currentInvestment.value].fundId
    }
    console.log("🚀 ~ queryAnnualApprove ~ params:", params)

    const [e, r] = await api.queryAnnualApprove(params)
    if (!e && r) {
        if (r?.success) {
            console.log("🚀 ~ queryAnnualApprove ~ r:", r?.data[0]?.yearList)
            let yearList = r?.data[0]?.yearList || []
            yearList = yearList.map((item) => {
                return item.toString()
            })
            pinkYear.value = yearList || []
            console.log(pinkYear.value);
        }
    }
}

const handleEditClient = () => {
    setBreadcrumbList([{
        name: `${clientInfo.value?.name}`
    }, {
        name: 'Edit Client'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'editClient'
    })
    clientId.value = clientInfo.value.id
    rightPanel.value.handleIsShow()
}

const handleEditKYC = async () => {
    loading.value = true
    let params = {
        id: clientInfo.value.id,
    }
    console.log(params);
    const [e, r] = await api.approvedClientKyc(params)
    loading.value = false
    if (!e && r) {
        if (r?.success) {
            await getDetail()
            ElMessage.success('verification success')
        }
    }
}

const handleRefuseKYC = async () => {
    loading.value = true
    let params = {
        id: clientInfo.value.id,
    }
    console.log(params);
    const [e, r] = await api.refuseClientKyc(params)
    loading.value = false
    if (!e && r) {
        if (r?.success) {
            await getDetail()
            ElMessage.success('verification success')
        }
    }
}

const handleAddEntity = () => {
    setBreadcrumbList([{
        name: `${clientInfo.value?.name}`
    }, {
        name: 'Create Entity'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'add'
    })
    entityId.value = null
    rightPanel.value.handleIsShow()
}

const handleSelectEntity = (index: number) => {
    selectEntity.value = index
    resetSearch()
    getInvestmentList()
}

//切换entity时重置数据
const resetSearch = () => {
    investmentList.value = []
    tableData.value = []
    purchasedFundsData.value = []
    selectInvestmentType.value = 0
    listTotal.value = 0
    pageNum.value = 1
    pageSize.value = 10
}

//切换investment重置purchased record数据
const handleChangeType = (index: number) => {
    selectInvestmentType.value = index
    getInvestmentList()
    purchasedFundsData.value = []
    listTotal.value = 0
    pageNum.value = 1
    pageSize.value = 10
}

const handleEditEntity = (item: AnyObj) => {
    setBreadcrumbList([{
        name: `${clientInfo.value?.name}`
    }, {
        name: 'Edit Entity'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'edit'
    })
    entityId.value = item.id
    selectEntityItem.value = item
    rightPanel.value.handleIsShow()
}


const handleAddInvestment = () => {
    setBreadcrumbList([{
        name: `${clientInfo.value?.name}`
    }, {
        name: 'Create Investment'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'investment'
    })
    // entityId.value = null
    selectInvestmentInfo.value = {
        clientId: clientInfo.value.id,
        fundId: '',
        entityId: entityList.value[selectEntity.value].id,
        clientName: clientInfo.value.name,
        fundName: '',
        entityName: entityList.value[selectEntity.value].entityName
    }
    rightPanel.value.handleIsShow()
}

const handleAddPurchase = () => {
    setBreadcrumbList([{
        name: `${clientInfo.value?.name}`
    }, {
        name: 'Create Purchase'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'purchase'
    })
    purchasedId.value = null
    selectInvestmentInfo.value = investmentList.value[currentInvestment.value]
    rightPanel.value.handleIsShow()
}

const handleEditPurchase = (item) => {
    setBreadcrumbList([{
        name: `${clientInfo.value?.name}`
    }, {
        name: 'Edit Purchase record'
    }])
    selectPanel.value = panelComponents.findIndex((item) => {
        return item.name === 'purchase'
    })
    purchasedId.value = item.id
    selectInvestmentInfo.value = {}
    rightPanel.value.handleIsShow()
}

//删除Investment
const handleDelPurchase = () => {
    centerDialogVisible.value = true
}

//删除Investment
const handleDelInvestment = async (item: AnyObj) => {
    const params = {
        id: item.id
    }
    const [e, r] = await api.delPurchasedFund(params)
    if (!e && r) {
        if (r.data) {
            ElMessage.success('delete success')
        }
        centerDialogVisible.value = false
        await queryEntity()
    }
}

const handleSendPurchase = async (item) => {
    loading.value = true
    let params = {
        id: item.id,
    }
    const [e, r] = await api.sendUnitCertificate(params)
    loading.value = false
    if (!e && r) {
        if (r?.success) {
            ElMessage.success('send success')
        }
    }
}

const handleDownloadPurchase = async (item) => {
    let params = {
        id: item.id,
    }
    const [e, r] = await api.exportUnitCertificate(params)
    if (!e && r) {
        if (r?.success) {
            console.log(r?.data);
            if (r?.data) {
                window.open(r?.data);
            }
            ElMessage.success('send success')
        }
    }
}

//关闭RightPanel
const closeRightPanel = () => {
    if (rightPanel.value) {
        rightPanel.value.handleIsShow()
    }
}

const handleSendEmail = async () => {
    console.log(investmentList.value[currentInvestment.value]);
    let params = {
        startDate: pinkDate.value,
        idList: investmentList.value[currentInvestment.value].pfId,
        templateType: 2
    }
    sendEmail(params)
}

const handleSendEmailById = async (item) => {
    ElMessageBox.prompt('Please input note', 'Tip', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
    })
        .then(async ({ value }) => {
            let params: AnyObj = {
                startDate: dayjs(item.paymentDate).subtract(1, 'month').format("YYYY-MM-DD"),
                idList: item.idList,
                templateType: 1
            }
            params.note = value || ''
            console.log("🚀 ~ file: detail.vue:356 ~ handleSendEmailById ~ params:", params)
            sendEmail(params)
        })
        .catch(() => { })
}

async function sendEmail(params) {
    const [e, r] = await api.sendMail(params)
    if (!e && r) {
        ElMessage.success('send success')
    }
}

const handleDownloadEmail = async () => {
    console.log(investmentList.value[currentInvestment.value]);
    let params = {
        date: pinkDate.value,
        id: investmentList.value[currentInvestment.value].pfId.join(','),
        template: 2
    }
    console.log("🚀 ~ file: detail.vue:373 ~ handleDownloadEmail ~ params:", params)
    downloadEmail(params)
}

const handleDownloadEmailById = async (item) => {
    ElMessageBox.prompt('Please input note', 'Tip', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
    })
        .then(({ value }) => {
            let params: AnyObj = {
                date: dayjs(item.paymentDate).subtract(1, 'month').format("YYYY-MM-DD"),
                id: item.idList.join(','),
                template: 1
            }
            params.note = value || ''
            console.log("🚀 ~ file: detail.vue:383 ~ handleDownloadEmailById ~ params:", item, params)
            downloadEmail(params)
        })
        .catch(() => { })
}

async function downloadEmail(params) {
    api.exportPdf(params)
        .then(res => {
            // console.log(res);
            ElMessage.success('download success')
            if (showStatement.value) {
                handleShowStatement()
            }
            const a = document.createElement('a')
            a.style.display = 'none'
            const date = dayjs().format('YYYY-MM-DD')
            a.setAttribute('download', `investment-${date}.pdf`)
            a.setAttribute('href', window.URL.createObjectURL(new Blob([res])))
            document.body.appendChild(a)
            a.click()
            document.body.removeChild(a)
        })
}

const handleSendInvestmentPdf = (item: AnyObj) => {
    ElMessageBox.prompt('Please input note', 'Tip', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
    })
        .then(({ value }) => {
            console.log(item);
            let params = {
                entityId: item.entityId || '',
                fundId: item.fundId || '',
                note: value || ''
            }
            console.log(params);
            api.exportInvPdf(params).then(res => {
                // console.log(res);
                ElMessage.success('download success')
                const a = document.createElement('a')
                a.style.display = 'none'
                const date = dayjs().format('YYYY-MM-DD')
                a.setAttribute('download', `InvestmentSummaryStatement-${date}.pdf`)
                a.setAttribute('href', window.URL.createObjectURL(new Blob([res])))
                document.body.appendChild(a)
                a.click()
                document.body.removeChild(a)
            })
        })
        .catch(() => { })
}

const handleAddApprove = async () => {
    if (pinkYear.value.length <= 0) {
        ElMessage.warning('Please select year')
        return
    }

    let params = {
        clientId: clientInfo.value.id,
        entityId: entityList.value[selectEntity.value].id,
        fundId: investmentList.value[currentInvestment.value].fundId,
        yearList: pinkYear.value
    }
    console.log(params);

    const [e, r] = await api.addApprove(params)
    if (!e && r) {
        if (r?.success) {
            showStatementYear.value = false
            ElMessage.success('edit success')
        }
    }
}

const handleChooseInv = (index) => {
    currentInvestment.value = index
    getPurchasedFundsByEn()
    getPurchasedFundsByClient()
    queryAnnualApprove()
}

//分页查询管理员
const handleCurrentChange = (val: number) => {
    pageNum.value = val
    getPurchasedFundsByClient()
}

const handleShowStatement = () => {
    showStatement.value = !showStatement.value
}

const handleShowStatementYear = () => {
    showStatementYear.value = !showStatementYear.value
}

const handleChangeView = () => {
    showPurchaseRecord.value = !showPurchaseRecord.value
}

//向下抛出回调方法以及弹窗显隐
provide(PopupKey, { func: closeRightPanel })
provide(InvestmentKey, { iId: purchasedId, info: selectInvestmentInfo })
provide(EntityKey, { eId: entityId, clientInfo: clientInfo, entityInfo: selectEntityItem })
provide(ClientKey, { cId: clientId })

</script>
<template>
    <div class="detail" v-loading="loading">
        <div class="top">
            <div class="left">
                <div>
                    <div class="name">
                        {{ clientInfo?.name }}
                        <!-- kyc-green -->
                        <div class="kyc-box">
                            <div :class="clientInfo?.kycStatus === 1 ? 'kyc kyc-green' : 'kyc'">
                            </div>
                        </div>
                    </div>
                    <div class="client-id">Client ID : {{ clientInfo?.id }}</div>
                </div>
                <div class="user-btn-group">
                    <div v-permission="'Client'" class="edit" @click="handleEditClient">Edit Profile</div>
                    <div v-permission="'Client'" class="edit green" @click="handleEditKYC"
                        v-if="clientInfo?.kycStatus !== 1">KYC verification</div>
                    <div v-permission="'Client'" class="edit red" @click="handleRefuseKYC"
                        v-if="clientInfo?.kycStatus === 1">KYC Reset</div>
                </div>
                <div class="info">
                    <div class="flex">
                        <el-icon class="icon-bg" size="24" color="#fff">
                            <Message />
                        </el-icon>
                        <div class="text">
                            <div class="sub">Email</div>
                            <div>{{ clientInfo?.email }}</div>
                        </div>
                    </div>
                    <div class="flex">
                        <el-icon class="icon-bg" size="24" color="#fff">
                            <Iphone />
                        </el-icon>
                        <div class="text">
                            <div class="sub">Phone</div>
                            <div>{{ clientInfo?.mobile }}</div>
                        </div>
                    </div>
                </div>
            </div>
            <div class="right">
                <div class="item">
                    <div class="title">D.O.B</div>
                    <div class="num">{{ dayjs(clientInfo?.birth).format('YYYY.MM.DD') }}</div>
                    <div class="text">
                        <div>Target Amount:</div>
                        <el-statistic :value="clientInfo?.targetAmount || 0" :precision="2"
                            :value-style="{ fontSize: '16px', color: '#fff' }" prefix="$"></el-statistic>
                    </div>
                    <div class="text">Create at: <span>{{ clientInfo?.createAt }}</span></div>
                </div>
                <div class="item p-l-60">
                    <div class="title">Client Type:</div>
                    <div class="num">{{ clientInfo?.clientType }}</div>
                    <div class="text">BSB: <span>{{ clientInfo?.bsb }}</span></div>
                    <div class="text">Account Name: <span>{{ clientInfo?.accountName }}</span></div>
                    <div class="text">Account Number: <span>{{ clientInfo?.accountNumber }}</span></div>
                    <div class="text">Withheld Tax: <span>{{ clientInfo?.withheldTax }}</span></div>
                    <div class="text">TF Number: <span>{{ clientInfo?.tfNum }}</span></div>
                </div>
            </div>
            <div class="round1"></div>
            <div class="round2"></div>
        </div>

        <div class="entity">
            <div class="flex">
                <div>
                    <div class="name">Entity List</div>
                    <div class="sub-name">You have <span>{{ entityList.length }}</span> Entities</div>
                </div>
                <div>
                    <el-button v-permission="'Client'" type="primary" color="#4E9F1C" @click="handleAddEntity">
                        New Entity
                        <el-icon>
                            <ArrowRight />
                        </el-icon>
                    </el-button>
                </div>
            </div>

            <div class="list">
                <div :class="index === selectEntity ? 'item act' : 'item'" v-for="(item, index) in entityList"
                    :key="index" @click="handleSelectEntity(index)">
                    <div class="name">
                        {{ item.entityName || "Entity Name" }}
                        <el-tag :type="item?.active ? 'success' : 'info'" round>
                            {{ item?.active ? 'active' : 'non-active'
                            }}
                        </el-tag>
                    </div>
                    <div class="ic-id">ic ID: {{ item.icId }}</div>
                    <div class="email">{{ item.emailList ? item.emailList.join(',') : '' }}</div>
                    <div class="address">
                        <el-icon>
                            <Location />
                        </el-icon>{{ item.addressLine }}
                    </div>
                    <div v-permission="'Client'" class="edit" @click.stop="handleEditEntity(item)">
                        <el-icon :color="index === selectEntity ? '#fff' : '#D9D9D9'">
                            <EditPen />
                        </el-icon>
                    </div>
                </div>
            </div>
        </div>

        <div class="investment" v-if="entityList.length > 0">
            <div class="flex">
                <div>
                    <div class="name">
                        <div :class="selectInvestmentType === index ? 'line act' : 'line'"
                            v-for="(item, index) in investmentType" :key="index" @click="handleChangeType(index)">{{
                                item.name }}
                        </div>
                    </div>
                    <div class="sub-name">You have <span>{{ investmentList.length }}</span> Investments</div>
                </div>
                <div>
                    <el-button v-permission="'Investment'" type="primary" color="#4E9F1C" @click="handleAddInvestment">
                        New Investment
                        <el-icon>
                            <ArrowRight />
                        </el-icon>
                    </el-button>
                </div>
            </div>
            <el-scrollbar v-if="investmentList.length > 0">
                <div class="scrollbar-flex-content">
                    <p v-for="(item, index) in investmentList" :key="index"
                        :class="currentInvestment === index ? 'scrollbar-item item-act' : 'scrollbar-item'"
                        @click="handleChooseInv(index)">
                        Investment {{ index + 1 }}
                    </p>
                </div>
            </el-scrollbar>
            <div class="table-flex" v-if="investmentList.length > 0">
                <div class="left">
                    <div class="name">
                        <span class="text-cut">{{ investmentList[currentInvestment].fundName }}</span>
                        <span class="tag">
                            <el-tag class="text-white"
                                :color="investmentList[currentInvestment].status === 'On-Going' ? '#4E9F1C' : webColor">
                                {{ investmentList[currentInvestment].status }}
                            </el-tag>
                        </span>
                    </div>
                    <div class="sub-name">Total Investment Amount</div>
                    <div class="number">
                        <el-statistic :value="investmentList[currentInvestment].purchasedAmount || 0" :precision="2"
                            :value-style="{ fontSize: '24px', color: '#1a1a1a', fontWeight: '600' }"
                            prefix="$"></el-statistic>
                    </div>
                    <div class="sub-name">Total Investment Return(Tax-Inclusive)</div>
                    <div class="number">
                        <el-statistic :value="investmentList[currentInvestment].currentReturn || 0" :precision="2"
                            :value-style="{ fontSize: '24px', color: '#1a1a1a', fontWeight: '600' }"
                            prefix="$"></el-statistic>
                    </div>
                    <div class="sub-name">Cumulative Expected Interest Amount(Tax-Inclusive)</div>
                    <div class="number">
                        <el-statistic :value="investmentList[currentInvestment].totalReturn || 0" :precision="2"
                            :value-style="{ fontSize: '24px', color: '#1a1a1a', fontWeight: '600' }"
                            prefix="$"></el-statistic>
                    </div>
                    <div class="margin-top-10" v-if="selectInvestmentType === 1">
                        <el-button v-permission="'Investment'" type="primary" color="#4E9F1C"
                            @click="handleSendInvestmentPdf(investmentList[currentInvestment])">
                            Investment Summary Statement
                        </el-button>
                    </div>
                </div>
                <div class="right">
                    <div class="flex-between">
                        <div class="name">Investment Record</div>
                        <div v-permission="'Investment'">
                            <el-popover :visible="showStatementYear" placement="bottom" :width="255" trigger="click">
                                <template #reference>
                                    <el-button class="text-white" type="primary" color="#42A0BE"
                                        @click="handleShowStatementYear">
                                        Set Annual Statement Years
                                        <el-icon>
                                            <ArrowDown />
                                        </el-icon>
                                    </el-button>
                                </template>
                                <div class="email-select">
                                    <div class="title">Annual Statement Years</div>
                                    <el-date-picker v-model="pinkYear" type="years" placeholder="Pick a year"
                                        format="YYYY" value-format="YYYY" />
                                    <el-button class="text-white m-tb-20 color-web-bg" @click="handleAddApprove">
                                        Edit
                                    </el-button>
                                </div>
                            </el-popover>
                            <el-popover :visible="showStatement" placement="bottom" :width="255" trigger="click">
                                <template #reference>
                                    <el-button class="text-white" type="primary" color="#42A0BE"
                                        @click="handleShowStatement">
                                        Annual Statement
                                        <el-icon>
                                            <ArrowDown />
                                        </el-icon>
                                    </el-button>
                                </template>
                                <div class="email-select">
                                    <div class="title">Annual Statement</div>
                                    <el-date-picker v-model="pinkDate" type="year" placeholder="Pick a year"
                                        format="YYYY" value-format="YYYY-MM-DD" />
                                    <div>
                                        <el-button class="text-white m-tb-20 color-web-bg" @click="handleSendEmail">
                                            Send
                                        </el-button>
                                        <el-button class="text-white m-tb-20 m-l-10" type="primary" color="#42A0BE"
                                            @click="handleDownloadEmail">
                                            Download
                                        </el-button>
                                    </div>

                                </div>
                            </el-popover>
                        </div>
                    </div>
                    <div class="table">
                        <el-table :data="tableData" height="240" :row-style="{ height: '30px' }"
                            header-cell-class-name="table-sell-style">
                            <el-table-column prop="paymentDate" label="Payment Date" :align="'center'" />
                            <el-table-column prop="investmentAmount" label="Investment Amount" :align="'center'">
                                <template #default="scope">
                                    <el-statistic :value="scope.row.investmentAmount" :precision="2"
                                        :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
                                </template>
                            </el-table-column>
                            <el-table-column prop="currentReturn" label="Current Return(Tax Excluded)"
                                :align="'center'">
                                <template #default="scope">
                                    <el-statistic :value="scope.row.currentReturn" :precision="2"
                                        :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
                                </template>
                            </el-table-column>
                            <el-table-column prop="closingBalance" label="Closing Balance" :align="'center'">
                                <template #default="scope">
                                    <el-statistic :value="scope.row.closingBalance" :precision="2"
                                        :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
                                </template>
                            </el-table-column>
                            <el-table-column prop="" label="Action" :align="'center'" :width="80">
                                <template #default="scope">
                                    <div class="pointer">
                                        <el-popover placement="bottom" :width="170" trigger="hover">
                                            <template #reference>
                                                <el-icon :size="30" color="#969696">
                                                    <MoreFilled />
                                                </el-icon>
                                            </template>
                                            <div class="action">
                                                <!-- <div class="item" @click="handleDelPurchase">Delete</div> -->
                                                <div v-permission="'Investment'" class="item"
                                                    @click="handleSendEmailById(scope.row)">Send</div>
                                                <div v-permission="'Investment'" class="item"
                                                    @click="handleDownloadEmailById(scope.row)">Download</div>
                                                <el-dialog v-model="centerDialogVisible" title="Message" width="30%"
                                                    align-center>
                                                    <span>Are you sure to delete this?</span>
                                                    <template #footer>
                                                        <span class="dialog-footer">
                                                            <el-button
                                                                @click="centerDialogVisible = false">Cancel</el-button>
                                                            <el-button type="primary"
                                                                @click="handleDelInvestment(scope.row)">
                                                                Confirm
                                                            </el-button>
                                                        </span>
                                                    </template>
                                                </el-dialog>
                                            </div>
                                        </el-popover>
                                    </div>
                                </template>
                            </el-table-column>
                        </el-table>
                    </div>
                </div>
            </div>
        </div>

        <div class="purchase">
            <div class="title">Purchase record</div>
            <div class="tool-box">
                <div class="flex">
                </div>
                <div class="flex">
                    <el-button v-permission="'Investment'" type="primary" color="#4E9F1C" @click="handleAddPurchase"
                        v-if="investmentList.length > 0">
                        New purchase
                        <el-icon>
                            <ArrowRight />
                        </el-icon>
                    </el-button>
                    <el-button v-permission="'Investment'" type="primary" color="#4E9F1C" @click="handleChangeView">
                        {{ showPurchaseRecord ? 'Hide' : 'View' }}
                        <el-icon>
                            <ArrowUp v-if="showPurchaseRecord" />
                            <ArrowDown v-else />
                        </el-icon>
                    </el-button>
                </div>
            </div>
            <div class="table" v-if="showPurchaseRecord">
                <el-table :data="purchasedFundsData" height="600" :row-style="{ height: '80px' }"
                    v-if="purchasedFundsData.length > 0">
                    <el-table-column prop="id" label="Purchase ID" :align="'center'" width="150" fixed="left" />
                    <el-table-column prop="status" label="Status" :align="'center'" fixed="left" width="180">
                        <template #default="scope">
                            <el-tag
                                :type="scope.row.status === 'default' ? 'danger' : scope.row.status === 'normal' || 'ongoing' ? 'success' : scope.row.status === 'end' || 'completed' ? 'info' : 'warning'"
                                class="text-white" effect="dark">
                                {{ scope.row.status }}
                            </el-tag>
                        </template>
                    </el-table-column>
                    <el-table-column prop="unitCertificateDate" label="U/C Date" :align="'center'" width="150" />
                    <el-table-column prop="transactionDate" label="Transaction Date" :align="'center'" width="150" />
                    <el-table-column prop="purchaseEndDate" label="Interest End Date" width="200" />
                    <el-table-column prop="createAt" label="Create At" width="200" />
                    <el-table-column prop="purchasedAmount" label="Purchase Amount" width="200">
                        <template #default="scope">
                            <el-statistic :value="scope.row.purchasedAmount" :precision="2"
                                :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
                        </template>
                    </el-table-column>
                    <el-table-column prop="currentMonthReturn" label="Current Month Return" width="200">
                        <template #default="scope">
                            <el-statistic :value="scope.row.currentMonthReturn" :precision="2"
                                :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
                        </template>
                    </el-table-column>
                    <el-table-column prop="currentTotalReturn" label="Current Total Return" width="200">
                        <template #default="scope">
                            <el-statistic :value="scope.row.currentTotalReturn" :precision="2"
                                :value-style="{ fontSize: '14px' }" prefix="$"></el-statistic>
                        </template>
                    </el-table-column>
                    <el-table-column prop="" label="Action" :align="'center'" fixed="right">
                        <template #default="scope">
                            <div class="pointer">
                                <el-popover placement="bottom" :width="170" trigger="hover">
                                    <template #reference>
                                        <el-icon :size="30" color="#969696">
                                            <MoreFilled />
                                        </el-icon>
                                    </template>
                                    <div v-permission="'Investment'" class="action">
                                        <div class="item" @click="handleEditPurchase(scope.row)">Edit</div>
                                        <div class="item" @click="handleDelPurchase">Delete</div>
                                        <div class="item" @click="handleSendPurchase(scope.row)">Send</div>
                                        <div class="item" @click="handleDownloadPurchase(scope.row)">Download</div>
                                        <el-dialog v-model="centerDialogVisible" title="Message" width="30%"
                                            align-center>
                                            <span>Are you sure to delete this?</span>
                                            <template #footer>
                                                <span class="dialog-footer">
                                                    <el-button @click="centerDialogVisible = false">Cancel</el-button>
                                                    <el-button type="primary" @click="handleDelInvestment(scope.row)">
                                                        Confirm
                                                    </el-button>
                                                </span>
                                            </template>
                                        </el-dialog>
                                    </div>
                                </el-popover>
                            </div>
                        </template>
                    </el-table-column>
                </el-table>
                <el-empty :image-size="200" v-else />
            </div>
            <div class="pagination" v-if="showPurchaseRecord">
                <div></div>
                <el-pagination background layout="total,consists of sizes, prev, pager, next, jumper, ->, slot"
                    :total="listTotal" v-model:page-size="pageSize" v-model:current-page="pageNum"
                    @current-change="handleCurrentChange" />
            </div>
        </div>
    </div>
    <RightPanel ref="rightPanel" @back-Fn="queryEntity">
        <template #content>
            <component :is="panelComponents[selectPanel].component" v-if="selectPanel !== null"></component>
        </template>
    </RightPanel>
</template>

<style lang="scss" scoped>
.detail {
    .top {
        height: 360px;
        padding: 40px;
        border-radius: 12px;
        background: #FFF;
        box-shadow: 0px 1px 1px 0px rgba(0, 0, 0, 0.08), 0px 2px 1px 0px rgba(0, 0, 0, 0.06), 0px 1px 3px 0px rgba(0, 0, 0, 0.10);
        display: flex;
        justify-content: space-between;
        position: relative;
        overflow: hidden;

        .round1 {
            width: 162px;
            height: 162px;
            border-radius: 50%;
            opacity: 0.25;
            background: #FFF;
            position: absolute;
            bottom: -14px;
            right: -67px;
        }

        .round2 {
            width: 120px;
            height: 120px;
            border-radius: 50%;
            opacity: 0.25;
            background: #FFF;
            position: absolute;
            bottom: -36px;
            right: 32px;
        }

        .left {
            display: flex;
            flex-direction: column;
            justify-content: space-between;

            .name {
                color: #22242C;
                font-size: 36px;
                font-style: normal;
                font-weight: 700;
                display: flex;
                // display: inline;

                .kyc-box {
                    width: 20px;
                    position: relative;
                }

                .kyc {
                    position: absolute;
                    right: 0;
                    top: 10px;
                    width: 17px;
                    height: 17px;
                    border-radius: 50%;
                    background: linear-gradient(180deg, #A70808 0%, #E96464 100%);
                }

                .kyc-green {
                    background: linear-gradient(180deg, #4E9F1C 0%, #72FF1B 100%);
                }
            }

            .client-id {
                color: #8E8EA1;
                font-size: 16px;
                font-style: normal;
                font-weight: 400;
            }

            .user-btn-group {
                display: flex;
                // justify-content: space-between;
                align-items: center;
            }

            .edit {
                width: 185px;
                height: 52px;
                border-radius: 60px;
                background: #F5F5F5;
                color: #22242C;
                font-size: 16px;
                font-style: normal;
                font-weight: 600;
                display: flex;
                justify-content: center;
                align-items: center;
                cursor: pointer;
                margin-right: 10px;
            }

            .green {
                background: #4E9F1C;
                color: #fff;
            }

            .red {
                background: #A70808;
                color: #fff;
            }

            .info {
                display: flex;
                align-items: center;

                .flex {
                    display: flex;
                    align-items: center;
                }

                .flex+.flex {
                    margin-left: 30px;
                }

                .icon-bg {
                    width: 40px;
                    height: 40px;
                    border-radius: 50%;
                    background: $web-color;
                }

                .text {
                    padding-left: 14px;
                    color: #202020;
                    font-size: 16px;
                    font-style: normal;
                    font-weight: 600;

                    .sub {
                        color: #8E8EA1;
                        font-size: 14px;
                        font-style: normal;
                        font-weight: 400;
                    }
                }
            }

        }

        .right {
            width: 915px;
            height: 291px;
            border-radius: 40px;
            background: linear-gradient(179deg, $web-color -47.98%, rgba(190, 150, 112, 0.92) 163.51%);
            display: flex;
            justify-content: space-between;
            color: #fff;
            padding: 20px 60px;

            .item {
                padding-top: 10px;
                width: 50%;

                .title {
                    color: #FFF;
                    font-size: 18px;
                    font-style: normal;
                    font-weight: 400;
                }

                .num {
                    color: #FFF;
                    font-size: 36px;
                    font-style: normal;
                    font-weight: 600;
                }

                .text {
                    color: #FFF;
                    font-size: 16px;
                    font-style: normal;
                    font-weight: 600;
                    line-height: 2;
                    display: flex;
                    align-items: center;

                    ::v-deep(.el-statistic__prefix) {
                        color: #fff;
                        font-size: 14px;
                    }

                    span {
                        font-weight: 400;
                    }
                }
            }

            .p-l-60 {
                padding-left: 60px;
            }

            .item+.item {
                border-left: 1px dashed #FFF;
            }
        }
    }

    .entity {
        border-radius: 12px;
        background: #FFF;
        padding: 30px 40px;
        margin-top: 20px;

        .flex {
            display: flex;
            justify-content: space-between;
            align-items: center;

            .name {
                color: #22242C;
                font-size: 24px;
                font-style: normal;
                font-weight: 700;
            }

            .sub-name {
                color: #9E9E9E;
                font-size: 16px;
                font-style: normal;
                font-weight: 400;

                span {
                    color: #000;
                    font-weight: 600;
                }
            }
        }

        .list {
            padding-top: 25px;
            display: flex;
            flex-wrap: wrap;
            align-items: center;
            gap: 20px 20px;

            .item {
                width: calc((100% - 60px) / 4);
                min-width: 200px;
                height: 107px;
                border-radius: 10px;
                background: #FFF;
                box-shadow: 0px 4px 20px 0px rgba(190, 150, 112, 0.15);
                overflow: hidden;
                // padding-top: 17px;
                // padding-left: 27px;
                padding: 10px 27px 0;
                position: relative;
                cursor: pointer;
                color: #4F4F4F;

                .name {
                    font-size: 14px;
                    font-style: normal;
                    font-weight: 700;
                }

                .ic-id,
                .email {
                    line-height: 1.3;
                    font-size: 12px;
                    font-style: normal;
                    font-weight: 400;
                    text-overflow: ellipsis;
                    white-space: nowrap;
                    overflow: hidden;
                    margin-right: 20px;
                }

                .address {
                    padding-top: 10px;
                    font-size: 12px;
                    font-style: normal;
                    font-weight: 400;
                }

                .edit {
                    position: absolute;
                    top: 10px;
                    right: 14px;
                    cursor: pointer;
                }
            }

            .item::after {
                content: "";
                width: 9px;
                height: 100%;
                position: absolute;
                left: 0;
                top: 0;
                background: var(--Linear, linear-gradient(180deg, $web-color 0%, rgba(190, 150, 112, 0.67) 100%));
            }

            .act {
                color: #FFF;
                background: $web-color;
            }
        }
    }

    .investment {
        margin-top: 20px;
        border-radius: 12px;
        // min-height: 1000px;
        background: #FFF;
        padding: 40px 50px;

        .flex {
            display: flex;
            justify-content: space-between;
            align-items: center;

            .name {
                color: #828282;
                font-size: 24px;
                font-style: normal;
                font-weight: 700;
                display: flex;
                align-items: center;

                .line {
                    padding: 0 6px;
                    cursor: pointer;
                }

                .act {
                    color: #333;
                }

                .line+.line {
                    border-left: 4px solid #828282;
                }
            }

            .sub-name {
                color: #9E9E9E;
                font-size: 16px;
                font-style: normal;
                font-weight: 400;
                padding-top: 10px;

                span {
                    color: #000;
                    font-weight: 600;
                }
            }
        }

        .scrollbar-flex-content {
            display: flex;
            padding: 30px 0 10px;

            .scrollbar-item {
                flex-shrink: 0;
                display: flex;
                align-items: center;
                justify-content: center;
                width: 330px;
                height: 62px;
                text-align: center;
                background: #FFF;
                border: 1px solid #DDD;
                cursor: pointer;
            }

            .scrollbar-item+.scrollbar-item {
                border-left: none;
            }

            .item-act {
                background: $web-color;
                color: #fff;
            }
        }

        .table-flex {
            display: flex;
            justify-content: space-between;
            padding: 30px 50px;

            .left {
                padding-top: 10px;
                line-height: 1.5;

                .name {
                    color: #22242C;
                    font-size: 24px;
                    font-style: normal;
                    font-weight: 700;
                    display: flex;
                    align-items: center;
                    line-height: 1;

                    .tag {
                        margin-left: 20px;
                    }

                    .text-cut {
                        width: 200px;
                        // text-overflow: ellipsis;
                        // white-space: nowrap;
                        // overflow: hidden;
                    }
                }

                .sub-name {
                    color: #4F4F4F;
                    font-size: 14px;
                    font-style: normal;
                    font-weight: 600;
                }

                .number {
                    color: #1A1A1A;
                    font-size: 24px;
                    font-style: normal;
                    font-weight: 600;
                }
            }

            .right {
                width: 70%;

                .flex-between {
                    display: flex;
                    justify-content: space-between;
                    align-items: center;

                    .name {
                        color: #4F4F4F;
                        font-size: 16px;
                        font-style: normal;
                        font-weight: 600;
                    }
                }

                .table {
                    margin-top: 15px;
                }
            }
        }
    }

    .purchase {
        margin-top: 20px;
        min-height: 100%;
        border-radius: 12px;
        background: #FFF;
        box-shadow: 0px 1px 1px 0px rgba(0, 0, 0, 0.08), 0px 2px 1px 0px rgba(0, 0, 0, 0.06), 0px 1px 3px 0px rgba(0, 0, 0, 0.10);

        .title {
            color: #1C1C1C;
            font-size: 24px;
            font-style: normal;
            font-weight: 700;
            padding: 48px 56px 16px;
        }

        .tool-box {
            display: flex;
            justify-content: space-between;
            align-items: center;
            padding: 0 56px 16px;

            .flex {
                display: flex;
                align-items: center;

                .select {
                    width: 220px;
                }
            }

            .m-lr-20 {
                margin: 0 20px;
            }

            .text-white {
                color: #ffffff;
            }

            .text-828282 {
                color: #828282;
            }

            .m-l-20 {
                margin-left: 20px;
            }
        }

        .table {
            height: 600px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
    }
}

.text-white {
    color: #fff;
}

.email-select {
    text-align: center;

    .title {
        text-align: center;
        padding-bottom: 15px;
    }

    .m-tb-20 {
        margin: 10px 0;
    }

    .m-l-10 {
        margin-left: 10px;
    }
}

.table-flex ::v-deep(.el-statistic__prefix) {
    font-size: 24px;
}

.table ::v-deep(.el-statistic__prefix) {
    font-size: 14px;
}

.margin-top-10 {
    margin-top: 10px;
}

.text-white {
    color: #ffffff;
}
</style>