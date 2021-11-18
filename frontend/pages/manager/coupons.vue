<template>
  <div class="page__content">
    <div class="coupons__actions">
      <div class="coupons__search">
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

      <v-btn color="primary" @click="showCouponsRegistration = true">Register Coupons</v-btn>
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
      <template v-slot:[`item.action`]="{ item }">
        <button type="button" class="btn--medium btn--table-action" @click="onOfferClicked(item)">
          Offer
        </button>
      </template>
    </v-data-table>

    <lazy-dialog-coupons-registration
      v-model="showCouponsRegistration"
      @canceled="showCouponsRegistration = false"
      @confirmed="onRegisterCouponsConfirmed"
    />

    <lazy-dialog-coupons-offer
      v-model="showCouponsOffer"
      :coupon-info="selectedCoupon"
      @canceled="showCouponsOffer = false"
      @confirmed="onOfferCouponsConfirmed"
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
        { text: 'Name', value: 'name', sortable: false },
        { text: 'Usuable at', value: 'usuable_at', sortable: false },
        { text: 'Usuable for', value: 'usuable_for', sortable: false },
        { text: 'Value', value: 'value', sortable: false },
        { text: 'Expire at', value: 'expire_at', sortable: false },
        { text: 'Quantity', value: 'quantity', sortable: false },
        { text: '', value: 'action', sortable: false, width: '80px' },
      ],
      coupons: [],
      selectedCoupon: {},
      showCouponsRegistration: false,
      showCouponsOffer: false,
    };
  },

  fetch() {
    this.fetchCoupons();
  },

  watch: {
    search() {
      this.fetchDebounced();
    },
  },

  methods: {
    async fetchCoupons() {
      this.loading = true;
      this.coupons = await this.$axios.$get('/manager/coupons', {
        params: { name: this.search },
      });
      this.loading = false;
    },

    onRegisterCouponsConfirmed() {
      this.showCouponsRegistration = false;
      this.fetchCoupons();
    },

    onOfferCouponsConfirmed() {
      this.showCouponsOffer = false;
      this.fetchCoupons();
    },

    onOfferClicked(item) {
      this.selectedCoupon = item;
      this.showCouponsOffer = true;
    },

    fetchDebounced: _.debounce(function () {
      this.fetchCoupons();
    }, 500),
  },
};
</script>

<style lang="sass" scoped>
.coupons
  &__actions
    display: flex
    flex-flow: row nowrap
    justify-content: space-between

  &__search
    width: 30%
</style>
