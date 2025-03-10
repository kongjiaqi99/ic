<script lang="ts" setup>
import { VueRecaptcha } from 'vue-recaptcha';

import { useUser } from "@/hooks/useUser"
import { User, Lock } from "@element-plus/icons-vue"
import { usePermissionStoreHook } from '@/stores/modules/permission'
import routers from "@/router"
import { isEmail } from "@/utils/validate";

import { ElMessage } from "element-plus"

import { wrapperEnv } from '@/utils/env'

const { VITE_WEB_ENV } = wrapperEnv

const permissionStore = usePermissionStoreHook()
// console.log(VueRecaptcha);

const pageType = ref<any>('login')
const resetToken = ref<any>('')
const router = useRouter()
const loginFormDom = ref<any>()
const resetFormDom = ref<any>()
const { setUserInfo } = useUser()

onMounted(() => {
    pageType.value = router.currentRoute.value.query?.type || 'login'
    resetToken.value = router.currentRoute.value.query?.pwdResetToken || ''
})

interface ILoginForm {
    /** admin 或 editor */
    username: string
    /** 密码 */
    password?: string
}


let roleList = []
roleList["Super Admin"] = 'superAdmin'
roleList["Fund Admin"] = 'fundAdmin'
roleList["Fund Operation"] = 'fundOperation'
roleList["Web Admin"] = 'webAdmin'

const validateEmail = (rule: any, value: any, callback: any) => {
    if (value === '') {
        callback(new Error('Please input Email'))
    } else if (!isEmail(value)) {
        callback(new Error("Email format is incorrect!"))
    } else {
        callback()
    }
}

const state = reactive({
    /** 登录按钮 Loading */
    loading: false,
    /** 登录表单 */
    loginForm: {
        username: "",
        password: "",
    } as ILoginForm,
    /** 登录表单校验规则 */
    loginRules: {
        username: [{ required: true, message: "please enter email", trigger: "blur" }],
        password: [
            { required: true, message: "Please enter password", trigger: "blur" },
            // { min: 6, max: 16, message: "长度在 6 到 16 个字符", trigger: "blur" }
        ],
    } as any,
    btnType: true,
    /** 登录逻辑 */
    handleLogin: () => {
        loginFormDom.value.validate(async (valid: boolean) => {
            if (valid) {
                if (state.btnType) {
                    return
                }
                state.loading = true
                const params = {
                    adminUserEmail: state.loginForm.username,
                    password: state.loginForm.password
                }
                const [e, r] = await api.userLogin(params)
                if (!e && r) {
                    if (r?.success) {
                        const role = r?.data?.roles ? [roleList[r?.data.roles[0]]] : []
                        let userInfo: IUserState = {
                            token: r.data.token,
                            roles: role,
                            adminEmail: r.data.adminEmail
                        }
                        setUserInfo(userInfo)
                        try {
                            const roles = userInfo.roles
                            // 根据角色生成可访问的 Routes（可访问路由 = 常驻路由 + 有访问权限的动态路由）
                            permissionStore.setRoutes(roles)
                            // 将'有访问权限的动态路由' 添加到 Router 中
                            permissionStore.dynamicRoutes.forEach((route) => {
                                // console.log(route)
                                routers.addRoute(route)
                            })
                            // 确保添加路由已完成
                            // 设置 replace: true, 因此导航将不会留下历史记录
                            // next({ ...to, replace: true })
                        } catch (err: any) {
                            console.log(err);
                        }
                        state.loading = false
                        router.push({ path: role[0] === 'webAdmin' ? "/enquiry" : "/" }).catch((err) => {
                            console.warn(err)
                        })
                    } else {
                        state.loginForm.password = ""
                        state.loading = false
                        // ElMessage.error(r.errorMessage)
                    }
                } else {
                    state.loading = false
                    console.log(e);
                }
            } else {
                return false
            }
        })
    }
})

const resetState = reactive({
    /** 忘记密码按钮 Loading */
    loading: false,
    /** 忘记密码表单 */
    resetForm: {
        username: "",
        password: ""
    } as ILoginForm,
    /** 忘记密码校验规则 */
    resetRules: {
        username: [{ required: true, message: "please enter email", trigger: "blur" }, { validator: validateEmail, trigger: 'blur' }],
        password: [
            { required: true, message: "Please enter password", trigger: "blur" },
            // { min: 6, max: 16, message: "长度在 6 到 16 个字符", trigger: "blur" }
        ],
    } as any,
    /** 登录逻辑 */
    handleResetEmail: () => {
        resetFormDom.value.validate(async (valid: boolean) => {
            if (valid) {
                state.loading = true
                const params = {
                    adminEmail: resetState.resetForm.username
                }
                const [e, r] = await api.sendPasswordResetEmail(params)
                state.loading = false
                if (!e && r) {
                    if (r?.success) {
                        ElMessage.success('Send email success')
                    }
                }
            } else {
                return false
            }
        })
    },
    /** 登录逻辑 */
    handleReset: () => {
        resetFormDom.value.validate(async (valid: boolean) => {
            if (valid) {
                state.loading = true
                const params = {
                    encryptedToken: resetToken.value,
                    pwd: resetState.resetForm.password
                }
                const [e, r] = await api.resetPwdFromEmail(params)
                state.loading = false
                if (!e && r) {
                    if (r?.success) {
                        ElMessage.success('reset success')
                        pageType.value = 'login'
                    }
                }
            } else {
                return false
            }
        })
    }
})



const verifyMethod = (res: any) => {
    window.localStorage.setItem("g-recaptcha-response", res)
    state.btnType = false
}

const handlePassword = (str: string) => {
    pageType.value = str
}

