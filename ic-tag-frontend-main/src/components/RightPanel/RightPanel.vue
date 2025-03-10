<script setup lang="ts">
import { PageHeader } from "@/layout/components"
import { useApp } from "@/hooks/useApp";

const { resetBreadcrumbList } = useApp()

const emit = defineEmits(["backFn"])

const visible = ref(false)

//点击关闭回调
const handleClose = () => {
    resetBreadcrumbList()
    // emit('backFn')
    handleIsShow()
}

//主动设置关闭回调
const handleIsShow = () => {
    visible.value = !visible.value
    if (!visible.value) {
        resetBreadcrumbList()
        emit('backFn')
    }
}
defineExpose({
    handleIsShow
})
</script>

<template>
    <el-drawer class="panel" v-model="visible" :show-close="false" :before-close="handleClose">
        <template #header="{ }">
            <PageHeader></PageHeader>
        </template>
        <slot name="content" />
    </el-drawer>
</template>

<style lang="scss">
.panel {
    width: calc(100vw - 267px) !important;
}

.el-drawer__header {
    padding: 0 !important;
    margin: 0 !important;
}
</style>