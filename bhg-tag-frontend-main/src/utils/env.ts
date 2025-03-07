/*
 * @Author: taoyongjian taoyongjian-zf@bjebc.com
 * @Date: 2023-01-20 14:15:04
 * @LastEditors: taoyongjian taoyongjian-zf@bjebc.com
 * @LastEditTime: 2023-01-22 21:35:57
 * @FilePath: /union-ums-h5/src/utils/env.ts
 * @Description:
 *
 * Copyright (c) 2023 by gome, All Rights Reserved.
 */

/**
 * @description:  根据定义的属性返回封装的环境变量
 */
function wrapperEnvFn() {
  const env = import.meta.env
  const ret: any = {}
  return function () {
    for (const envName of Object.keys(env)) {
      let realName = env[envName]
      realName = realName === "true" ? true : realName === "false" ? false : realName
      //启动端口
      if (envName === "VITE_PORT") {
        realName = Number(realName)
      }
      ret[envName] = realName
    }
    return ret
  }
}

export const wrapperEnv = wrapperEnvFn()()
