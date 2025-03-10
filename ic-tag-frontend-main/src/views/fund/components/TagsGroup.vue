<script setup lang="ts">
const tagsList = ref<AnyObj[]>([])
const selectTags = ref([])
const selectTagsItem = ref<AnyObj>({})

const inputVisible = ref(false);

const emits = defineEmits(['addedTag'])

onMounted(() => {
  getTagList();
  console.log('tags', tagsList.value);
});

const showTagAdding = () => {
  inputVisible.value = !inputVisible.value;
};

async function getTagList() {
  let query: Record<string, any> = {};
  const [e, r] = await api.queryTags(query);
  if (!e && r) {
    const data: any = r
    tagsList.value = data
  } else {
    console.log(e);
  }
}

const handleChange = (e) => {
  if (e) {
    selectTagsItem.value = tagsList.value.find((item) => {
      return item.tagId === e
    })
    emits('addedTag', selectTagsItem.value)
  } else {
    selectTagsItem.value = {}
    emits('addedTag', selectTagsItem.value)
  }
}

const setTag = (item) => {
  console.log("🚀 ~ setTag ~ item:", item)
  inputVisible.value = true
  selectTagsItem.value = item
  selectTags.value = [item.tagId]
}

defineExpose({
  setTag
})
</script>

<template>
  <div class="tagsGroup">
    <div class="selectedTags">
      <h3>Tags</h3>
      <div class="tags">
        <el-button class="button-new-tag" type="warning" plain @click="showTagAdding">+ Add Tags</el-button>
        <el-tag size="large" v-show="selectTagsItem?.name" type="warning">
          {{ selectTagsItem?.name || '' }}
        </el-tag>
      </div>
    </div>
    <div class="tags-adding">
      <el-select v-model="selectTags" v-show="inputVisible" filterable placeholder="Please enter a Tag"
        class="tag-selection" @change="handleChange" clearable>
        <el-option v-for="(item, index) in tagsList" :key="index" :label="item.name" :value="item.tagId">
        </el-option>
      </el-select>
    </div>
  </div>
</template>

<style lang="scss">
.tagsGroup {
  display: flex;
  flex-direction: column;
  width: 100%;
  gap: 12px;

  .selectedTags {
    display: flex;
    flex-direction: column;
    gap: 8px;

    h3 {
      color: #969696;
      font-size: 16px;
      font-weight: 500;
    }

    .tags {
      display: flex;
      gap: 4px;

      .button-new-tag {
        margin-bottom: 4px;
        margin-right: 4px;
      }
    }
  }

  .tags-adding {
    width: 100%;

    .tag-selection {
      width: 100%;

      .el-tag--info {
        display: none;
      }
    }
  }
}
</style>
