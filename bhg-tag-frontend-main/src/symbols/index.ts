import type { InjectionKey, Ref } from 'vue'

interface PopupState {
  func: (str?: string) => void
  isRefresh?: Ref<boolean>
}

/**
 * @description Popup InjectionKey Symbol
 */
export const PopupKey: InjectionKey<PopupState> = Symbol('popup')
