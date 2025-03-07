import type { InjectionKey, Ref } from 'vue'

interface ReferralState {
  rId: Ref<string>
}

/**
 * @description Popup InjectionKey Symbol
 */
export const ReferralKey: InjectionKey<ReferralState> = Symbol('referral')
