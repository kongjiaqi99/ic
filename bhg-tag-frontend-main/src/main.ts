import { createApp, Directive } from 'vue'
// import { createPinia } from 'pinia'
import store from './stores'
import ElementPlus from 'element-plus'

import App from './App.vue'
import router from './router'
import '@/router/permission'
import * as directives from '@/directives'

import '@/style/index.scss'
import 'element-plus/dist/index.css'
import { wrapperEnv } from '@/utils/env'

const { VITE_WEB_ENV } = wrapperEnv
const app = createApp(App)

//读取配置设置不同的网站icon与title
document.title = VITE_WEB_ENV === 'bhg' ? 'BHG' : 'BCUC'
const link: any = document.querySelector("link[rel*='icon']")
link.href = VITE_WEB_ENV === 'bhg' ? './favicon.ico' : './favicon-bcuc.ico'

app.use(store)
app.use(router)
app.use(ElementPlus)
/** 自定义指令 */
Object.keys(directives).forEach((key) => {
  app.directive(key, (directives as { [key: string]: Directive })[key])
})

app.mount('#app')
