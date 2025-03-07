import { Post } from '@/server/server'
const methods = {
  create: '/beaver-admin/notification/create',
  del: '/beaver-admin/notification/del',
  edit: '/beaver-admin/notification/edit',
  queryById: '/beaver-admin/notification/queryById',
  queryPage: '/beaver-admin/notification/queryPage'
}

/**
 * @description createNotification
 * @param query 入参
 */
export function createNotification<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.create, query, params)
}

/**
 * @description delNotification
 * @param query 入参
 */
export function delNotification<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.del, query, params)
}

/**
 * @description editNotification
 * @param query 入参
 */
export function editNotification<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.edit, query, params)
}

/**
 * @description queryNotificationById
 * @param query 入参
 */
export function queryNotificationById<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryById, query, params)
}

/**
 * @description queryNotificationPage
 * @param query 入参
 */
export function queryNotificationPage<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryPage, query, params)
}

export const notificationApi = {
  createNotification,
  delNotification,
  editNotification,
  queryNotificationById,
  queryNotificationPage
}
