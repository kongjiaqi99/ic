import type { InjectionKey, Ref } from 'vue'

interface TagsState {
  selectTags: Ref<AnyObj[]>
  tagList: Ref<AnyObj[]>
  getTags: () => void
  getTagFunds: () => void
}

/**
 * @description Popup InjectionKey Symbol
 */
export const TagsKey: InjectionKey<TagsState> = Symbol('tags')
