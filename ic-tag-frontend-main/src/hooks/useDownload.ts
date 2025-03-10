import { ElMessage } from 'element-plus'
import dayjs from 'dayjs'
export function useDownLoad() {
  function downloadFile(res: any, str: string, name: string) {
    ElMessage.success('download success')
    const a = document.createElement('a')
    a.style.display = 'none'
    const date = dayjs().format('YYYY-MM-DD')
    a.setAttribute('download', `${name}-${date}.${str}`)
    a.setAttribute('href', window.URL.createObjectURL(new Blob([res])))
    document.body.appendChild(a)
    a.click()
    document.body.removeChild(a)
  }
  return { downloadFile }
}
