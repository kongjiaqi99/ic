import type { InjectionKey, Ref } from 'vue'

interface NotificationState {
  nId: Ref<string>
}

/**
 * @description Popup InjectionKey Symbol
 */
export const NotificationKey: InjectionKey<NotificationState> = Symbol('notification')
