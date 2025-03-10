import type { InjectionKey, Ref } from 'vue'

interface AuditState {
  aId: Ref<string>
}

/**
 * @description Popup InjectionKey Symbol
 */
export const AuditKey: InjectionKey<AuditState> = Symbol('audit')
