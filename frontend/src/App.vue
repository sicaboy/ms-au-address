<template>
  <AddressSearchTypeahead @select="updateAddressItem" />
  <div class="pt-20 bg-white overflow-hidden shadow sm:rounded-lg">
    <div class="px-4 py-5 sm:p-6">
      {{ addressItem }}
    </div>
  </div>
</template>

<script>
import AddressSearchTypeahead from './components/AddressSearchTypeahead.vue'

export default {
  name: 'App',
  components: {
    AddressSearchTypeahead
  },
  data() {
    return {
      addressItem: {}
    }
  },
  methods: {
    updateAddressItem(item) {
      this.addressItem = item
    }
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
  margin-top: 60px;
}
</style>
