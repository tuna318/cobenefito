<template>
  <v-dialog v-model="value" persistent max-width="400">
    <v-card>
      <v-card-title class="justify-center">Purchase coupon</v-card-title>
      <v-card-text>
        <div v-if="coupon">
          <b>{{ coupon.name }} - {{ coupon.value }}$ ({{ coupon.status }})</b> <br />
          Use for {{ coupon.usuable_for }} at {{ coupon.usuable_at }} <br />
          Expiration date: {{ coupon.expire_at }} <br />
          Owner: {{ coupon.owner_email }} <br />
          Price in reward points: {{ coupon.price }}
          <v-icon color="secondary">mdi-star-circle</v-icon>
        </div>
      </v-card-text>

      <v-divider />
      <v-card-actions class="justify-center">
        <v-btn @click="$emit('canceled')" width="180">Cancel</v-btn>
        <v-btn @click="purchase" width="180" color="primary">Purchase</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    value: {
      type: Boolean,
      default: false,
    },
    coupon: {
      type: Object,
      default: () => {},
    },
  },

  methods: {
    async purchase() {
      const response = await this.$axios.post('/employee/coupons_exchange/purchase', {
        tx_id: this.coupon.tx_id,
      });

      if (response) {
        this.$notifier.showSuccess({ content: 'Purchase coupon successfully' });
        this.$emit('purchased');
      }
    },
  },
};
</script>
