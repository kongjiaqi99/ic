import { useUserStoreHook } from '@/stores/modules/user'

import { permissionsList } from '@/config/permissions'
export function useRole() {
  const userStoreHook = useUserStoreHook()
  const { roles } = storeToRefs(userStoreHook)

  function getPermissionsWhite(permissionRoles: any) {
    const findItem: AnyObj = permissionsList.find((item) => {
      return item.name === permissionRoles
    })
    const hasPermission = findItem.white.some((role: any) => {
      return roles.value.includes(role)
    })
    return hasPermission
  }

  return { getPermissionsWhite }
}
