<template>
    <div class="editor-container">
        <Toolbar style="border-bottom: 1px solid #dedfe6" :editor="editorRef" :defaultConfig="toolbarConfig" :mode="mode" />
        <Editor style="height: 300px; overflow-y: hidden;" v-model="valueHtml" :defaultConfig="editorConfig" :mode="mode"
            @onCreated="handleCreated" @onChange="handleBlur" />
    </div>
</template>

<script setup lang="ts">
import '@wangeditor/editor/dist/css/style.css'
import { Editor, Toolbar, } from '@wangeditor/editor-for-vue'
import { i18nChangeLanguage } from '@wangeditor/editor'

const props = defineProps({
    detail: {
        type: String
    }
})

const emits = defineEmits(['onSuccess'])

i18nChangeLanguage('en')
// 编辑器实例，必须用 shallowRef
const editorRef = shallowRef()
const mode = 'default'

// 内容 HTML
const valueHtml = ref('<p></p>')

// 模拟 ajax 异步获取内容
onMounted(() => {
    // setTimeout(() => {
    //     valueHtml.value = '<p>模拟 Ajax 异步设置内容</p>'
    // }, 1500)
})

const toolbarConfig = {
    excludeKeys: [
        'fullScreen',
        'code',
        'codeBlock',
        'bulletedList',
        'numberedList',
        'blockquote',
        'bold',
        'italic',
        'video',
        'fontSize',
        'fontFamily',
        'lineHeight',
        'group-video',
        'group-image',
    ], //此处不需要的工具栏选项
}
const editorConfig = { placeholder: 'Please enter content...' }

// 组件销毁时，也及时销毁编辑器
onBeforeUnmount(() => {
    const editor = editorRef.value
    if (editor == null) return
    editor.destroy()
})

const handleCreated = (editor) => {
    editorRef.value = editor // 记录 editor 实例，重要！
}

const handleBlur = (editor: { getHtml: () => any }) => {
    // console.log('blur', editor.getHtml())
    emits('onSuccess', editor.getHtml())
}

// 编辑相关
watch(
    () => props.detail,
    val => {
        if (val) {
            valueHtml.value = val
        }
    },
)
</script>

<style lang="scss" scoped>
.editor-container {
    border: 1px solid #dedfe6;
}
</style>