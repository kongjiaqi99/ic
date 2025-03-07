import { fileURLToPath, URL } from 'node:url'
import { defineConfig, loadEnv } from 'vite'
import type { UserConfig, ConfigEnv } from 'vite'
import vue from '@vitejs/plugin-vue'
import AutoImport from 'unplugin-auto-import/vite'
import Components from 'unplugin-vue-components/vite'
import {
  ElementPlusResolver
  // AntDesignVueResolver,
  // VantResolver,
  // HeadlessUiResolver,
  // ElementUiResolver
} from 'unplugin-vue-components/resolvers'
import { wrapperEnv } from './build/utils'

// https://vitejs.dev/config/
export default defineConfig(({ mode }: ConfigEnv): UserConfig => {
  const root = process.cwd()
  const env = loadEnv(mode, root)
  const viteEnv = wrapperEnv(env)
  const { VITE_PORT, VITE_DROP_CONSOLE, VITE_WEB_ENV } = viteEnv
  return {
    plugins: [
      AutoImport({
        dts: 'src/auto-imports.d.ts', // 可以自定义文件生成的位置，默认是根目录下
        imports: ['vue', 'pinia', 'vue-router'],
        dirs: ['./src/api'],
        eslintrc: {
          enabled: true, // Default `false`
          filepath: './.eslintrc-auto-import.json', // Default `./.eslintrc-auto-import.json`
          globalsPropValue: 'readonly' // Default `true`, (true | false | 'readonly' | 'readable' | 'writable' | 'writeable')
        }
      }),
      Components({
        dirs: ['src/components/base'], // 目标文件夹
        extensions: ['vue', 'jsx'], // 文件类型
        dts: 'src/components.d.ts', // 输出文件，里面都是一些import的组件键值对
        // ui库解析器，也可以自定义，需要安装相关UI库
        resolvers: [
          // VantResolver(),
          ElementPlusResolver()
          // AntDesignVueResolver(),
          // HeadlessUiResolver(),
          // ElementUiResolver()
        ]
      }),
      vue()
    ],
    css: {
      preprocessorOptions: {
        scss: {
          additionalData:
            VITE_WEB_ENV === 'bhg' ? `@import "@/style/bhg.scss";` : `@import "@/style/bcuc.scss";`
        }
      }
    },
    resolve: {
      alias: {
        '@': fileURLToPath(new URL('./src', import.meta.url))
      }
    },
    server: {
      /** 是否开启 HTTPS */
      https: false,
      /** 设置 host: true 才可以使用 Network 的形式，以 IP 访问项目 */
      host: true, // host: "0.0.0.0"
      /** 端口号 */
      port: VITE_PORT,
      /** 是否自动打开浏览器 */
      open: false,
      /** 跨域设置允许 */
      cors: true,
      /** 端口被占用时，是否直接退出 */
      strictPort: false
      /** 接口代理 */
      // proxy: {
      //   '/beaver-admin': {
      //     target: 'https://bk.admin.bhgglobal.com.au',
      //     // ws: true,
      //     /** 是否允许跨域 */
      //     changeOrigin: true,
      //     // rewrite: (path) => console.log(path)
      //     bypass(req, res, options) {
      //       console.log(req.url, options.target)
      //     }
      //   }
      // }
    },
    base: './',
    esbuild: {
      pure: VITE_DROP_CONSOLE ? ['console.log', 'debugger'] : []
    }
  }
})
