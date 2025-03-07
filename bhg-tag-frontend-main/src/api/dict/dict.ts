import { Post } from '@/server/server'
const methods = {
  queryDictionary: '/beaver-admin/dictionary/queryDictionary'
}

/**
 * @description 查询字典值
 * @param query 入参
 */
export function queryDictionary<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryDictionary, query, params)
}

export const dictApi = {
  queryDictionary
}
