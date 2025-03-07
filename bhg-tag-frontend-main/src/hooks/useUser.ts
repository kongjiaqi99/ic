import { useUserStoreHook } from '@/stores/modules/user'

export function useUser() {
  const userStoreHook = useUserStoreHook()

  const { token, roles, adminEmail } = storeToRefs(userStoreHook)

  const router = useRouter()

  /**
   * @description 设置管理员信息
   */
  const setUserInfo = (item: IUserState) => {
    return userStoreHook.login(item)
  }

  /**
   * @description 设置管理员信息
   */
  const loginOut = async () => {
    const [e, r] = await api.logout({})
    if (!e && r) {
      userStoreHook.logout()
      localStorage.removeItem('g-recaptcha-response')
      router.push({
        path: '/login'
      })
    }
  }

  return { token, roles, adminEmail, setUserInfo, loginOut }
}
