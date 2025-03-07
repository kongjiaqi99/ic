
<script setup lang="ts">
import { PageHeader, Sidebar, PageFooter, AppMain } from "./components"

</script>

<template>
    <div class="common-layout">
        <el-container class="page-flex">
            <Sidebar></Sidebar>
            <el-container class="right-panel">
                <PageHeader></PageHeader>
                <AppMain></AppMain>
                <el-footer>
                    <PageFooter></PageFooter>
                </el-footer>
            </el-container>
        </el-container>
    </div>
</template>

<style lang="scss">
.common-layout {
    height: 100vh;
    overflow: hidden;

    .page-flex {
        display: flex;
        justify-content: space-between;
    }

    .right-panel {
        width: calc(100vw - 267px);
        height: 100vh;
        flex: none !important;
    }

    .el-footer {
        height: 0;
    }

    .el-aside::-webkit-scrollbar {
        display: none;
    }
}
</style>