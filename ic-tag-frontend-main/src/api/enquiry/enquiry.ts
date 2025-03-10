import { Post } from '@/server/server'
import { request } from '@/server/download'

const methods = {
  queryEnquiries: '/beaver-admin/enquiries/queryEnquiries',
  queryEnquiryById: '/beaver-admin/enquiries/queryEnquiryById',
  exportEnquiriesCsv: '/beaver-admin/enquiries/exportEnquiriesCsv',
  exportEnquiriesJson: '/beaver-admin/enquiries/exportJson',
  exportEnquiriesXml: '/beaver-admin/enquiries/exportXml'
}

/**
 * @description 查询Enquiries
 * @param query 入参
 */
export function queryEnquiries<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryEnquiries, query, params)
}

/**
 * @description 根据ID查询Enquiries
 * @param query 入参
 */
export function queryEnquiryById<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryEnquiryById, query, params)
}

/**
 * @description exportEnquiriesCsv
 * @param query 入参
 */
export function exportEnquiriesCsv(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportEnquiriesCsv, data, params, responseType })
}

/**
 * @description exportEnquiriesJson
 * @param query 入参
 */
export function exportEnquiriesJson(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportEnquiriesJson, data, params, responseType })
}

/**
 * @description exportEnquiriesXml
 * @param query 入参
 */
export function exportEnquiriesXml(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportEnquiriesXml, data, params, responseType })
}

export const enquiryApi = {
  queryEnquiries,
  queryEnquiryById,
  exportEnquiriesCsv,
  exportEnquiriesJson,
  exportEnquiriesXml
}
