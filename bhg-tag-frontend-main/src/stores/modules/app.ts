import store from '@/stores'
import { defineStore } from 'pinia'

interface IAppState {
  breadcrumbList: any[]
}

export const useAppStore = defineStore('storeApp', {
  state: (): IAppState => {
    return {
      breadcrumbList: []
    }
  },
  actions: {
    /** 设置数组 */
    setBreadcrumbList(list: any[]) {
      this.breadcrumbList = list
    },
    /** 设置数组 */
    resetBreadcrumbList() {
      this.breadcrumbList = []
    }
  }
})

/** 在 setup 外使用 */
export function useAppStoreHook() {
  return useAppStore(store)
}
