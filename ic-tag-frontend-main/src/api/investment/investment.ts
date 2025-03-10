import { Post, Get } from '@/server/server'
import { request } from '@/server/download'
const methods = {
  queryPage: '/beaver-admin/investment/queryPage',
  queryGlobal: '/beaver-admin/investment/queryGlobal',
  getClientsNames: '/beaver-admin/purchased-funds/getClientsNames',
  getFundsNames: '/beaver-admin/purchased-funds/getFundsNames',
  createPurchasedFund: '/beaver-admin/purchased-funds/createPurchasedFund',
  editPurchasedFund: '/beaver-admin/purchased-funds/editPurchasedFund',
  delPurchasedFund: '/beaver-admin/purchased-funds/delPurchasedFund',
  queryPurchasedFundByIdWhenEdit: '/beaver-admin/purchased-funds/queryPurchasedFundByIdWhenEdit',
  queryPurchasedFundById: '/beaver-admin/purchased-funds/queryPurchasedFundById',
  sendUnitCertificate: '/beaver-admin/purchased-funds/sendUnitCertificate',
  sendMail: '/beaver-admin/purchased-funds/sendMail',
  queryPurchasedFunds: '/beaver-admin/purchased-funds/queryPurchasedFunds',
  exportPdf: '/beaver-admin/purchased-funds/exportPdf',
  exportUnitCertificate: '/beaver-admin/purchased-funds/exportUnitCertificate',
  investmentRecord: '/beaver-admin/investment/record',
  exportCsv: '/beaver-admin/purchased-funds/exportCsv',
  exportJson: '/beaver-admin/purchased-funds/exportJson',
  exportXml: '/beaver-admin/purchased-funds/exportXml',
  exportInvPdf: '/beaver-admin/investment/exportPdf',
  addApprove: '/beaver-admin/audit/addApprove',
  queryAnnualApprove: '/beaver-admin/audit/queryAnnualApprove'
}

/**
 * @description addApprove
 * @param query 入参
 */
export function addApprove<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.addApprove, query, params)
}

/**
 * @description queryAnnualApprove
 * @param query 入参
 */
export function queryAnnualApprove<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryAnnualApprove, query, params)
}

/**
 * @description queryInvestment
 * @param query 入参
 */
export function queryInvestment<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryPage, query, params)
}

/**
 * @description queryGlobal
 * @param query 入参
 */
export function queryGlobal<T = any>(query: AnyObj): ApiResponse<T> {
  return Get(methods.queryGlobal, query)
}

/**
 * @description getClientsNames
 * @param query 入参
 */
export function getClientsNames<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.getClientsNames, query)
}

/**
 * @description getFundsNames
 * @param query 入参
 */
export function getFundsNames<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.getFundsNames, query)
}

/**
 * @description createPurchasedFund
 * @param query 入参
 */
export function createPurchasedFund<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.createPurchasedFund, query)
}

/**
 * @description editPurchasedFund
 * @param query 入参
 */
export function editPurchasedFund<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.editPurchasedFund, query)
}

/**
 * @description delPurchasedFund
 * @param query 入参
 */
export function delPurchasedFund<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.delPurchasedFund, query)
}

/**
 * @description queryPurchasedFundByIdWhenEdit
 * @param query 入参
 */
export function queryPurchasedFundByIdWhenEdit<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.queryPurchasedFundByIdWhenEdit, query)
}

/**
 * @description queryPurchasedFundById
 * @param query 入参
 */
export function queryPurchasedFundById<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.queryPurchasedFundById, query)
}

/**
 * @description sendUnitCertificate
 * @param query 入参
 */
export function sendUnitCertificate<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.sendUnitCertificate, query)
}

/**
 * @description exportUnitCertificate
 * @param query 入参
 */
export function exportUnitCertificate<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.exportUnitCertificate, query)
}

/**
 * @description sendMail
 * @param query 入参
 */
export function sendMail<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.sendMail, query)
}

/**
 * @description queryPurchasedFunds
 * @param query 入参
 */
export function queryPurchasedFunds<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryPurchasedFunds, query, params)
}

/**
 * @description exportPdf
 * @param query 入参
 */
export function exportPdf(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportPdf, data, params, responseType })
}

/**
 * @description investmentRecord
 * @param query 入参
 */
export function investmentRecord<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.investmentRecord, query, params)
}

/**
 * @description exportCsv
 * @param query 入参
 */
export function exportCsv(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportCsv, data, params, responseType })
}

/**
 * @description exportJson
 * @param query 入参
 */
export function exportJson(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportJson, data, params, responseType })
}

/**
 * @description exportXml
 * @param query 入参
 */
export function exportXml(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportXml, data, params, responseType })
}

/**
 * @description exportInvPdf
 * @param query 入参
 */
export function exportInvPdf(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportInvPdf, data, params, responseType })
}

export const investmentApi = {
  queryInvestment,
  queryGlobal,
  getClientsNames,
  getFundsNames,
  createPurchasedFund,
  editPurchasedFund,
  delPurchasedFund,
  queryPurchasedFundByIdWhenEdit,
  queryPurchasedFundById,
  sendUnitCertificate,
  sendMail,
  queryPurchasedFunds,
  exportPdf,
  exportUnitCertificate,
  investmentRecord,
  exportXml,
  exportJson,
  exportCsv,
  exportInvPdf,
  addApprove,
  queryAnnualApprove
}
