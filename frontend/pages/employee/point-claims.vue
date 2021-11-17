<template>
  <div class="page__content">
    <v-btn color="primary">Create request</v-btn>

    <v-data-table
      :headers="headers"
      :items="claims"
      :loading="loading"
      :items-per-page="10"
      class="elevation-1 mt-3"
    >
      <template v-slot:[`item.action`]="{ item }">
        <button
          type="button"
          class="btn--medium btn--table-action"
          @click="onClaimDetailClicked(item)"
        >
          Details
        </button>
      </template>
    </v-data-table>

    <lazy-dialog-employee-claim-detail
      v-model="showClaimDetail"
      :claim="selectedClaim"
      @closed="showClaimDetail = false"
    />
  </div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
      headers: [
        { text: 'Request Title', value: 'title', sortable: false },
        { text: 'Request Time', value: 'created_at', sortable: false },
        { text: 'Status', value: 'status', sortable: false },
        { text: '', value: 'action', sortable: false, width: '80px' },
      ],
      claims: [],
      selectedClaim: {},
      showClaimDetail: false,
    };
  },

  fetch() {
    this.fetchClaims();
  },

  methods: {
    async fetchClaims() {
      this.loading = true;
      this.claims = await this.$axios.$get('/employee/claim_points_requests');
      this.loading = false;
    },

    onClaimDetailClicked(claim) {
      this.selectedClaim = claim;
      this.showClaimDetail = true;
    },
  },
};
</script>