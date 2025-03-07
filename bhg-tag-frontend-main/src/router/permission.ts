import router from '@/router'
import { RouteLocationNormalized } from 'vue-router'
import { useUserStoreHook } from '@/stores/modules/user'
import { whiteList } from '@/config/white-list'
import NProgress from 'nprogress'
import 'nprogress/nprogress.css'
import { usePermissionStoreHook } from '@/stores/modules/permission'
import routers from '@/router'

NProgress.configure({ showSpinner: false })

router.beforeEach(async (to: RouteLocationNormalized, _: RouteLocationNormalized, next: any) => {
  NProgress.start()
  const userStore = useUserStoreHook()
  const permissionStore = usePermissionStoreHook()

  // 判断该用户是否登录
  if (userStore.token) {
    if (to.path === '/login') {
      // 如果登录，并准备进入 Login 页面，则重定向到主页
      next({ path: '/' })
      NProgress.done()
    } else {
      if (permissionStore.routes.length <= 0) {
        try {
          const roles = userStore.roles
          // 根据角色生成可访问的 Routes（可访问路由 = 常驻路由 + 有访问权限的动态路由）
          permissionStore.setRoutes(roles)
          // 将'有访问权限的动态路由' 添加到 Router 中
          permissionStore.dynamicRoutes.forEach((route) => {
            // console.log(route)
            routers.addRoute(route)
          })
          // 确保添加路由已完成
          // 设置 replace: true, 因此导航将不会留下历史记录
          next({ ...to, replace: true })
        } catch (err: any) {
          console.log(err)
          next('/login')
          NProgress.done()
        }
      } else {
        next()
      }
    }
  } else {
    // 如果没有 Token
    if (whiteList.indexOf(to.path) !== -1) {
      // 如果在免登录的白名单中，则直接进入
      next()
    } else {
      // 其他没有访问权限的页面将被重定向到登录页面
      next('/login')
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  NProgress.done()
})
