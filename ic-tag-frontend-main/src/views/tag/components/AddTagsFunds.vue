<script setup lang="ts">
import { ArrowRight } from '@element-plus/icons-vue'

import { injectStrict } from "@/utils"

import { TagsKey } from "@/symbols/tags"

const { selectTags, getTagFunds } = injectStrict(TagsKey)

onMounted(() => {
})
const nonSelectTags = ref<AnyObj[]>([])
const dialogFundVisible = ref(false)

const isAll = ref(false)
const selectFunds = ref([])

const handleShowFunds = () => {
    dialogFundVisible.value = true
    queryNonTagged()
}

const handleAll = (e) => {
    if (e) {
        selectFunds.value = nonSelectTags.value.map(item => {
            return item.id
        })
    } else {
        selectFunds.value = []
    }

}

const handleAddFunds = async () => {
    if (selectFunds.value.length <= 0) {
        return
    }

    let params = {
        fundId: selectFunds.value,
        tagId: selectTags.value[0].tagId
    }
    // console.log(params);

    await api.addFundToTag(params)
    selectFunds.value = []
    isAll.value = false
    dialogFundVisible.value = false
    getTagFunds()
}

async function queryNonTagged() {
    const [e, r] = await api.getNonTaggedFunds({})
    if (!e && r) {
        const data: any = r
        nonSelectTags.value = data.funds
    }
}
</script>

<template>
    <el-button v-permission="'Client'" type="primary" @click="handleShowFunds" color="#4E9F1C"
        v-show="selectTags.length === 1">
        + Import Fund
        <el-icon>
            <ArrowRight />
        </el-icon>
    </el-button>
    <el-dialog width="1000" v-model="dialogFundVisible" title="">
        <el-scrollbar class="content-scroll">
            <div class="flex-select">
                <el-switch class="switch" v-model="isAll" active-text="All Funds" inactive-text="No"
                    @change="handleAll" />
                <el-select v-model="selectFunds" class="margin-t-50" multiple placeholder="Select" filterable>
                    <el-option v-for="item in nonSelectTags" :key="item.id" :label="item.name" :value="item.id" />
                </el-select>
            </div>
        </el-scrollbar>
        <template #footer>
            <span class="dialog-footer">
                <el-button @click.stop="dialogFundVisible = false">Cancel</el-button>
                <el-button class="text-white color-web-bg" @click="handleAddFunds">
                    Add
                </el-button>
            </span>
        </template>
    </el-dialog>
</template>

<style lang="scss" scoped>
.text-white {
    color: #ffffff;
}

.content-scroll {
    height: 400px;
}

.flex-select {
    display: flex;
    flex-direction: column;
    padding: 20px 0;

    .margin-t-50 {
        margin-top: 20px;
    }

    .switch {
        width: 200px;
    }
}
</style>