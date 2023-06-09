<template>
  <div>
    <context-action-menu :menu-sections="menuSections" :action-options="{ resources: items }" />
    <quota-modal
      v-if="quotaModalIsOpen"
      :cancel="closeQuotaModal"
      :spaces="items"
      :max-quota="maxQuota"
    />
  </div>
</template>

<script lang="ts">
import { computed, defineComponent, PropType, unref } from 'vue'
import { SpaceResource } from 'web-client'
import ContextActionMenu from 'web-pkg/src/components/ContextActions/ContextActionMenu.vue'
import QuotaModal from 'web-pkg/src/components/Spaces/QuotaModal.vue'
import { useCapabilitySpacesMaxQuota, useStore } from 'web-pkg/src/composables'

import {
  useSpaceActionsDelete,
  useSpaceActionsDisable,
  useSpaceActionsEditDescription,
  useSpaceActionsEditQuota,
  useSpaceActionsRename,
  useSpaceActionsRestore,
  useActionsShowDetails
} from 'web-pkg/src/composables/actions'

export default defineComponent({
  name: 'ContextActions',
  components: { ContextActionMenu, QuotaModal },
  props: {
    items: {
      type: Array as PropType<SpaceResource[]>,
      required: true
    }
  },
  setup(props) {
    const store = useStore()
    const filterParams = computed(() => ({ resources: props.items }))

    const { actions: deleteActions } = useSpaceActionsDelete({ store })
    const { actions: disableActions } = useSpaceActionsDisable({ store })
    const {
      actions: editQuotaActions,
      modalOpen: quotaModalIsOpen,
      closeModal: closeQuotaModal
    } = useSpaceActionsEditQuota({ store })
    const { actions: editDescriptionActions } = useSpaceActionsEditDescription({ store })
    const { actions: renameActions } = useSpaceActionsRename({ store })
    const { actions: restoreActions } = useSpaceActionsRestore({ store })
    const { actions: showDetailsActions } = useActionsShowDetails()

    const menuItemsPrimaryActions = computed(() =>
      [...unref(renameActions), ...unref(editDescriptionActions)].filter((item) =>
        item.isEnabled(unref(filterParams))
      )
    )
    const menuItemsSecondaryActions = computed(() =>
      [
        ...unref(editQuotaActions),
        ...unref(disableActions),
        ...unref(restoreActions),
        ...unref(deleteActions)
      ].filter((item) => item.isEnabled(unref(filterParams)))
    )
    const menuItemsSidebar = computed(() =>
      [...unref(showDetailsActions)].filter((item) => item.isEnabled(unref(filterParams)))
    )

    const menuSections = computed(() => {
      const sections = []

      if (unref(menuItemsPrimaryActions).length) {
        sections.push({
          name: 'primaryActions',
          items: unref(menuItemsPrimaryActions)
        })
      }
      if (unref(menuItemsSecondaryActions).length) {
        sections.push({
          name: 'secondaryActions',
          items: unref(menuItemsSecondaryActions)
        })
      }
      if (unref(menuItemsSidebar).length) {
        sections.push({
          name: 'sidebar',
          items: unref(menuItemsSidebar)
        })
      }
      return sections
    })

    return {
      maxQuota: useCapabilitySpacesMaxQuota(),
      menuSections,
      quotaModalIsOpen,
      closeQuotaModal
    }
  }
})
</script>
