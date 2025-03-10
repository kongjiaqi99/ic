<script lang="ts" setup>
import { usePermission } from "@/hooks/usePermission";

import { wrapperEnv } from '@/utils/env'

const { VITE_WEB_ENV } = wrapperEnv

const router = useRouter()
const { routes } = usePermission()

const menuActive = ref('1')

onMounted(() => {
    const currentName = router?.currentRoute.value.meta?.name || router?.currentRoute.value.name
    setAct(currentName)
})

/**
 * @description: 路由跳转
 * @param {*} item
 * @return {*}
 */
const handleToPath = (item: AnyObj) => {
    router.push({
        path: item.path
    })
}

watch(
    () => router?.currentRoute.value.meta?.name,
    val => {
        if (val) {
            setAct(val)
        }
    },
)

const setAct = (val) => {
    const index = routes.value.findIndex((item: AnyObj) => {
        return item.meta.name === val
    })
    if (index !== -1) {
        menuActive.value = String(index + 1)
    }
}

</script>

<template>
    <el-aside class="aside sidebar-container">
        <div class="logo">
            <img class="logo-bg" src="@/assets/icon/ic-logo.jpg" v-if="VITE_WEB_ENV === 'ic'" style="width: 200px; height: auto;"/>
            <!-- <img class="logo-bg2" src="@/assets/icon/bug-logo.png" v-if="VITE_WEB_ENV === 'bcuc'" /> -->
            <!-- <el-image class="logo-bg" src="src/assets/icon/ic-logo.png" /> -->
        </div>
        <div class="menu-title">main menu</div>
        <el-scrollbar wrap-class="scrollbar-wrapper">
            <el-menu :default-active="menuActive">
                <template v-for="(item, index) in routes" :key="index">
                    <el-menu-item v-if="!item.meta || !item.meta.hidden" :index="String(index + 1)"
                        @click="handleToPath(item)">
                        <template #title>
                            <div class="menu-item">
                                <img class="icon" :src="(item.meta.icon as string)" />
                                {{ item.meta.name }}
                            </div>
                        </template>
                    </el-menu-item>
                </template>
            </el-menu>
        </el-scrollbar>
    </el-aside>
</template>

<style lang="scss">
.sidebar-container {

    // 重置当前页面的 Element-Plus CSS, ，注意，虽然没有加 scoped 标识，但是被该页面的 sidebar-container 类名包裹，所以不会影响其他页面
    .horizontal-collapse-transition {
        transition: 0s width ease-in-out, 0s padding-left ease-in-out, 0s padding-right ease-in-out;
    }

    .scrollbar-wrapper {
        overflow-x: hidden !important;
    }

    .el-scrollbar__view {
        height: 100%;
    }

    .el-scrollbar__bar {
        &.is-vertical {
            right: 0;
        }

        &.is-horizontal {
            display: none;
        }
    }
}
</style>

<style lang="scss" scoped>
.aside {
    width: 264px;
    height: 100vh;
    background: #FFF;
    box-shadow: 0px 1px 3px 0px rgba(0, 0, 0, 0.20);

    .logo {
        padding: 24px 0 15px;
        padding-left: 20px;
        display: flex;
        // justify-content: center;
        align-items: center;

        .logo-bg {
            display: block;
            width: 184px;
            height: 47px;
        }

        .logo-bg2 {
            display: block;
            width: 184px;
            height: 74px;
        }
    }

    .menu-title {
        color: #969696;
        font-size: 12px;
        font-style: normal;
        font-weight: 400;
        line-height: 16px;
        letter-spacing: 0.48px;
        text-transform: uppercase;
        padding-left: 25px;
        padding-bottom: 18px;
    }

    .el-menu {
        border: none;
        height: 100%;
        width: 100% !important;
    }

    .menu-item {
        width: 212px;
        height: 54px;
        display: flex;
        align-items: center;
        padding-left: 24px;
        color: #181616;
        font-size: 16px;
        font-style: normal;
        font-weight: 500;
        line-height: 16px;
        text-transform: capitalize;
        user-select: none;

        .icon {
            width: 16.88px;
            height: 16.88px;
            margin-right: 13px;
        }
    }

    .menu-item:hover {
        border-radius: 8px;
        background: #EBEEF0;
        cursor: pointer;
    }

    ::v-deep(.el-menu-item),
    ::v-deep(.el-sub-menu__title),
    ::v-deep(.el-sub-menu .el-menu-item) {
        height: 54px;
        line-height: 54px;
        margin-bottom: 8px;

        &:hover {
            background-color: #fff;
        }

        display: block;

        * {
            vertical-align: middle;
        }
    }
}

::v-deep(.el-menu-item) {
    &.is-active .menu-item {
        border-radius: 8px;
        background: #EBEEF0;
    }
}
</style>
