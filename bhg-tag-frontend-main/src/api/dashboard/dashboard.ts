import { Post } from '@/server/server'
const methods = {
  queryDashboardClients: '/beaver-admin/dashboard/queryDashboardClients',
  queryDashboardNum: '/beaver-admin/dashboard/queryDashboardNum',
  queryInvestment: '/beaver-admin/dashboard/queryInvestment'
}

/**
 * @description queryDashboardClients
 * @param query 入参
 */
export function queryDashboardClients<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.queryDashboardClients, query)
}

/**
 * @description queryDashboardNum
 * @param query 入参
 */
export function queryDashboardNum<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.queryDashboardNum, query)
}

/**
 * @description queryInvestment
 * @param query 入参
 */
export function queryDashboardInvestment<T = any>(query: AnyObj): ApiResponse<T> {
  return Post(methods.queryInvestment, query)
}

export const dashboardApi = {
  queryDashboardClients,
  queryDashboardNum,
  queryDashboardInvestment
}
