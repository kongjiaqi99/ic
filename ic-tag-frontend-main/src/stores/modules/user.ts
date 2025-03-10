import store from '@/stores'
import { defineStore } from 'pinia'
import { resetRouter } from '@/router'

export const useUserStore = defineStore('storeUser', {
  state: (): IUserState => {
    return {
      token: '',
      roles: [],
      adminEmail: ''
    }
  },
  actions: {
    /** 设置角色数组 */
    setRoles(roles: string[]) {
      this.roles = roles
    },
    /** 登录 */
    login(userInfo: IUserState) {
      this.token = userInfo.token
      this.roles = userInfo.roles
      this.adminEmail = userInfo.adminEmail
    },
    /** 登出 */
    logout() {
      this.token = ''
      this.roles = []
      this.adminEmail = ''
      resetRouter()
    },
    /** 重置 Token */
    resetToken() {
      this.token = ''
      this.roles = []
    }
  },
  persist: {
    enabled: true,
    strategies: [
      { storage: localStorage } // name 字段用localstorage存储
    ]
  }
})

/** 在 setup 外使用 */
export function useUserStoreHook() {
  return useUserStore(store)
}
