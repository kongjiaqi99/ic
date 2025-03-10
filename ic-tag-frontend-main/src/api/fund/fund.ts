import { Post } from '@/server/server'
import { request } from '@/server/download'

const methods = {
  createFund: '/beaver-admin/funds/createFund',
  editFund: '/beaver-admin/funds/editFund',
  delFund: '/beaver-admin/funds/delFund',
  queryFundById: '/beaver-admin/funds/queryFundById',
  queryFundByIdWhenEdit: '/beaver-admin/funds/queryFundByIdWhenEdit',
  queryFunds: '/beaver-admin/funds/queryFunds',
  exportFundsCsv: '/beaver-admin/funds/exportFundsCsv',
  exportFundsJson: '/beaver-admin/funds/exportJson',
  exportFundsXml: '/beaver-admin/funds/exportXml'
}

/**
 * @description 添加fund
 * @param query 入参
 */
export function createFund<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.createFund, query, params)
}

/**
 * @description editFund
 * @param query 入参
 */
export function editFund<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.editFund, query, params)
}

/**
 * @description delFund
 * @param query 入参
 */
export function delFund<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.delFund, query, params)
}

/**
 * @description queryFundById
 * @param query 入参
 */
export function queryFundById<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryFundById, query, params)
}

/**
 * @description queryFundByIdWhenEdit
 * @param query 入参
 */
export function queryFundByIdWhenEdit<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryFundByIdWhenEdit, query, params)
}

/**
 * @description queryFunds
 * @param query 入参
 */
export function queryFunds<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryFunds, query, params)
}

/**
 * @description exportFundsCsv
 * @param query 入参
 */
export function exportFundsCsv(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportFundsCsv, data, params, responseType })
}

/**
 * @description exportFundsJson
 * @param query 入参
 */
export function exportFundsJson(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportFundsJson, data, params, responseType })
}

/**
 * @description exportFundsXml
 * @param query 入参
 */
export function exportFundsXml(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportFundsXml, data, params, responseType })
}

export const fundApi = {
  createFund,
  editFund,
  delFund,
  queryFundById,
  queryFundByIdWhenEdit,
  queryFunds,
  exportFundsCsv,
  exportFundsJson,
  exportFundsXml
}
