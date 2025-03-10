<script lang="ts" setup>
import { Bell, ArrowRight } from '@element-plus/icons-vue'
import { useUser } from "@/hooks/useUser";
import { useApp } from "@/hooks/useApp";
import dayjs from "dayjs";
import { useRole } from "@/hooks/useRole";
import { wrapperEnv } from '@/utils/env'

const { VITE_WEB_ENV } = wrapperEnv
const { breadcrumbList } = useApp()
const { getPermissionsWhite } = useRole()

// const circleUrl = 'https://cube.elemecdn.com/3/7c/3ea6beec64369c2642b92c6726f1epng.png'
const router = useRouter()
const { adminEmail, loginOut } = useUser()
let intervalFlush

function getUserName(name: string) {
    return name.substring(0, 1).toUpperCase()
}


const interval = () => {
    clearInterval(intervalFlush)
    intervalFlush = setInterval(() => {
        // 此处你要轮巡的接口
        getAuditList()
    }, 60000)
}

onMounted(() => {
    getAuditList('first')
})


onUnmounted(() => {
    // 离开页面销毁定时器
    clearInterval(intervalFlush)
})

const auditList = ref([])

async function getAuditList(type?: string) {
    if (!getPermissionsWhite('Audit')) return
    let params = {
        pageSize: 10000,
        pageNum: 1
    }
    let query = {
        status: 'Pending approval'
    }
    const [e, r] = await api.queryAudit(query, params)
    if (!e && r) {
        auditList.value = r.data?.list || []
        if (type) {
            interval()
        }
    } else {
        console.log(e);
    }
}

const handleToView = (item: AnyObj) => {
    router.push({ path: `/audit/index`, query: { aId: item.id } }).catch((err) => {
        console.warn(err)
    })
}

const handleToPath = () => {
    // console.log(`/${router?.currentRoute.value.name.toLocaleLowerCase()}/index`);

    // router.push({ path: `/${router?.currentRoute.value.name.toLocaleLowerCase().trim()}/index` }).catch((err) => {
    //     console.warn(err)
    // })
    // setBreadcrumbList([])
} 
</script>

<template>
    <el-header class="header">
        <div>
            <el-breadcrumb :separator-icon="ArrowRight">
                <el-breadcrumb-item :to="{ path: '/' }">
                    <div class="first-home">{{ VITE_WEB_ENV === 'ic' ? 'Infinity Capital' : 'BCUC' }}</div>
                </el-breadcrumb-item>
                <el-breadcrumb-item @click="handleToPath">
                    <div class="sub-home">{{ router?.currentRoute.value.name }}</div>
                </el-breadcrumb-item>
                <el-breadcrumb-item v-for="(item, index) in breadcrumbList" :key="index">
                    <div class="sub-home">{{ item.name }}</div>
                </el-breadcrumb-item>
            </el-breadcrumb>
        </div>
        <div class="toolbar">
            <el-popover placement="bottom" :width="544" trigger="click" :disabled="auditList.length <= 0">
                <template #reference>
                    <div class="message">
                        <el-icon size="24px">
                            <Bell />
                        </el-icon>
                        <div class="tips" v-if="auditList.length > 0">{{ auditList.length > 99 ? '99+' :
                auditList.length }}
                        </div>
                    </div>
                </template>
                <div v-if="auditList.length > 0">
                    <div class="title"><span class="text-BE9670">{{ auditList.length }}</span> System messages </div>
                    <el-table :data="auditList" height="140" :show-header="false">
                        <el-table-column property="createdAt" label="">
                            <template #default="scope">
                                <span>{{ dayjs(scope.row.createdAt).format("DD-MM-YYYY hh:mm") }}</span>
                            </template>
                        </el-table-column>
                        <el-table-column property="auditType" label="" />
                        <el-table-column property="" label="">
                            <template #default="scope">
                                <div class="table-name pointer" @click="handleToView(scope.row)">
                                    <span>View</span>
                                </div>
                            </template>
                        </el-table-column>
                    </el-table>
                </div>
            </el-popover>
            <el-dropdown>
                <!-- <el-avatar size="" :src="circleUrl" /> -->
                <div class="avatar">{{ (getUserName(adminEmail)) }}</div>
                <template #dropdown>
                    <el-dropdown-menu>
                        <!-- <el-dropdown-item divided>User Info</el-dropdown-item> -->
                        <el-dropdown-item @click="loginOut">Login Out</el-dropdown-item>
                    </el-dropdown-menu>
                </template>
            </el-dropdown>
            <div class="user-name">{{ adminEmail }}</div>
        </div>
    </el-header>
</template>

<style lang="scss" scoped>
.header {
    display: flex;
    justify-content: space-between;
    align-items: center;
    height: 78px;
    padding: 0 36px;
    background: #fff;

    .sub-home,
    .first-home {
        padding: 8px 0;
        font-size: 14px;
        font-style: normal;
        font-weight: 500;
        color: #130101;
        letter-spacing: 0.64px;
    }

    .first-home {
        background: #1E0202;
        border-radius: 2px;
        color: #FFF;
        padding: 8px;
    }

    .toolbar {
        display: flex;
        align-items: center;

        .message {
            position: relative;
            margin-right: 28px;
            cursor: pointer;

            .tips {
                position: absolute;
                width: 16px;
                height: 16px;
                top: 0;
                right: -4px;
                border-radius: 50%;
                background: #E92C2C;
                display: flex;
                justify-content: center;
                align-items: center;
                font-size: 10px;
                font-style: normal;
                font-weight: 600;
                color: #fff;
            }
        }

        .avatar {
            width: 32px;
            height: 32px;
            background: linear-gradient(0deg, rgba(0, 133, 255, 0.10) 0%, rgba(0, 133, 255, 0.10) 100%);
            border-radius: 50%;
            display: flex;
            justify-content: center;
            align-items: center;
            color: #0085FF;
            font-size: 13px;
            font-style: normal;
            font-weight: 500;
            cursor: pointer;
        }

        .user-name {
            padding-left: 8px;
            color: #1C1C1C;
            font-size: 16px;
        }
    }
}

.title {
    color: #000;
    font-size: 16px;
    font-style: normal;
    font-weight: 600;
}

.text-BE9670 {
    color: $web-color;
}
</style>
