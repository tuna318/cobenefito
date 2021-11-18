<template>
  <div class="page__content page__content--narrow">
    <employee-coupon v-for="coupon in coupons" :key="coupon.id" :coupon="coupon" />
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
  },
};
</script>
