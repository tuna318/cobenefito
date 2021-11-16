<template>
  <div class="page__content">
    <div class="employees__actions">
      <div class="employees__search">
        <v-text-field
          v-model="search"
          label="Search by name"
          placeholder="Search by name"
          outlined
          dense
          clearable
          append-icon="mdi-magnify"
        />
      </div>

      <v-btn color="primary" @click="showEmployeeInvitation = true">Invite employee</v-btn>
    </div>

    <v-data-table
      :headers="headers"
      :items="employees"
      :loading="loading"
      :items-per-page="10"
      class="elevation-1"
    >
      <template v-slot:[`item.action`]="{ item }">
        <nuxt-link :to="`/manager/employees/${item.id}`">
          <button type="button" class="btn--medium btn--table-action">Details</button>
        </nuxt-link>
      </template>
    </v-data-table>

    <lazy-dialog-employee-invitation
      v-model="showEmployeeInvitation"
      @canceled="showEmployeeInvitation = false"
      @confirmed="showEmployeeInvitation = false"
    />
  </div>
</template>

<script>
import _ from 'lodash';

export default {
  data() {
    return {
      search: '',
      loading: false,
      headers: [
        { text: 'Employee name', value: 'username', sortable: false },
        { text: 'Employee email', value: 'email', sortable: false },
        { text: '', value: 'action', sortable: false, width: '60px' },
      ],
      employees: [],
      showEmployeeInvitation: false,
    };
  },

  async fetch() {
    await this.fetchEmloyees();
  },

  watch: {
    search() {
      this.fetchDebounced();
    },
  },

  methods: {
    async fetchEmloyees() {
      this.loading = true;
      this.employees = await this.$axios.$get('/manager/employees', {
        params: { username: this.search },
      });
      this.loading = false;
    },

    fetchDebounced: _.debounce(function () {
      this.fetchEmloyees();
    }, 500),
  },
};
</script>

<style lang="sass" scoped>
.employees
  &__actions
    display: flex
    flex-flow: row nowrap
    justify-content: space-between

  &__search
    width: 30%
</style>