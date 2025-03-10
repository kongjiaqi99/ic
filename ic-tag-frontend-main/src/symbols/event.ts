import type { InjectionKey, Ref } from 'vue'

interface EventState {
  eId: Ref<string>
}

/**
 * @description Popup InjectionKey Symbol
 */
export const EventKey: InjectionKey<EventState> = Symbol('event')
