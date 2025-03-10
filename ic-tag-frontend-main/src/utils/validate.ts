/***
 * @description 判断是否是网址
 * @params string url - 地址
 */
export const isValidURL = (url: string) => {
  const reg =
    /^(https?|ftp):\/\/([a-zA-Z0-9.-]+(:[a-zA-Z0-9.&%$-]+)*@)*((25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9][0-9]?)(\.(25[0-5]|2[0-4][0-9]|1[0-9]{2}|[1-9]?[0-9])){3}|([a-zA-Z0-9-]+\.)*[a-zA-Z0-9-]+\.(com|edu|gov|int|mil|net|org|biz|arpa|info|name|pro|aero|coop|museum|[a-zA-Z]{2}))(:[0-9]+)*(\/($|[a-zA-Z0-9.,?'\\+&%$#=~_-]+))*$/
  return reg.test(url)
}

/***
 * @description 判断是否是邮箱地址
 * @params string str - 地址
 */
export const isEmail = (str: string) => {
  const reg = /^[a-zA-Z0-9]+[-_.]*[A-Za-z0-9]+@([a-zA-Z0-9]+[-.])+[A-Za-zd]{2,5}$/
  return reg.test(str)
}
