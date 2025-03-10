import { useAppStoreHook } from '@/stores/modules/app'

export function useApp() {
  const appStoreHook = useAppStoreHook()

  const { breadcrumbList } = storeToRefs(appStoreHook)

  /**
   * @description 设置导航路径
   */
  const setBreadcrumbList = (item: any[]) => {
    return appStoreHook.setBreadcrumbList(item)
  }

  /**
   * @description 重置导航路径
   */
  const resetBreadcrumbList = () => {
    return appStoreHook.resetBreadcrumbList()
  }

  return { breadcrumbList, setBreadcrumbList, resetBreadcrumbList }
}
