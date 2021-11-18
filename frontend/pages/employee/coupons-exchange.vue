<template>
  <div class="page__content page__content--narrow">
    <exchange-coupon
      v-for="coupon in exchangeCoupons"
      :key="coupon.id"
      :coupon="coupon"
      @purchase-clicked="onPurchaseClicked"
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

    onPurchaseConfirmed() {
      this.showPurchaseDialog = false;
      this.fetchExchangeCoupons();
    },
  },
};
</script>