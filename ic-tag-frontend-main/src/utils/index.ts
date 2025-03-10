import type { InjectionKey } from 'vue'
import { inject } from 'vue'

/**
 * @description:  处理inject注入属性 undefined 问题
 */
export function injectStrict<T>(key: InjectionKey<T>, fallback?: T) {
  const resolved = inject(key, fallback)
  if (!resolved) {
    throw new Error(`Could not resolve ${key.description}`)
  }
  return resolved
}

/**
 * @description:  深拷贝方法
 * @param source 需要拷贝的源
 */
export function deepClone<T>(source: T): T {
  return Array.isArray(source)
    ? source.map((item) => deepClone(item))
    : source instanceof Date
    ? new Date(source.getTime())
    : source && typeof source === 'object'
    ? Object.getOwnPropertyNames(source).reduce(
        (o, prop) => {
          Object.defineProperty(o, prop, Object.getOwnPropertyDescriptor(source, prop)!)
          o[prop] = deepClone((source as { [key: string]: any })[prop])
          return o
        },
        Object.create(Object.getPrototypeOf(source))
      )
    : (source as T)
}

/**
 * @description: 返回网络路径的文件名
 */
export function getFilenameFromUrl(url: string) {
  // const pathname = new URL(url).pathname
  const index = url.lastIndexOf('/')
  return -1 !== index ? url.substring(index + 1) : url
}
