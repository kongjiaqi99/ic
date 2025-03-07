import type { InjectionKey, Ref } from 'vue'

interface InvestmentState {
  iId: Ref<string>
  info: AnyObj
}

/**
 * @description Popup InjectionKey Symbol
 */
export const InvestmentKey: InjectionKey<InvestmentState> = Symbol('investment')
