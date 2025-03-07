<script setup lang="ts"></script>
<template>
    <el-scrollbar class="app-main">
        <el-main class="app-main">
            <router-view></router-view>
        </el-main>
    </el-scrollbar>
</template>

<style lang="scss" scoped>
.app-main {
    height: calc(100vh - 78px);
}
</style>