const handleToAdmin = (url: string) => {
    window.open(url, '_blank')
}
</script>

<template>
    <div class="login-container">
        <div class="login-card">
            <div class="title">
                <img src="@/assets/icon/login-icon.png" v-if="VITE_WEB_ENV === 'ic'" />
                <img src="@/assets/icon/bug-icon.png" v-if="VITE_WEB_ENV === 'bcuc'" />
            </div>
            <div class="content">
                <el-form ref="loginFormDom" :model="state.loginForm" :rules="state.loginRules"
                    @keyup.enter="state.handleLogin" v-if="pageType === 'login'">
                    <el-form-item prop="username">
                        <el-input v-model="state.loginForm.username" placeholder="Email" type="text" tabindex="1"
                            :prefix-icon="User" size="large" />
                    </el-form-item>
                    <el-form-item prop="password">
                        <el-input v-model="state.loginForm.password" placeholder="Password" type="password" tabindex="2"
                            :prefix-icon="Lock" size="large" show-password />
                    </el-form-item>
                    <div class="flex-between">
                        <div></div>
                        <el-link class="m-b-10" type="info" @click="handlePassword('sendEmail')">Forgot your
                            password?</el-link>
                    </div>
                    <div class="flex">
                        <vue-recaptcha sitekey="6Le_MuYoAAAAAF-6M-R1ZQ9zwk6hqq0jJwGYVe0b"
                            @verify="verifyMethod"></vue-recaptcha>
                    </div>
                    <el-button :loading="state.loading" size="large" class="color-web-bg"
                        @click.prevent="state.handleLogin" :disabled="state.btnType">
                        Log in
                    </el-button>
                </el-form>
                <el-form ref="resetFormDom" :model="resetState.resetForm" :rules="resetState.resetRules"
                    v-if="pageType === 'sendEmail'">
                    <el-form-item prop="username">
                        <el-input v-model="resetState.resetForm.username" placeholder="Email" type="text" tabindex="1"
                            :prefix-icon="User" size="large" />
                    </el-form-item>
                    <div class="flex-between">
                        <div></div>
                        <el-link class="m-b-10" type="info" @click="handlePassword('login')">Log in</el-link>
                    </div>
                    <el-button :loading="resetState.loading" size="large" class="color-web-bg"
                        @click.prevent="resetState.handleResetEmail">
                        Send me reset password instructions
                    </el-button>
                </el-form>
                <el-form ref="resetFormDom" :model="resetState.resetForm" :rules="resetState.resetRules"
                    v-if="pageType === 'reset'">
                    <el-form-item prop="password">
                        <el-input v-model="resetState.resetForm.password" placeholder="Password" type="password"
                            tabindex="2" :prefix-icon="Lock" size="large" show-password />
                    </el-form-item>
                    <div class="flex-between">
                        <div></div>
                        <el-link class="m-b-10" type="info" @click="handlePassword('login')">Log in</el-link>
                    </div>
                    <el-button :loading="resetState.loading" size="large" class="color-web-bg"
                        @click.prevent="resetState.handleReset">
                        Reset
                    </el-button>
                </el-form>
            </div>
        </div>
    </div>
</template>

<style lang="scss" scoped>
.login-logo {
    width: 250px; /* 你可以改成更大 */
    height: auto;
    display: block;
    margin: 0 auto 20px; /* 让 Logo 居中并有间距 */
    object-fit: contain;
}
.login-container {
    // display: flex;
    // justify-content: center;
    // align-items: center;
    width: 100%;
    min-height: 100vh;
    position: relative;

    .login-select {
        width: 480px;
        height: 100px;
        position: absolute;
        top: 100px;
        left: 50%;
        transform: translateX(-50%);
        display: flex;
        justify-content: space-between;
        align-items: center;

        .item {
            width: 230px;
            height: 100px;
            // background: #000;
            border-radius: 20px;
            display: flex;
            justify-content: center;
            align-items: center;
            box-shadow: 0 0 10px #dcdfe6;
            font-size: 16px;
            cursor: pointer;

            img {
                width: 50px;
                height: 57px;
                margin-right: 10px;
            }
        }

        .act {
            border: 1px solid $web-color;
        }
    }

    .login-card {
        position: absolute;
        top: 240px;
        left: 50%;
        transform: translateX(-50%);
        width: 480px;
        border-radius: 20px;
        box-shadow: 0 0 10px #dcdfe6;
        background-color: #fff;
        overflow: hidden;

        .title {
            display: flex;
            justify-content: center;
            align-items: center;
            padding: 10px 0;

            img {
                width: 133;       /* 让图片按照原始比例调整 */
                max-width: 100%;   /* 图片不会超过父容器 */
                height: auto;      /* 高度自动调整，避免变形 */
                max-height: 154px; /* 确保不会超出原有设计 */
                object-fit: contain; /* 确保完整显示 */
            }
        }

        .content {
            padding: 20px 50px 50px 50px;

            .show-code {
                position: absolute;
                right: 0px;
                top: 0px;
                cursor: pointer;
                user-select: none;

                img {
                    width: 100px;
                    height: 40px;
                    border-radius: 4px;
                }
            }

            .el-button {
                width: 100%;
                margin-top: 10px;
                color: #fff;
            }

            .flex {
                display: flex;
                justify-content: center;
                align-items: center;
                padding-bottom: 10px;
            }

            .p-t-10 {
                padding-top: 10px;
            }

            .m-b-10 {
                margin-bottom: 20px;
            }

            .flex-between {
                display: flex;
                justify-content: space-between;
                align-items: center;
            }
        }
    }
}
</style>
