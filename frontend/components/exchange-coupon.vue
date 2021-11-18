<template>
  <v-card width="600" class="coupon">
    <div class="coupon__info">
      <b>{{ coupon.name }} - {{ coupon.value }}$</b> <br />
      Use for {{ coupon.usuable_for }} at {{ coupon.usuable_at }} <br />
      Expiration date: {{ coupon.expire_at }} <br />
      Owner: {{ coupon.owner_email }}
    </div>
    <div class="coupon__actions">
      <div class="text-center">
        {{ coupon.price }} <v-icon color="secondary">mdi-star-circle</v-icon>
      </div>
      <button
        type="button"
        class="btn--medium btn--table-action coupon__btn mt-2"
        @click="onPurchaseClicked"
      >
        Purchase
      </button>
    </div>
  </v-card>
</template>

<script>
export default {
  props: {
    coupon: {
      type: Object,
      default: () => {},
    },
  },

  methods: {
    async onPurchaseClicked() {
      this.$emit('purchase-clicked', this.coupon);
    },
  },
};
</script>

<style lang="sass" scoped>
.coupon
  display: flex
  flex-flow: row nowrap
  padding: 10px 10px 10px 20px
  margin: 10px auto

  &__info
    width: 75%

  &__actions
    width: 25%
    padding: 10px 0

  &__btn
    width: 130px
</style>
