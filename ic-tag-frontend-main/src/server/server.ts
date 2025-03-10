import axios from 'axios'

import {
  handleChangeRequestHeader,
  handleConfigureAuth,
  handleAuthError,
  handleGeneralError,
  handleNetworkError
} from './tools'

import { wrapperEnv } from '@/utils/env'

const { VITE_APP_BASE_URL } = wrapperEnv

type Fn = (data: FcResponse<any>) => unknown

interface IAnyObj {
  [index: string]: unknown
}

interface FcResponse<T> {
  errno: string
  errMsg: string
  data: T
}

axios.interceptors.request.use((config) => {
  config = handleChangeRequestHeader(config)
  config = handleConfigureAuth(config)
  return config
})

axios.interceptors.response.use(
  (response) => {
    // console.log(response)

    if (response.status !== 200 && response.status !== 201) return Promise.reject(response.data)
    handleAuthError(response.data.errorCode)
    handleGeneralError(response.data.errorCode, response.data.errorMessage)
    return response
  },
  (err) => {
    handleNetworkError(err.response?.status)
    Promise.reject(err?.response)
  }
)

export const Get = <T>(
  url: string,
  params: IAnyObj = {},
  clearFn?: Fn
): Promise<[any, FcResponse<T> | undefined]> =>
  new Promise((resolve) => {
    axios
      .get(`${VITE_APP_BASE_URL}${url}`, { params })
      // .get(`${url}`, { params })
      .then((result) => {
        let res: FcResponse<T>
        if (clearFn !== undefined) {
          res = clearFn(result.data) as unknown as FcResponse<T>
        } else {
          res = result?.data as FcResponse<T>
        }
        resolve([null, res as FcResponse<T>])
      })
      .catch((err) => {
        resolve([err, undefined])
      })
  })

export const Post = <T>(
  url: string,
  data: IAnyObj,
  params: IAnyObj = {}
): Promise<[any, FcResponse<T> | undefined]> => {
  return new Promise((resolve) => {
    axios
      .post(`${VITE_APP_BASE_URL}${url}`, data, { params })
      // .post(`${url}`, data, { params })
      .then((result) => {
        resolve([null, result?.data as FcResponse<T>])
      })
      .catch((err) => {
        resolve([err, undefined])
      })
  })
}
