import { Directive } from 'vue'
import { useRole } from '@/hooks/useRole'

/** 权限指令 */
export const permission: Directive = {
  mounted(el, binding) {
    const { value } = binding
    const { getPermissionsWhite } = useRole()
    if (value && value.length > 0) {
      const permissionRoles = value
      const hasPermission = getPermissionsWhite(permissionRoles)
      if (!hasPermission) {
        el.style.display = 'none'
      }
    } else {
      throw new Error(`need roles! Like v-permission="['admin','editor']"`)
    }
  }
}
