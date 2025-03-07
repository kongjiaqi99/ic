import { Post } from '@/server/server'
import { request } from '@/server/download'

const methods = {
  queryEvents: '/beaver-admin/events/queryEvents',
  queryEventTrans: '/beaver-admin/events/queryEventTrans',
  queryEventById: '/beaver-admin/events/queryEventById',
  delEvent: '/beaver-admin/events/delEvent',
  editEvent: '/beaver-admin/events/editEvent',
  queryEventByIdWhenEdit: '/beaver-admin/events/queryEventByIdWhenEdit',
  createEvent: '/beaver-admin/events/createEvent',
  exportEventsCsv: '/beaver-admin/events/exportEventsCsv',
  exportEventsJson: '/beaver-admin/events/exportJson',
  exportEventsXml: '/beaver-admin/events/exportXml'
}

/**
 * @description 查询Event
 * @param query 入参
 */
export function queryEvents<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryEvents, query, params)
}

/**
 * @description queryEventTrans
 * @param query 入参
 */
export function queryEventTrans<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryEventTrans, query, params)
}

/**
 * @description queryEventById
 * @param query 入参
 */
export function queryEventById<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryEventById, query, params)
}

/**
 * @description delEvent
 * @param query 入参
 */
export function delEvent<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.delEvent, query, params)
}

/**
 * @description editEvent
 * @param query 入参
 */
export function editEvent<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.editEvent, query, params)
}

/**
 * @description queryEventByIdWhenEdit
 * @param query 入参
 */
export function queryEventByIdWhenEdit<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.queryEventByIdWhenEdit, query, params)
}

/**
 * @description createEvent
 * @param query 入参
 */
export function createEvent<T = any>(query: AnyObj, params?: AnyObj): ApiResponse<T> {
  return Post(methods.createEvent, query, params)
}

/**
 * @description exportEventsCsv
 * @param query 入参
 */
export function exportEventsCsv(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportEventsCsv, data, params, responseType })
}

/**
 * @description exportEventsJson
 * @param query 入参
 */
export function exportEventsJson(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportEventsJson, data, params, responseType })
}

/**
 * @description exportEventsXml
 * @param query 入参
 */
export function exportEventsXml(params: any) {
  const responseType = 'blob'
  const data = {}
  return request({ url: methods.exportEventsXml, data, params, responseType })
}

export const eventApi = {
  queryEvents,
  queryEventTrans,
  queryEventById,
  delEvent,
  editEvent,
  queryEventByIdWhenEdit,
  createEvent,
  exportEventsCsv,
  exportEventsJson,
  exportEventsXml
}
