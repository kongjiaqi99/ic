import type { InjectionKey, Ref } from 'vue'

interface EnquiryState {
  eId: Ref<string>
}

/**
 * @description Popup InjectionKey Symbol
 */
export const EnquiryKey: InjectionKey<EnquiryState> = Symbol('enquiry')
