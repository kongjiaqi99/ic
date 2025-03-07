<script setup lang="ts">
import { Document } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"

import { FundKey } from "@/symbols/fund"
const { fId } = injectStrict(FundKey)


const fundInfo = ref<AnyObj>({})
const languageOptions = ref([])
const selectLang = ref('')
const addedTag = ref<AnyObj>({});

onMounted(() => {
    getDetail()
    getLanguage()
    getFundTags()
})

async function getDetail() {
    let params = {
        id: fId.value
    }
    const [e, r] = await api.queryFundById(params)
    if (!e && r) {
        console.log(r.data);
        fundInfo.value = r?.data || {}
        selectLang.value = fundInfo.value?.language === 'Cn' ? 'Cn' : 'En'
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
        }
    }
}

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
</script>

<template>
    <div class="pop-top">
        <div class="title">View Fund</div>
        <div>
        </div>
    </div>
    <div class="form">
        <el-form ref="fundInfoRef" label-width="300px" status-icon>
            <el-form-item label="Language" prop="language">
                <el-radio-group v-model="selectLang">
                    <el-radio-button :label="item.code" :value="item.code" v-for="(item, index) in languageOptions"
                        :key="index" />
                </el-radio-group>
            </el-form-item>
            <el-form-item label="Tag">
                {{ addedTag?.name || '' }}
            </el-form-item>
            <el-form-item label="ABN">
                {{ addedTag?.abn || '' }}
            </el-form-item>
            <div class="view-block" v-if="selectLang === 'En'">
                <el-form-item label="Upload Image" prop="cover">
                    <el-image style="width: 100px; height: 100px" :src="fundInfo?.cover" fit="contain" />
                    <el-image style="width: 100px; height: 100px" :src="fundInfo?.coverTwo" fit="contain"
                        v-if="fundInfo?.coverTwo" />
                    <el-image style="width: 100px; height: 100px" :src="fundInfo?.coverThree" fit="contain"
                        v-if="fundInfo?.coverThree" />
                    <el-image style="width: 100px; height: 100px" :src="fundInfo?.coverFour" fit="contain"
                        v-if="fundInfo?.coverFour" />
                </el-form-item>
                <el-form-item label="Name" prop="name">
                    {{ fundInfo.name }}
                </el-form-item>
                <el-form-item label="Fund Location" prop="stateEn">
                    {{ fundInfo.stateEn }}
                </el-form-item>
                <el-form-item label="Fund Status" prop="fundStatus">
                    {{ fundInfo.fundStatus }}
                </el-form-item>
                <el-form-item label="Description" prop="description">
                    {{ fundInfo.description }}
                </el-form-item>
                <el-form-item label="Amount" prop="amount">
                    <el-statistic :value="fundInfo.amount" :precision="2" :value-style="{ fontSize: '14px' }" prefix="$"
                        v-if="fundInfo.amount"></el-statistic>
                </el-form-item>
                <el-form-item label="Currency" prop="currency">
                    {{ fundInfo.currency }}
                </el-form-item>
                <el-form-item label="Fund Category" prop="fundType">
                    {{ fundInfo.fundType }}
                </el-form-item>
                <el-form-item label="Investment Type" prop="investmentType">
                    {{ fundInfo.investmentType }}
                </el-form-item>
                <el-form-item label="Product Type" prop="productType">
                    {{ fundInfo.productType }}
                </el-form-item>
            </div>
            <div class="view-block" v-if="selectLang === 'Cn'">
                <el-form-item label="Upload Image" prop="cover">
                    <el-image style="width: 100px; height: 100px" :src="fundInfo?.coverCn" fit="contain" />
                    <el-image style="width: 100px; height: 100px" :src="fundInfo?.coverCnTwo" fit="contain"
                        v-if="fundInfo?.coverCnTwo" />
                    <el-image style="width: 100px; height: 100px" :src="fundInfo?.coverCnThree" fit="contain"
                        v-if="fundInfo?.coverCnThree" />
                    <el-image style="width: 100px; height: 100px" :src="fundInfo?.coverCnFour" fit="contain"
                        v-if="fundInfo?.coverCnFour" />
                </el-form-item>
                <el-form-item label="基金名称" prop="nameCN">
                    {{ fundInfo.nameCN }}
                </el-form-item>
                <el-form-item label="基金位置" prop="stateCn">
                    {{ fundInfo.stateCn }}
                </el-form-item>
                <el-form-item label="基金状态" prop="fundStatus">
                    {{ fundInfo.fundStatus }}
                </el-form-item>
                <el-form-item label="描述" prop="descriptionCN">
                    {{ fundInfo.descriptionCN }}
                </el-form-item>
                <el-form-item label="金额" prop="amount">
                    {{ fundInfo.amount }}
                </el-form-item>
                <el-form-item label="货币" prop="currencyCN">
                    {{ fundInfo.currencyCN }}
                </el-form-item>
                <el-form-item label="基金类型" prop="fundTypeCN">
                    {{ fundInfo.fundTypeCN }}
                </el-form-item>
                <el-form-item label="投资类型" prop="investmentTypeCN">
                    {{ fundInfo.investmentTypeCN }}
                </el-form-item>
                <el-form-item label="产品类型" prop="productTypeCN">
                    {{ fundInfo.productTypeCN }}
                </el-form-item>
            </div>

            <div class="view-block padding-t-20">
                <el-form-item label="B Fund Category" prop="bfundCategory">
                    {{ fundInfo.bfundCategory }}
                </el-form-item>
                <el-form-item label="B yearly return rate" prop="byearlyReturnRate">
                    {{ fundInfo.byearlyReturnRate }}
                </el-form-item>
                <el-form-item label="B project duration month" prop="bprojectDurationMonth">
                    {{ fundInfo.bprojectDurationMonth }}
                </el-form-item>
                <el-form-item label="Settlement date" prop="settlementDate">
                    {{ fundInfo.settlementDate }}
                </el-form-item>
                <el-form-item label="Interest start date" prop="interestStartsDate">
                    {{ fundInfo.interestStartsDate }}
                </el-form-item>
                <el-form-item label="End date" prop="endDate">
                    {{ fundInfo.endDate }}
                </el-form-item>
                <el-form-item label="Minimum Required Investment Amount" prop="purchaseMinAmount">
                    <el-statistic :value="Number(fundInfo.purchaseMinAmount)" :precision="2"
                        :value-style="{ fontSize: '14px' }" prefix="$" v-if="fundInfo.purchaseMinAmount"></el-statistic>
                </el-form-item>
                <el-form-item label="Application fee rate" prop="applicationFeeRate">
                    {{ fundInfo.applicationFeeRate }}
                </el-form-item>
                <el-form-item label="Management fee rate" prop="managementFeeRate">
                    {{ fundInfo.managementFeeRate }}
                </el-form-item>
                <el-form-item label="Extend start date" prop="extendStartDate">
                    {{ fundInfo.extendStartDate }}
                </el-form-item>
                <el-form-item label="Default start date" prop="defaultStartDate">
                    {{ fundInfo.defaultStartDate }}
                </el-form-item>
                <el-form-item label="B delayed growth rate" prop="bdelayedGrowthRate">
                    {{ fundInfo.bdelayedGrowthRate }}
                </el-form-item>
                <el-form-item label="Platform" prop="company">
                    {{ fundInfo.company }}
                </el-form-item>
            </div>

            <div class="view-block padding-t-20">
                <el-form-item label="Im file path" prop="imFilePath">
                    <!-- <el-upload v-model:file-list="imFileList" :auto-upload="false" :limit="1" list-type="text">
                        <template #trigger>
                            <el-button type="primary">Choose file</el-button>
                        </template>
