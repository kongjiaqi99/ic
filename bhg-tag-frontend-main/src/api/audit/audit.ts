import { Post } from '@/server/server'
const methods = {
  queryPage: '/beaver-admin/audit/queryPage',
  edit: '/beaver-admin/audit/edit',
  queryById: '/beaver-admin/audit/queryById',
  queryOperateLogPage: '/beaver-admin/audit/queryOperateLogPage'
}

/**
 * @description queryAudit
 * @param query 入参
 */
export function queryAudit<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryPage, query, params)
}

/**
 * @description queryAudit
 * @param query 入参
 */
export function editAudit<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.edit, query, params)
}

/**
 * @description queryAuditById
 * @param query 入参
 */
export function queryAuditById<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryById, query, params)
}

/**
 * @description queryOperateLogPage
 * @param query 入参
 */
export function queryOperateLogPage<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryOperateLogPage, query, params)
}

export const auditApi = {
  queryAudit,
  editAudit,
  queryAuditById,
  queryOperateLogPage
}
