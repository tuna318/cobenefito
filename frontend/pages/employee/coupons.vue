<template>
  <div class="page__content page__content--narrow">
    <employee-coupon
      v-for="coupon in coupons"
      :key="coupon.id"
      :coupon="coupon"
      @updated="fetchCoupons"
      @exchange-clicked="onExchangeClicked"
    />

    <lazy-dialog-exchange-coupon
      v-model="showExchangeDialog"
      :coupon="selectedCoupon"
      @canceled="showExchangeDialog = false"
      @created="onExchangeCreated"
    />
  </div>
</template>

<script>
import employeeCoupon from '~/components/employee-coupon.vue';
export default {
  components: { employeeCoupon },
  data() {
    return {
      loading: false,
      coupons: [],
      selectedCoupon: {},
      showExchangeDialog: false,
    };
  },

  fetch() {
    this.fetchCoupons();
  },

  methods: {
    async fetchCoupons() {
      this.loading = true;
      this.coupons = await this.$axios.$get('/employee/coupons');
      this.loading = false;
    },

    onExchangeClicked(coupon) {
      this.selectedCoupon = coupon;
      this.showExchangeDialog = true;
    },

    onExchangeCreated() {
      this.showExchangeDialog = false;
      this.fetchCoupons();
    },
  },
};
</script>
