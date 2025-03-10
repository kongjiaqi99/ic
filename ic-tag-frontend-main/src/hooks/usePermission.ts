import { usePermissionStoreHook } from '@/stores/modules/permission'

export function usePermission() {
  const permissionStoreHook = usePermissionStoreHook()

  const { routes } = storeToRefs(permissionStoreHook)

  return { routes }
}
