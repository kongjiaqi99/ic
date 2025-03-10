import { Post } from '@/server/server'
const methods = {
  userLogin: '/beaver-admin/admin-users/login',
  sendPasswordResetEmail: '/beaver-admin/admin-users/sendPasswordResetEmail',
  resetPwdFromEmail: '/beaver-admin/admin-users/resetPwdFromEmail',
  logout: '/beaver-admin/admin-users/logout'
}

/**
 * @description 用户登录方法
 * @param query 入参
 */
export function userLogin<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.userLogin, query)
}

/**
 * @description sendPasswordResetEmail
 * @param query 入参
 */
export function sendPasswordResetEmail<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.sendPasswordResetEmail, query)
}

/**
 * @description resetPwdFromEmail
 * @param query 入参
 */
export function resetPwdFromEmail<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.resetPwdFromEmail, query)
}

/**
 * @description logout
 * @param query 入参
 */
export function logout<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.logout, query)
}

export const userApi = {
  userLogin,
  sendPasswordResetEmail,
  resetPwdFromEmail,
  logout
}
