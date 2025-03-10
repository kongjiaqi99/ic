<script setup lang="ts">
import { Document } from '@element-plus/icons-vue'

import dayjs from "dayjs";
import { injectStrict } from "@/utils"

import { EnquiryKey } from "@/symbols/enquiry"

const { eId } = injectStrict(EnquiryKey)


const enquiryInfo = ref<AnyObj>({})
const investorTypeList = ref([])
const fundInfo = ref<AnyObj>({})

onMounted(() => {
    queryInvestmentEnTity()
    getDetail()
})

async function getDetail() {
    let params = {
        id: eId.value
    }
    const [e, r] = await api.queryEnquiryById(params)
    if (!e && r) {
        console.log(r.data);

        enquiryInfo.value = r?.data || {}
        if (enquiryInfo.value?.fundId) {
            getEditFund(enquiryInfo.value?.fundId)
        }
        // enquiryInfo.value.type = 3
    }
}

async function queryInvestmentEnTity() {
    let params = { type: 'investment_entity_type' }
    const [e, r] = await api.queryDictionary(params)
    if (!e && r) {
        investorTypeList.value = r?.data || []
    }
}

const getTypeName = computed(() => (str) => {
    const item = investorTypeList.value.find((i: AnyObj) => {
        return i.value === String(str)
    })
    return item?.code
})

async function getEditFund(id) {
    let params = {
        id: id
    }
    const [e, r] = await api.queryFundById(params)
    if (!e && r) {
        fundInfo.value = r.data
    }
}
</script>

