<template>

  <TransitionRoot :show="open" as="template">
    <Dialog as="div" class="fixed inset-0 z-10 overflow-y-auto p-4 sm:p-6 md:p-20" @close="open = false">
      <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0" enter-to="opacity-100" leave="ease-in duration-200" leave-from="opacity-100" leave-to="opacity-0">
        <DialogOverlay class="fixed inset-0 bg-opacity-25 transition-opacity" />
      </TransitionChild>

      <TransitionChild as="template" enter="ease-out duration-300" enter-from="opacity-0 scale-95" enter-to="opacity-100 scale-100" leave="ease-in duration-200" leave-from="opacity-100 scale-100" leave-to="opacity-0 scale-95">
        <Combobox as="div" class="mx-auto max-w-xl transform divide-y divide-gray-100 overflow-hidden rounded-xl bg-white shadow-2xl ring-1 ring-black ring-opacity-5 transition-all" @update:modelValue="onSelect">
          <div class="relative">
            <SearchIcon class="pointer-events-none absolute top-3.5 left-4 h-5 w-5 text-gray-400" aria-hidden="true" />
            <ComboboxInput class="h-12 w-full border-0 bg-transparent pl-11 pr-4 text-gray-800 placeholder-gray-400 focus:ring-0 sm:text-sm rounded-xl" placeholder="Start typing an address..." @change="query = $event.target.value" />
          </div>

          <ComboboxOptions v-if="resultList.length > 0" static class="max-h-72 scroll-py-2 overflow-y-auto py-2 text-sm text-gray-800">
            <ComboboxOption v-for="item in resultList" :key="item.pid" :value="item" as="template" v-slot="{ active }">
              <li
                  :class="['cursor-default select-none px-4 py-2', active && 'bg-indigo-600 text-white']"
                  v-html="item.highlight.sla">
              </li>
            </ComboboxOption>
          </ComboboxOptions>
<!--          <p v-if="!loading && query !== '' && resultList.length === 0" class="p-4 text-sm text-gray-500">No resultList found.</p>-->
        </Combobox>
      </TransitionChild>
    </Dialog>
  </TransitionRoot>

</template>
<script>
import { ref } from 'vue'
import { SearchIcon } from '@heroicons/vue/solid'
import {
  Combobox,
  ComboboxInput,
  ComboboxOptions,
  ComboboxOption,
  Dialog,
  DialogOverlay,
  TransitionChild,
  TransitionRoot,
} from '@headlessui/vue'

export default {
  components: {
    Combobox,
    ComboboxInput,
    ComboboxOptions,
    ComboboxOption,
    Dialog,
    DialogOverlay,
    SearchIcon,
    TransitionChild,
    TransitionRoot,
  },
  data() {
    return {
      resultList: [],
      loading: false,
    }
  },
  watch: {
    query(newQuery) {
      if (newQuery.length > 2) {
        this.loading = true
        this.resultList = []
        //@todo debounce
        this.getResultList();
      }
    },
  },
  methods: {
    onSelect(selectedItem) {
      this.resultList = [];
      this.getAddressItem(selectedItem.pid);
    },
    getAddressItem(pid) {
      return fetch('https://au-address.oca.slj.me/addresses/' + pid, {
        method: 'get',
        headers: {
          'content-type': 'application/json'
        }
      })
      .then(res => {
        // a non-200 response code
        if (!res.ok) {
          // create error instance with HTTP status text
          const error = new Error(res.statusText);
          error.json = res.json();
          throw error;
        }
        return res.json();
      })
      .then(json => {
        this.$emit('select', json);
      })
    },
    getResultList() {
        this.loading = true
        return fetch('https://au-address.oca.slj.me/addresses?' + new URLSearchParams({
          q: this.query,
        }), {
          method: 'get',
          headers: {
            'content-type': 'application/json'
          }
        })
          .then(res => {
            // a non-200 response code
            if (!res.ok) {
              // create error instance with HTTP status text
              const error = new Error(res.statusText);
              error.json = res.json();
              throw error;
            }
            return res.json();
          })
          .then(json => {
            this.resultList = json
          })
          /*.catch(err => {
             // handle the error
          })*/
          .then(() => {
            this.loading = false
          });
    },
  },
  setup() {
    const open = ref(true)
    const query = ref('')
    return {
      open,
      query,
    }
  },
}
</script>
<style scoped>
li em {
  font-weight: bolder;
}
</style>
