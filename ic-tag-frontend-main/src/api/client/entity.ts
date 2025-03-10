import { Post } from '@/server/server'
const methods = {
  queryEntity: '/beaver-admin/clients/queryEntity',
  createEntity: '/beaver-admin/clients/createEntity',
  editEntity: '/beaver-admin/clients/editEntity'
}

/**
 * @description queryEntity
 * @param query 入参
 */
export function queryEntity<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryEntity, query, params)
}

/**
 * @description createEntity
 * @param query 入参
 */
export function createEntity<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.createEntity, query, params)
}

/**
 * @description editEntity
 * @param query 入参
 */
export function editEntity<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.editEntity, query, params)
}

export const entityApi = {
  queryEntity,
  createEntity,
  editEntity
}
