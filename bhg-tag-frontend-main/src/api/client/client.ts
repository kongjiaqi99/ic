import { Post } from '@/server/server'
import { request } from '@/server/download'
const methods = {
  queryClients: '/beaver-admin/clients/queryClients',
  queryClientDetailById: '/beaver-admin/clients/queryClientDetailById',
  createClient: '/beaver-admin/clients/createClient',
  editClient: '/beaver-admin/clients/editClient',
  resetClientPassword: '/beaver-admin/clients/resetClientPassword',
  queryUpperClients: '/beaver-admin/clients/queryUpperClients',
  exportClientsCsv: '/beaver-admin/clients/exportClientsCsv',
  exportClientsXml: '/beaver-admin/clients/exportXml',
  exportClientsJson: '/beaver-admin/clients/exportJson',
  delClient: '/beaver-admin/clients/delClient',
  queryClientDetailByIdWhenEdit: '/beaver-admin/clients/queryClientDetailByIdWhenEdit',
  queryInvestmentEntityById: '/beaver-admin/clients/queryInvestmentEntityById',
  queryInvestmentEntityByIdWhenEdit: '/beaver-admin/clients/queryInvestmentEntityByIdWhenEdit',
  queryDownwardClients: '/beaver-admin/clients/queryDownwardClients',
  queryInvestmentEntityKycById: '/beaver-admin/clients/queryInvestmentEntityKycById',
  approvedClientKyc: '/beaver-admin/clients/approvedClientKyc',
  refuseClientKyc: '/beaver-admin/clients/refuseClientKyc',
  queryVisitorLogPage: '/beaver-admin/audit/queryVisitorLogPage'
}

/**
 * @description queryClients
 * @param query 入参
 */
export function queryClients<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryClients, query, params)
}

/**
 * @description queryClientDetailById
 * @param query 入参
 */
export function queryClientDetailById<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryClientDetailById, query, params)
}

/**
 * @description createClient
 * @param query 入参
 */
export function createClient<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.createClient, query, params)
}

/**
 * @description editClient
 * @param query 入参
 */
export function editClient<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.editClient, query, params)
}

/**
 * @description resetClientPassword
 * @param query 入参
 */
export function resetClientPassword<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.resetClientPassword, query, params)
}

/**
 * @description queryUpperClients
 * @param query 入参
 */
export function queryUpperClients<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryUpperClients, query, params)
}

/**
 * @description queryUpperClients
 * @param query 入参
 */
export function delClient<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.delClient, query, params)
}

/**
 * @description queryUpperClients
 * @param query 入参
 */
export function queryClientDetailByIdWhenEdit<T = any>(
  query: AnyObj,
  params?: AnyObj
): ApiResponse<T> {
  return Post(methods.queryClientDetailByIdWhenEdit, query, params)
}

/**
 * @description queryInvestmentEntityKycById
 * @param query 入参
 */
export function queryInvestmentEntityKycById<T = any>(
  query: AnyObj,
  params?: AnyObj
): ApiResponse<T> {
  return Post(methods.queryInvestmentEntityKycById, query, params)
}

/**
 * @description approvedClientKyc
 * @param query 入参
 */
export function approvedClientKyc<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.approvedClientKyc, query, params)
}

/**
 * @description refuseClientKyc
 * @param query 入参
 */
export function refuseClientKyc<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.refuseClientKyc, query, params)
}

/**
 * @description queryVisitorLogPage
 * @param query 入参
 */
export function queryVisitorLogPage<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryVisitorLogPage, query, params)
}

/**
 * @description exportPdf
 * @param query 入参
 */
export function exportClientsCsv(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportClientsCsv, data, params, responseType })
}

/**
 * @description exportClientsXml
 * @param query 入参
 */
export function exportClientsXml(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportClientsXml, data, params, responseType })
}

/**
 * @description exportClientsJson
 * @param query 入参
 */
export function exportClientsJson(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportClientsJson, data, params, responseType })
}

export const clientApi = {
  queryClients,
  queryClientDetailById,
  createClient,
  editClient,
  resetClientPassword,
  queryUpperClients,
  delClient,
  queryClientDetailByIdWhenEdit,
  queryInvestmentEntityKycById,
  exportClientsCsv,
  exportClientsXml,
  exportClientsJson,
  approvedClientKyc,
  refuseClientKyc,
  queryVisitorLogPage
}
