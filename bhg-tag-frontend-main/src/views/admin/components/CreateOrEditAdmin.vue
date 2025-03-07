
<script setup lang="ts">
import { ArrowRight } from '@element-plus/icons-vue'
import { injectStrict } from "@/utils"
import { PopupKey } from "@/symbols/index"


import { isEmail } from "@/utils/validate";

import type { FormInstance, FormRules } from 'element-plus'
import { ElMessage } from 'element-plus';

import { AdminKey } from "@/symbols/admin"

interface RuleForm {
    adminUserEmail: string
    roleId: number
    password: string
    password2: string
}

const { aId } = injectStrict(AdminKey)
const loading = ref(false)

//回调方法
const { func } = injectStrict(PopupKey)

onMounted(() => {
    getRoleList()
    if (aId.value) {
        getEditUser()
    }
})

const roleList = ref([])
const ruleFormRef = ref<FormInstance>()
const ruleForm = reactive<RuleForm>({
    adminUserEmail: '',
    roleId: null,
    password: 'asdf1234',
    password2: 'asdf1234'
})

const validatePass2 = (rule: any, value: any, callback: any) => {
    if (value === '') {
        callback(new Error('Please input the Password again'))
    } else if (value !== ruleForm.password) {
        callback(new Error("Two inputs don't match!"))
    } else {
        callback()
    }
}

const validateEmail = (rule: any, value: any, callback: any) => {
    if (value === '') {
        callback(new Error('Please input Email'))
    } else if (!isEmail(value)) {
        callback(new Error("Email format is incorrect!"))
    } else {
        callback()
    }
}

const rules = reactive<FormRules<RuleForm>>({
    adminUserEmail: [
        { required: true, message: 'Please input Email', trigger: 'blur' },
        { validator: validateEmail, trigger: 'blur' },
    ],
    roleId: [
        {
            required: true,
            message: 'Please select Role',
            trigger: 'change',
        },
    ],
    password: [
        { required: true, message: 'Please input Password', trigger: 'blur' },
        { min: 8, max: 16, message: 'Length should be 8 to 16', trigger: 'blur' },
    ],
    password2: [
        { required: true, message: 'Please input Password', trigger: 'blur' },
        { min: 8, max: 16, message: 'Length should be 8 to 16', trigger: 'blur' },
        { validator: validatePass2, trigger: 'blur' }
    ],
})

const handleAddAdmin = async (formEl: FormInstance | undefined) => {
    if (!formEl) return
    await formEl.validate((valid, fields) => {
        if (valid) {
            console.log('submit!')
            loading.value = true
            if (!aId.value) {
                saveAdmin()
            } else {
                editAdmin()
            }
        } else {
            ElMessage.error('Please enter correct content!')
            console.log('error submit!', fields)
        }
    })
}

async function getRoleList() {
    let params = {}
    const [e, r] = await api.queryRoles(params)
    if (!e && r) {
        roleList.value = r?.data || []
    }
}

async function saveAdmin() {
    let params = ruleForm
    const [e, r] = await api.createAdminUser(params)
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

async function editAdmin() {
    let params = { ...ruleForm, id: aId.value }
    const [e, r] = await api.editAdmin(params)
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

async function getEditUser() {
    let params = {
        id: aId.value
    }
    const [e, r] = await api.queryAdminByIdWhenEdit(params)
    if (!e && r) {
        ruleForm.adminUserEmail = r.data?.email || ""
        ruleForm.roleId = Number(r.data?.roleId) || null
    }
}
</script>

<template>
    <div class="pop-top">
        <div class="title">{{ !aId ? 'Create Admin User' : 'Edit Admin User' }}</div>
        <div v-loading="loading">
            <el-button type="primary" color="#4E9F1C" @click="handleAddAdmin(ruleFormRef)">
                {{ !aId ? 'New Admin User' : 'Edit Admin User' }}
                <el-icon>
                    <ArrowRight />
                </el-icon>
            </el-button>
        </div>
    </div>
    <div class="form">
        <el-form ref="ruleFormRef" :model="ruleForm" :rules="rules" label-width="200px" status-icon>
            <el-form-item label="Email" prop="adminUserEmail">
                <el-input v-model="ruleForm.adminUserEmail" />
            </el-form-item>
            <el-form-item label="Role" prop="roleId">
                <el-select v-model="ruleForm.roleId" placeholder="Select Role">
                    <el-option :label="item.roleName" :value="item.id" v-for="(item, index) in roleList" :key="index" />
                </el-select>
            </el-form-item>
            <el-form-item label="Password" prop="password">
                <el-input v-model="ruleForm.password" type="password" placeholder="Please input password" show-password />
            </el-form-item>
            <el-form-item label="Password confirmation" prop="password2">
                <el-input v-model="ruleForm.password2" type="password" placeholder="Please input password" show-password />
            </el-form-item>
        </el-form>
    </div>
</template>

<style lang="scss" scoped>
.form {
    padding: 20px;
}
</style>