<script setup lang="ts">
import { CirclePlusFilled, Delete, EditPen } from '@element-plus/icons-vue'
import { ElMessageBox, type FormInstance, type FormRules } from 'element-plus'
import { injectStrict } from "@/utils"

import { TagsKey } from "@/symbols/tags"

const { selectTags, tagList, getTags, getTagFunds } = injectStrict(TagsKey)

const dialogFormVisible = ref(false)
const ruleFormRef = ref<FormInstance>()
const formType = ref('add')
const isEdit = ref(false)

interface RuleForm {
    abn: string
    name: string
    id: number
}

const ruleForm = reactive<RuleForm>({
    abn: '',
    name: '',
    id: 0
})

const rules = reactive<FormRules<RuleForm>>({
    name: [
        { required: true, message: 'Please input name', trigger: 'blur' },
    ],
    abn: [
        { required: true, message: 'Please input abn', trigger: 'blur', },
    ]
})

onMounted(() => {
})

const handleShowForm = (type: string, item?: AnyObj) => {
    formType.value = type
    dialogFormVisible.value = true
    if (type === 'edit') {
        ruleForm.name = item.name
        ruleForm.abn = item.abn
        ruleForm.id = item.tagId
    } else {
        ruleForm.name = ''
        ruleForm.abn = ''
        ruleForm.id = 0
    }
}

const handleAddTag = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            // console.log('submit!', valid)
            saveOrUpdateTag()
        } else {
            console.log('error submit!', fields)
        }
    })
}

const saveOrUpdateTag = async () => {
    let params: AnyObj = {
        name: ruleForm.name,
        abn: ruleForm.abn
    }
    if (formType.value === 'edit') {
        params.id = ruleForm.id
        await api.updateTag(params)
    } else {
        await api.addTag(params)
    }
    dialogFormVisible.value = false
    ruleForm.name = ''
    ruleForm.abn = ''
    getTags()
}

const handleDeleteTags = async (item: AnyObj) => {
    ElMessageBox.confirm(`Are you sure you want to delete ${item.name}?`, 'Warning', {
        confirmButtonText: 'OK',
        cancelButtonText: 'Cancel',
    })
        .then(async () => {
            console.log(item);
            let params = {
                id: item.tagId
            }
            await api.deleteTag({}, params)
            getTags()
            handleSelectTags(item)
        })
        .catch(() => { })
}

const handleSelectTags = (item: AnyObj) => {
    const index = selectTags.value.findIndex((val: AnyObj) => {
        return val.tagId === item.tagId
    })
    if (index === -1) {
        selectTags.value.push(item)
    } else {
        selectTags.value.splice(index, 1)
    }
    getTagFunds()
}

const selectName = computed(() => {
    return (item: AnyObj) => {
        const index = selectTags.value.findIndex((val: AnyObj) => {
            return val.tagId === item.tagId
        })
        return index >= 0 ? 'active' : ''
    }
})

</script>

<template>
    <div class="tag-list">
        <div class="tag-top">
            <div class="tag-title">Tag</div>
            <div class="tag-btn" @click.stop="isEdit = !isEdit">{{ isEdit ? 'Save' : 'Manage' }}</div>
        </div>

        <div class="filter">
            <div class="filter-icon">
                <img src="../../../assets/icon/filter.png" />
            </div>
            <el-scrollbar class="scroll">
                <div class="f-input">
                    <el-tag type="info" v-for="(item, index) in selectTags" @close="handleSelectTags(item)" :key="index"
                        effect="dark" closable round>
                        {{ item.name }}
                    </el-tag>
                </div>
            </el-scrollbar>
        </div>
        <div class="list-title">
            All Tags
        </div>

        <el-scrollbar class="content">
            <div class="add" @click.stop="handleShowForm('add')" v-show="isEdit">
                <el-icon :size="16" color="#7E869E40">
                    <CirclePlusFilled></CirclePlusFilled>
                </el-icon>
                <div class="marin-l-10">
                    Add new Category
                </div>
            </div>
            <div class="list-line" v-for="(item, index) in tagList" :key="index">
                <div class="tag-name " :class="selectName(item)" @click="handleSelectTags(item)">
                    {{ item.name }}
                </div>
                <div class="icon" v-show="isEdit">
                    <el-icon :size="16" color="#969696" @click.stop="handleDeleteTags(item)">
                        <Delete />
                    </el-icon>
                    <el-icon :size="16" color="#969696" @click.stop="handleShowForm('edit', item)">
                        <EditPen />
                    </el-icon>
                </div>
            </div>
        </el-scrollbar>
        <el-dialog width="400" v-model="dialogFormVisible" title="">
            <el-form class="dialog-form" ref="ruleFormRef" :model="ruleForm" :rules="rules" label-position="top">
                <el-form-item label="Name" prop="name">
                    <el-input v-model="ruleForm.name" class="m-lr-20" placeholder="" clearable />
                </el-form-item>
                <el-form-item label="ABN" prop="abn">
                    <el-input v-model="ruleForm.abn" class="m-lr-20" placeholder="" clearable />
                </el-form-item>
            </el-form>
            <template #footer>
                <span class="dialog-footer">
                    <el-button @click.stop="dialogFormVisible = false">Cancel</el-button>
                    <el-button class="text-white color-web-bg" @click="handleAddTag(ruleFormRef)">
                        {{ formType === 'edit' ? 'Edit' : 'Add' }}
                    </el-button>
                </span>
            </template>
        </el-dialog>
    </div>
</template>

<style lang="scss" scoped>
.tag-list {
    width: 380px;
    height: 100%;
    margin-right: 20px;
    background: #fcfcfc;
    padding: 15px;
    border: 1px solid #dedede;
    user-select: none;

    .tag-top {
        display: flex;
        align-items: center;
        justify-content: space-between;

        .tag-title {
            font-size: 20px;
            line-height: 21px;
            font-weight: 600;
        }

        .tag-btn {
            color: $web-color;
            font-size: 16px;
            cursor: pointer;
        }
    }

    .filter {
        border: 1px solid #AEAFAE;
        margin: 14px 0;
        display: flex;
        align-items: center;

        .filter-icon {
            width: 30px;
            display: flex;
            justify-content: center;
            align-items: center;

            img {
                width: 22px;
                height: 21px;
            }
        }

        .scroll {
            width: calc(100% - 30px);
            border-left: 1px solid #aeaeae;
        }

        .f-input {
            height: 30px;
            display: flex;
            padding: 0 10px;
            align-items: center;

            .el-tag+.el-tag {
                margin-left: 6px;
            }
        }
    }

    .list-title {
        font-size: 20px;
        font-weight: 500;
    }

    .content {
        // margin-top: 6px;
        height: calc(100% - 110px);

        .list-line {
            display: flex;
            justify-content: space-between;
            align-items: center;
            cursor: pointer;
            margin-top: 20px;

            .tag-name {
                font-size: 16px;
                padding-left: 6px;
                width: 80%;
                line-height: 1;
            }

            .icon {
                width: 40px;
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-right: 20px;
            }

            .active {
                color: $web-color;
            }
        }
    }

    .add {
        display: flex;
        justify-content: center;
        align-items: center;
        color: #aaa;
        height: 30px;
        cursor: pointer;
        padding: 20px 0 0;

        .marin-l-10 {
            margin-left: 10px;
        }
    }

    .dialog-form {
        width: 300px;
        margin: 0 auto;
    }

    .text-white {
        color: #ffffff;
    }
}
</style>