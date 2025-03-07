import axios from 'axios'
import { wrapperEnv } from '@/utils/env'

const { VITE_APP_BASE_URL } = wrapperEnv
const instance = axios.create({
  timeout: 1000 * 30,
  headers: {
    'Content-Type': 'application/json; charset=utf-8'
  }
})

instance.interceptors.request.use(
  (config) => {
    config.headers['token'] = localStorage.getItem('token') || '' // add token to header
    return config
  },
  (error) => {
    return Promise.reject(error)
  }
)

function request({ url, data, params, responseType, method = 'get' }) {
  const newUrl = `${VITE_APP_BASE_URL}${url}`
  url = newUrl
  return axios({
    url,
    data,
    params,
    responseType,
    method
  }).then((res) => {
    return Promise.resolve(res.data)
  })
}

export { request }
