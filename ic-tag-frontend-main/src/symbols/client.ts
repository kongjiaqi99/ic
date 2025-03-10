import type { InjectionKey, Ref } from 'vue'

interface ClientState {
  cId: Ref<string>
}

interface EntityState {
  eId: Ref<string>
  clientInfo: AnyObj
  entityInfo: AnyObj
}

/**
 * @description Popup InjectionKey Symbol
 */
export const ClientKey: InjectionKey<ClientState> = Symbol('client')

/**
 * @description Popup InjectionKey Symbol
 */
export const EntityKey: InjectionKey<EntityState> = Symbol('entity')
