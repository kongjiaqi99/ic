import { Get, Post } from '@/server/server'

const methods = {
  queryTags: '/beaver-admin/tags/',
  queryTagById: '/beaver-admin/tags/detail',
  addTag: '/beaver-admin/tags/create',
  updateTag: '/beaver-admin/tags/update',
  deleteTag: '/beaver-admin/tags/delete',

  addFundToTag: '/beaver-admin/fundtags/add',
  getFundsWithTags: '/beaver-admin/fundtags/',
  getNonTaggedFunds: '/beaver-admin/fundtags/nonTagged',
  deleteTagFunds: '/beaver-admin/fundtags/delete',
  getFundTagsDetail: '/beaver-admin/fundtags/detail',
  updateFundToTag: '/beaver-admin/fundtags/edit'
}
/**
 * @description 查询Tags
 * @param query 入参
 */
export function queryTags<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Get(methods.queryTags, query)
}
/**
 * @description 根据ID查询Tags
 * @param query 入参
 */
export function queryTagById<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Get(methods.queryTagById, query)
}
/**
 * @description 添加Tag
 * @param query 入参
 */
export function addTag<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.addTag, query, params)
}
/**
 * @description 更新Tag
 * @param query 入参
 */
export function updateTag<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.updateTag, query, params)
}
/**
 * @description 删除Tag
 * @param query 入参
 */
export function deleteTag<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.deleteTag, query, params)
}

/**
 * @description 添加FundToTag
 * @param query 入参
 */
export function addFundToTag<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.addFundToTag, query, params)
}

/**
 * @description 删除deleteTagFunds
 * @param query 入参
 */
export function deleteTagFunds<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.deleteTagFunds, query, params)
}

/**
 * @description 查询getFundTagsDetail
 * @param query 入参
 */
export function getFundTagsDetail<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.getFundTagsDetail, query, params)
}

/**
 * @description 查询getFundTagsDetail
 * @param query 入参
 */
export function updateFundToTag<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.updateFundToTag, query, params)
}

/**
 * @description 查询FundWithTags
 * @param query 入参
 */
export function getFundsWithTags<T = any>(query: AnyObj): ApiResponse<T> {
  return Get(methods.getFundsWithTags, query)
}

/**
 * @description 查询NonTaggedFunds
 * @param query 入参
 */
export function getNonTaggedFunds<T = any>(query: AnyObj): ApiResponse<T> {
  return Get(methods.getNonTaggedFunds, query)
}
export const tagApi = {
  queryTags,
  queryTagById,
  addTag,
  updateTag,
  deleteTag,
  addFundToTag,
  getFundsWithTags,
  getNonTaggedFunds,
  deleteTagFunds,
  getFundTagsDetail,
  updateFundToTag
}
