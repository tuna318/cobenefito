<template>
  <v-card width="600" class="coupon">
    <div class="coupon__info">
      <b>{{ coupon.name }} - {{ coupon.value }}$ ({{ coupon.status }})</b> <br />
      Code: <span class="primary--text">{{ coupon.code }}</span> <br />
      Use for {{ coupon.usuable_for }} at {{ coupon.usuable_at }} <br />
      Expiration date: {{ coupon.expire_at }}
    </div>
    <div class="coupon__actions">
      <div v-if="isAvailableCoupon">
        <button
          type="button"
          class="btn--medium btn--table-action coupon__btn"
          @click="onExchangeClicked"
        >
          Exchange
        </button>
        <button
          type="button"
          class="btn--medium btn--table-action coupon__btn"
          @click="onMarkReadClicked"
        >
          Mark as read
        </button>
      </div>
      <div v-else-if="isOnSaleCoupon">
        <button
          type="button"
          class="btn--medium btn--table-action coupon__btn"
          @click="onSaleCancelClicked"
        >
          Cancel exchange
        </button>
      </div>
    </div>
  </v-card>
</template>

<script>
import { CouponStatus } from '@/common/const';

export default {
  props: {
    coupon: {
      type: Object,
      default: () => {},
    },
  },

  computed: {
    isAvailableCoupon() {
      return this.coupon.status === CouponStatus.AVAILABLE;
    },
    isOnSaleCoupon() {
      return this.coupon.status === CouponStatus.ON_SALE;
    },
  },

  methods: {
    onExchangeClicked() {},
    onMarkReadClicked() {},
    onSaleCancelClicked() {},
  },
};
</script>

<style lang="sass" scoped>
.coupon
  display: flex
  flex-flow: row nowrap
  padding: 10px
  margin: 10px auto

  &__info
    width: 80%

  &__actions
    width: 20%
    padding: 10px 0

  &__btn
    width: 100px
</style>
