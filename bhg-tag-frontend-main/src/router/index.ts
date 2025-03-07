import { createRouter, createWebHashHistory, RouteRecordRaw } from 'vue-router'
import dashboard from '@/assets/icon/dashboard.png'
import referral from '@/assets/icon/referral.png'
import enquiry from '@/assets/icon/enquiry.png'
import investment from '@/assets/icon/investment.png'
import client from '@/assets/icon/client.png'
import audit from '@/assets/icon/audit.png'
import notification from '@/assets/icon/notification.png'
import event from '@/assets/icon/event.png'
import admin from '@/assets/icon/admin.png'
import fund from '@/assets/icon/fund.png'
import log from '@/assets/icon/log.png'
import tag from '@/assets/icon/tag.png'

const Layout = () => import('@/layout/index.vue')

/** 常驻路由 */
export const constantRoutes: Array<RouteRecordRaw> = [
  {
    path: '/login',
    component: () => import('@/views/login/index.vue'),
    meta: {
      hidden: true
    }
  }
]

/**
 * 动态路由
 * 用来放置有权限 (Roles 属性) 的路由
 * 必须带有 Name 属性
 */
export const asyncRoutes: Array<RouteRecordRaw> = [
  {
    path: '/',
    component: Layout,
    redirect: '/dashboard',
    meta: {
      hidden: false,
      name: 'Dashboard',
      icon: dashboard,
      roles: ['superAdmin', 'fundAdmin', 'fundOperation']
    },
    children: [
      {
        path: 'dashboard',
        component: () => import('@/views/dashboard/index.vue'),
        name: 'Dashboard',
        meta: {
          title: '首页',
          icon: 'dashboard',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/client',
    component: Layout,
    redirect: '/client/index',
    meta: {
      hidden: false,
      name: 'Client',
      icon: client,
      roles: ['superAdmin', 'fundAdmin', 'fundOperation']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/client/index.vue'),
        name: 'Client',
        meta: {
          title: 'Client',
          icon: 'Client',
          affix: true,
          keepAlive: false
        }
      },
      {
        path: 'detail/:id',
        component: () => import('@/views/client/detail.vue'),
        name: 'Client ',
        meta: {
          title: 'Detail',
          icon: 'Detail',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/visitor',
    component: Layout,
    redirect: '/visitor/index',
    meta: {
      hidden: false,
      name: 'Visitor',
      icon: client,
      roles: ['superAdmin', 'fundAdmin', 'fundOperation']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/client/visitor.vue'),
        name: 'Visitor',
        meta: {
          title: 'Visitor',
          icon: 'Visitor',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/fund',
    component: Layout,
    redirect: '/fund/index',
    meta: {
      hidden: false,
      name: 'Fund',
      icon: fund,
      roles: ['superAdmin', 'fundAdmin', 'fundOperation']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/fund/index.vue'),
        name: 'Fund',
        meta: {
          title: 'Fund',
          icon: 'Fund',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/investment',
    component: Layout,
    redirect: '/investment/index',
    meta: {
      hidden: false,
      name: 'Investment',
      icon: investment,
      roles: ['superAdmin', 'fundAdmin', 'fundOperation']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/investment/index.vue'),
        name: 'Investment',
        meta: {
          title: 'Investment',
          icon: 'Investment',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/referral',
    component: Layout,
    redirect: '/referral/index',
    meta: {
      hidden: false,
      name: 'Referral',
      icon: referral,
      roles: ['superAdmin']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/referral/index.vue'),
        name: 'Referral',
        meta: {
          title: 'Referral',
          icon: 'Referral',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/enquiry',
    component: Layout,
    redirect: '/enquiry/index',
    meta: {
      hidden: false,
      name: 'Enquiry',
      icon: enquiry,
      roles: ['superAdmin', 'fundAdmin', 'fundOperation', 'webAdmin']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/enquiry/index.vue'),
        name: 'Enquiry',
        meta: {
          title: 'Enquiry',
          icon: 'Enquiry',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/event',
    component: Layout,
    redirect: '/event/index',
    meta: {
      hidden: false,
      name: 'Event',
      icon: event,
      roles: ['superAdmin', 'fundAdmin', 'fundOperation', 'webAdmin']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/event/index.vue'),
        name: 'Event',
        meta: {
          title: 'Event',
          icon: 'Event',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/audit',
    component: Layout,
    redirect: '/audit/index',
    meta: {
      hidden: false,
      name: 'Audit',
      icon: audit,
      roles: ['superAdmin', 'fundAdmin', 'fundOperation']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/audit/index.vue'),
        name: 'Audit',
        meta: {
          title: 'Audit',
          icon: 'Audit',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/notification',
    component: Layout,
    redirect: '/notification/index',
    meta: {
      hidden: false,
      name: 'Notification',
      icon: notification,
      roles: ['superAdmin', 'fundAdmin', 'fundOperation', 'webAdmin']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/notification/index.vue'),
        name: 'Notification',
        meta: {
          title: 'Notification',
          icon: 'Notification',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/log',
    component: Layout,
    redirect: '/log/index',
    meta: {
      hidden: false,
      name: 'Log',
      icon: log,
      roles: ['superAdmin']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/log/index.vue'),
        name: 'Log',
        meta: {
          title: 'Log',
          icon: 'Log',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/admin',
    component: Layout,
    redirect: '/admin/index',
    meta: {
      hidden: false,
      name: 'AdminUsers',
      icon: admin,
      roles: ['superAdmin']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/admin/index.vue'),
        name: 'AdminUsers',
        meta: {
          title: 'AdminUsers',
          icon: 'AdminUsers',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },  
  {
    path: '/tag',
    component: Layout,
    redirect: '/tag/index',
    meta: {
      hidden: false,
      name: 'Tag',
      icon: tag,
      roles: ['superAdmin', 'fundAdmin', 'fundOperation', 'webAdmin']
    },
    children: [
      {
        path: 'index',
        component: () => import('@/views/tag/index.vue'),
        name: 'Tag',
        meta: {
          title: 'Tag',
          icon: 'Tag',
          affix: true,
          keepAlive: false
        }
      }
    ]
  },
  {
    path: '/:pathMatch(.*)*', // 必须将 'ErrorPage' 路由放在最后, Must put the 'ErrorPage' route at the end
    component: Layout,
    redirect: '/404',
    name: 'ErrorPage',
    meta: {
      title: '错误页面',
      icon: '404',
      hidden: true
    },
    children: [
      {
        path: '401',
        component: () => import('@/views/error-page/401.vue'),
        name: '401',
        meta: {
          title: '401'
        }
      },
      {
        path: '404',
        component: () => import('@/views/error-page/404.vue'),
        name: '404',
        meta: {
          title: '404'
        }
      }
    ]
  }
]

const router = createRouter({
  history: createWebHashHistory(import.meta.env.BASE_URL),
  routes: constantRoutes
})

/** 重置路由 */
export function resetRouter() {
  // 注意：所有动态路由路由必须带有 Name 属性，否则可能会不能完全重置干净
  try {
    router.getRoutes().forEach((route: any) => {
      const { name, meta } = route
      if (name && meta.roles?.length) {
        router.hasRoute(name) && router.removeRoute(name)
      }
    })
  } catch (error) {
    // 强制刷新浏览器，不过体验不是很好
    window.location.reload()
  }
}

export default router
