<template>
  <div class="page__content">
    <v-data-table
      :headers="headers"
      :items="claims"
      :loading="loading"
      :items-per-page="10"
      class="elevation-1"
    >
      <template v-slot:[`item.action`]="{ item }">
        <button
          v-if="item.status === 'pending'"
          type="button"
          class="btn--medium btn--table-action"
          @click="onClaimDetailClicked(item)"
        >
          Details
        </button>
      </template>
    </v-data-table>

    <lazy-dialog-claim-detail
      v-model="showClaimDetail"
      :claim="selectedClaim"
      @updated="onClaimUpdated"
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
        { text: 'Employee', value: 'username', sortable: false },
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
      this.claims = await this.$axios.$get('/manager/claim_points_requests');
      this.loading = false;
    },

    onClaimUpdated() {
      this.fetchClaims();
      this.showClaimDetail = false;
    },

    onClaimDetailClicked(claim) {
      this.selectedClaim = claim;
      this.showClaimDetail = true;
    },
  },
};
</script>