<template>
    <div class="pop-top">
        <div class="title">
            <span>Client Enquiry</span>
            <span> - ID:{{ enquiryInfo?.id }}</span>
        </div>
        <div>
        </div>
    </div>
    <div class="form">
        <el-descriptions title="General Form" :column="1" border v-if="enquiryInfo?.type === 1">
            <el-descriptions-item label="Name" label-align="center" align="center">
                {{ enquiryInfo?.name }}
            </el-descriptions-item>
            <el-descriptions-item label="Email" label-align="center" align="center">
                {{ enquiryInfo?.email }}
            </el-descriptions-item>
            <el-descriptions-item label="Phone" label-align="center" align="center">
                {{ enquiryInfo?.phone || 'EMPTY' }}
            </el-descriptions-item>
            <el-descriptions-item label="Selected Intrests" label-align="center" align="center">
                {{ enquiryInfo?.investmentAmount }}
            </el-descriptions-item>
            <el-descriptions-item label="Suburb" label-align="center" align="center">
                {{ enquiryInfo?.suburb }}
            </el-descriptions-item>
            <el-descriptions-item label="State" label-align="center" align="center">
                {{ enquiryInfo?.state }}
            </el-descriptions-item>
        </el-descriptions>
        <div v-if="enquiryInfo?.type === 2">
            <el-descriptions title="Selected Fund Products" :column="1" border>
                <el-descriptions-item label="name" label-align="center" align="center">
                    {{ fundInfo?.name || fundInfo?.nameCn }}
                </el-descriptions-item>
            </el-descriptions>
            <el-descriptions class="m-t-20" title="Selected Investor Type" :column="1" border>
                <el-descriptions-item label="type" label-align="center" align="center">
                    {{ getTypeName(enquiryInfo?.investorType) }}
                </el-descriptions-item>
            </el-descriptions>
            <el-descriptions class="m-t-20" title="Selected Fund Products" :column="1" border>
                <el-descriptions-item label="Contact Name" label-align="center" align="center">
                    {{ enquiryInfo?.name }}
                </el-descriptions-item>
                <el-descriptions-item label="Email" label-align="center" align="center">
                    {{ enquiryInfo?.email }}
                </el-descriptions-item>
                <el-descriptions-item label="Contact Number" label-align="center" align="center">
                    {{ enquiryInfo?.phone }}
                </el-descriptions-item>
                <el-descriptions-item label="Investment Term" label-align="center" align="center">
                    {{ enquiryInfo?.investmentTerm }}
                </el-descriptions-item>
                <el-descriptions-item label="Investment Amount" label-align="center" align="center">
                    {{ enquiryInfo?.investmentAmount }}
                </el-descriptions-item>
                <el-descriptions-item label="Other" label-align="center" align="center">
                    {{ enquiryInfo?.message }}
                </el-descriptions-item>
            </el-descriptions>
        </div>
        <div v-if="enquiryInfo?.type === 3">
            <el-descriptions title="Loan Information" :column="1" border>
                <el-descriptions-item label="Borrowing Entity" label-align="center" align="center">
                    {{ enquiryInfo?.name }}
                </el-descriptions-item>
                <el-descriptions-item label="ACN" label-align="center" align="center">
                    {{ enquiryInfo?.acn }}
                </el-descriptions-item>
                <el-descriptions-item label="Phone Number" label-align="center" align="center">
                    {{ enquiryInfo?.phone }}
                </el-descriptions-item>
                <el-descriptions-item label="Email" label-align="center" align="center">
                    {{ enquiryInfo?.email }}
                </el-descriptions-item>
                <el-descriptions-item label="Guarantor" label-align="center" align="center">
                    {{ enquiryInfo?.guarantor }}
                </el-descriptions-item>
                <el-descriptions-item label="Broker" label-align="center" align="center">
                    {{ enquiryInfo?.broker }}
                </el-descriptions-item>
                <el-descriptions-item label="Loan Type" label-align="center" align="center">
                    {{ enquiryInfo?.borrowType }}
                </el-descriptions-item>
                <el-descriptions-item label="Loan Purpose" label-align="center" align="center">
                    {{ enquiryInfo?.borrowPurpose }}
                </el-descriptions-item>
                <el-descriptions-item label="Loan Amount Request" label-align="center" align="center">
                    {{ enquiryInfo?.borrowAmount }}
                </el-descriptions-item>
                <el-descriptions-item label="Loan Term Request" label-align="center" align="center">
                    {{ enquiryInfo?.borrowTerm }}
                </el-descriptions-item>
                <el-descriptions-item label="Desired Commence Date" label-align="center" align="center">
                    {{ enquiryInfo?.borrowDate }}
                </el-descriptions-item>
            </el-descriptions>
            <template></template>
            <el-descriptions class="m-t-20" :title="'Proposed Security - ' + (index + 1)" :column="1" border
                v-for="(item, index) in enquiryInfo?.borrowList" :key="index">
                <!-- <el-descriptions-item label="Address" label-align="center" align="center">
                </el-descriptions-item> -->
                <el-descriptions-item label="Name of the Owner" label-align="center" align="center">
                    {{ item?.ownerName }}
                </el-descriptions-item>
                <el-descriptions-item label="Property Type" label-align="center" align="center">
                    {{ item?.houseType }}
                </el-descriptions-item>
                <el-descriptions-item label="Land Size" label-align="center" align="center">
                    {{ item?.landArea }}
                </el-descriptions-item>
                <el-descriptions-item label="Est. Value (A$)" label-align="center" align="center">
                    {{ item?.estValue }}
                </el-descriptions-item>
                <el-descriptions-item label="Valuation Date" label-align="center" align="center">
                    {{ item?.valuationDate ? dayjs(item?.valuationDate).format('YYYY-MM-DD') : '' }}
                </el-descriptions-item>
                <el-descriptions-item label="Valuation Entity" label-align="center" align="center">
                    {{ item?.valuationEntity }}
                </el-descriptions-item>
                <el-descriptions-item label="Security Status" label-align="center" align="center">
                    {{ item?.securityStatus }}
                </el-descriptions-item>
                <el-descriptions-item label="Amount owning" label-align="center" align="center">
                    {{ item?.borrowAmount }}
                </el-descriptions-item>
                <el-descriptions-item label="Name of the Lender" label-align="center" align="center">
                    {{ item?.lenderName }}
                </el-descriptions-item>
                <el-descriptions-item label="Is the loan currently in arrears? (if so, what’s the reason)"
                    label-align="center" align="center">
                    {{ item?.reason }}
                </el-descriptions-item>
            </el-descriptions>
            <el-descriptions class="m-t-20" title="Exist Strategy (As much details as possible)" :column="1" border>
                <el-descriptions-item label="Primary" label-align="center" align="center">
                    {{ enquiryInfo?.borrowPrimary }}
                </el-descriptions-item>
                <el-descriptions-item label="Secondary" label-align="center" align="center">
                    {{ enquiryInfo?.borrowSecondary }}
                </el-descriptions-item>
                <el-descriptions-item label="Tertiary (if applicable)" label-align="center" align="center">
                    {{ enquiryInfo?.borrowTertiary }}
                </el-descriptions-item>
            </el-descriptions>
            <el-descriptions class="m-t-20" title="Additional Infomation" :column="1" border>
                <el-descriptions-item label="Additional Information" label-align="center" align="center">
                    {{ enquiryInfo?.borrowAdditional }}
                </el-descriptions-item>
            </el-descriptions>
            <el-descriptions class="m-t-20" title="Upload File" :column="1" border>
                <el-descriptions-item label="Intention File" label-align="center" align="center">
                    <a :href="enquiryInfo?.intentionFile" v-if="enquiryInfo?.intentionFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
                <el-descriptions-item label="Valuation File" label-align="center" align="center">
                    <a :href="enquiryInfo?.valuationFile" v-if="enquiryInfo?.valuationFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
                <el-descriptions-item label="Borrow File" label-align="center" align="center">
                    <a :href="enquiryInfo?.borrowFile" v-if="enquiryInfo?.borrowFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
                <el-descriptions-item label="ASIC File" label-align="center" align="center">
                    <a :href="enquiryInfo?.asicFile" v-if="enquiryInfo?.asicFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
                <el-descriptions-item label="Driver’s licence or Passport File" label-align="center" align="center">
                    <a :href="enquiryInfo?.idFile" v-if="enquiryInfo?.idFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
                <el-descriptions-item label="Real Estate File" label-align="center" align="center">
                    <a :href="enquiryInfo?.houseFile" v-if="enquiryInfo?.houseFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
                <el-descriptions-item label="Investments File" label-align="center" align="center">
                    <a :href="enquiryInfo?.investFile" v-if="enquiryInfo?.investFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
                <el-descriptions-item label="Vehicles File" label-align="center" align="center">
                    <a :href="enquiryInfo?.carFile" v-if="enquiryInfo?.carFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
                <el-descriptions-item label="Loans File" label-align="center" align="center">
                    <a :href="enquiryInfo?.loanFile" v-if="enquiryInfo?.loanFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
                <el-descriptions-item label="Lease File" label-align="center" align="center">
                    <a :href="enquiryInfo?.leaseFile" v-if="enquiryInfo?.leaseFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
                <el-descriptions-item label="Credit Cards File" label-align="center" align="center">
                    <a :href="enquiryInfo?.cardFile" v-if="enquiryInfo?.cardFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-descriptions-item>
            </el-descriptions>
        </div>
    </div>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;

    .m-t-20 {
        margin-top: 20px;
    }
}
</style>