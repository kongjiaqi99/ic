import { Post } from '@/server/server'
import { request } from '@/server/download'
const methods = {
  queryReferral: '/beaver-admin/financings/queryFinancings',
  queryReferralById: '/beaver-admin/financings/queryFinancingById',
  queryReferralByIdWhenEdit: '/beaver-admin/financings/queryFinancingByIdWhenEdit',
  delReferral: '/beaver-admin/financings/delFinancing',
  createReferral: '/beaver-admin/financings/createFinancing',
  updateReferral: '/beaver-admin/financings/updateFinancing',
  queryFinancingById: '/beaver-admin/financings/queryFinancingById',
  financingsExportPdf: '/beaver-admin/financings/exportPdf',
  exportFinancingsCsv: '/beaver-admin/financings/exportFinancingsCsv',
  exportFinancingsJson: '/beaver-admin/financings/exportJson',
  exportFinancingsXml: '/beaver-admin/financings/exportXml'
}

/**
 * @description queryReferral
 * @param query 入参
 */
export function queryReferral<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryReferral, query, params)
}

/**
 * @description queryReferralById
 * @param query 入参
 */
export function queryReferralById<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryReferralById, query, params)
}

/**
 * @description queryReferralByIdWhenEdit
 * @param query 入参
 */
export function queryReferralByIdWhenEdit<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryReferralByIdWhenEdit, query, params)
}

/**
 * @description delReferral
 * @param query 入参
 */
export function delReferral<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.delReferral, query, params)
}

/**
 * @description createReferral
 * @param query 入参
 */
export function createReferral<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.createReferral, query, params)
}

/**
 * @description updateReferral
 * @param query 入参
 */
export function updateReferral<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.updateReferral, query, params)
}

/**
 * @description queryFinancingById
 * @param query 入参
 */
export function queryFinancingById<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryFinancingById, query, params)
}

/**
 * @description financingsExportPdf
 * @param query 入参
 */
export function financingsExportPdf(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.financingsExportPdf, data, params, responseType })
}

/**
 * @description exportFinancingsCsv
 * @param query 入参
 */
export function exportFinancingsCsv(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportFinancingsCsv, data, params, responseType })
}

/**
 * @description exportFinancingsJson
 * @param query 入参
 */
export function exportFinancingsJson(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportFinancingsJson, data, params, responseType })
}

/**
 * @description exportFinancingsXml
 * @param query 入参
 */
export function exportFinancingsXml(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportFinancingsXml, data, params, responseType })
}

export const referralApi = {
  queryReferral,
  queryReferralById,
  queryReferralByIdWhenEdit,
  delReferral,
  createReferral,
  updateReferral,
  queryFinancingById,
  financingsExportPdf,
  exportFinancingsCsv,
  exportFinancingsJson,
  exportFinancingsXml
}
