<template>
  <div class="page__content">
    <div class="employee__info">
      <div class="employee__icon">
        <v-icon size="80">mdi-account</v-icon>
      </div>
      <div class="employee__contact">
        <div>{{ employee.username }}</div>
        <div>{{ employee.email }}</div>
      </div>
      <div class="employee__points">
        <v-icon color="secondary">mdi-star-circle</v-icon>
        {{ employee.reward_points }}
      </div>
    </div>

    <v-data-table
      :headers="headers"
      :items="coupons"
      :loading="loading"
      :items-per-page="10"
      class="elevation-1"
    >
      <template v-slot:[`item.value`]="{ item }">
        <div>{{ item.value }} $</div>
      </template>
    </v-data-table>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
      employee: {},
      coupons: [],
      headers: [
        { text: 'Name', value: 'name', sortable: false },
        { text: 'Usuable at', value: 'usuable_at', sortable: false },
        { text: 'Usuable for', value: 'usuable_for', sortable: false },
        { text: 'Value', value: 'value', sortable: false },
        { text: 'Status', value: 'status', sortable: false },
        { text: 'Expire at', value: 'expire_at', sortable: false },
      ],
    };
  },

  fetch() {
    this.fetchEmployee();
  },

  methods: {
    async fetchEmployee() {
      this.loading = true;
      const employeeId = this.$route.params.id;
      const response = await this.$axios.$get(`/manager/employees/${employeeId}`);
      if (response) {
        this.employee = response.employee;
        this.coupons = response.coupons;
      }
      this.loading = false;
    },
  },
};
</script>

<style lang="sass" scoped>
.employee
  &__info
    display: flex
    flex-flow: row nowrap
    margin-bottom: 20px

  &__icon
    width: 10%

  &__contact
    width: 40%
    padding-top: 20px

  &__points
    padding-top: 40px
    width: 50%
</style>
