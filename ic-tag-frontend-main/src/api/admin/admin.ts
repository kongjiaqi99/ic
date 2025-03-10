import { Post } from '@/server/server'
const methods = {
  queryAdminUsers: '/beaver-admin/admin-users/queryAdminUsers',
  queryAdminById: '/beaver-admin/admin-users/queryAdminById',
  exportAdminUsersCsv: '/beaver-admin/admin-users/exportAdminUsersCsv',
  queryAdminByIdWhenEdit: '/beaver-admin/admin-users/queryAdminByIdWhenEdit',
  queryRoles: '/beaver-admin/admin-users/queryRoles',
  createAdminUser: '/beaver-admin/admin-users/createAdminUser',
  delAdmin: '/beaver-admin/admin-users/delAdmin',
  editAdmin: '/beaver-admin/admin-users/editAdmin'
}

/**
 * @description 查询管理员列表
 * @param query 入参
 */
export function queryAdminUsers<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryAdminUsers, query, params)
}

/**
 * @description 查询管理员详情
 * @param query 入参
 */
export function queryAdminById<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryAdminById, query, params)
}

/**
 * @description 创建管理员
 * @param query 入参
 */
export function createAdminUser<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.createAdminUser, query, params)
}

/**
 * @description 删除管理员
 * @param query 入参
 */
export function delAdmin<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.delAdmin, query, params)
}

/**
 * @description 编辑管理员
 * @param query 入参
 */
export function editAdmin<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.editAdmin, query, params)
}

/**
 * @description 查询管理员权限
 * @param query 入参
 */
export function queryRoles<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryRoles, query, params)
}

/**
 * @description 查询管理员并修改
 * @param query 入参
 */
export function queryAdminByIdWhenEdit<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryAdminByIdWhenEdit, query, params)
}

export const adminApi = {
  queryAdminUsers,
  queryAdminById,
  createAdminUser,
  delAdmin,
  editAdmin,
  queryRoles,
  queryAdminByIdWhenEdit
}
