import type { InjectionKey, Ref } from 'vue'

interface AdminState {
  aId: Ref<string>
}

/**
 * @description Popup InjectionKey Symbol
 */
export const AdminKey: InjectionKey<AdminState> = Symbol('admin')
