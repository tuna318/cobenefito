<template>
  <div class="page__content page__content--narrow">
    <exchange-coupon
      v-for="coupon in exchangeCoupons"
      :key="coupon.id"
      :coupon="coupon"
      @purchase-clicked="onPurchaseClicked"
    />

    <lazy-dialog-purchase-coupon
      v-model="showPurchaseDialog"
      :coupon="selectedCoupon"
      @canceled="showPurchaseDialog = false"
      @purchased="onPurchased"
    />
  </div>
</template>

<script>
export default {
  data() {
    return {
      exchangeCoupons: [],
      selectedCoupon: {},
      showPurchaseDialog: false,
    };
  },

  fetch() {
    this.fetchExchangeCoupons();
  },

  methods: {
    async fetchExchangeCoupons() {
      this.exchangeCoupons = await this.$axios.$get('/employee/coupons_exchange');
    },

    onPurchaseClicked(coupon) {
      this.selectedCoupon = coupon;
      this.showPurchaseDialog = true;
    },

    onPurchased() {
      this.showPurchaseDialog = false;
      this.fetchExchangeCoupons();
      this.$auth.fetchUser();
    },
  },
};
</script>