</el-upload> -->
                    <a :href="fundInfo?.imFilePath" v-if="fundInfo?.imFilePath" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-form-item>
                <el-form-item label="Sub Im date" prop="subImDate">
                    {{ fundInfo.subImDate }}
                </el-form-item>
                <el-form-item label="Deed date" prop="deedDate">
                    {{ fundInfo.deedDate }}
                </el-form-item>
                <el-form-item label="sub file path" prop="subImFilePath">
                    <a :href="fundInfo?.subImFilePath" v-if="fundInfo?.subImFilePath" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-form-item>
                <el-form-item label="Introduce file path" prop="introduceFilePath">
                    <a :href="fundInfo?.introduceFilePath" v-if="fundInfo?.introduceFilePath" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-form-item>
                <el-form-item label="EOI file path" prop="eoiFilePath">
                    <a :href="fundInfo?.eoiFilePath" v-if="fundInfo?.eoiFilePath" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-form-item>
                <el-form-item label="Report file path" prop="reportFilePath">
                    <a :href="fundInfo?.reportFilePath" v-if="fundInfo?.reportFilePath" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-form-item>
                <el-form-item label="Additional investment file" prop="additionalInvestmentFile">
                    <a :href="fundInfo?.additionalInvestmentFile" v-if="fundInfo?.additionalInvestmentFile"
                        target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-form-item>
                <el-form-item label="Constitution file" prop="constitutionFile">
                    <a :href="fundInfo?.constitutionFile" v-if="fundInfo?.constitutionFile" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-form-item>
                <el-form-item label="Application form" prop="applicationForm">
                    <a :href="fundInfo?.applicationForm" v-if="fundInfo?.applicationForm" target="_blank">
                        <el-icon size="24" class="color-web">
                            <Document />
                        </el-icon>
                    </a>
                </el-form-item>
            </div>
        </el-form>
    </div>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;

    .view-block {
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

::v-deep(.el-statistic__prefix) {
    font-size: 14px;
}
</style>