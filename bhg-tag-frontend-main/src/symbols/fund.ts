import type { InjectionKey, Ref } from 'vue'

interface FundState {
  fId: Ref<string>
}

/**
 * @description Popup InjectionKey Symbol
 */
export const FundKey: InjectionKey<FundState> = Symbol('fund')
