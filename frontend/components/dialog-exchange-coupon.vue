<template>
  <v-dialog v-model="value" persistent width="400">
    <v-card>
      <v-card-title class="justify-center">Exchange coupon</v-card-title>
      <v-card-text>
        <div>
          <b>{{ coupon.name }} - {{ coupon.value }}$ ({{ coupon.status }})</b> <br />
          Code: <span class="primary--text">{{ coupon.code }}</span> <br />
          Use for {{ coupon.usuable_for }} at {{ coupon.usuable_at }} <br />
          Expiration date: {{ coupon.expire_at }}
        </div>

        <v-form ref="form" v-model="formValid">
          <v-text-field
            v-model="price"
            label="Price"
            placeholder="Price in reward points"
            :rules="[rules.required]"
            class="mt-2"
            dense
            outlined
            hide-details
          />
        </v-form>
      </v-card-text>

      <v-divider />
      <v-card-actions class="justify-center">
        <v-btn @click="$emit('canceled')" width="180">Cancel</v-btn>
        <v-btn @click="createExchange" width="180" color="primary">Exchange</v-btn>
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

  data() {
    return {
      formValid: false,
      price: null,
      rules: {
        required: v => !!v || 'This field is required',
      },
    };
  },

  methods: {
    async createExchange() {
      this.$refs.form.validate();
      if (!this.formValid) return;
      const response = await this.$axios.post('/employee/coupons_exchange', {
        coupon_id: this.coupon.id,
        price: this.price,
      });

      if (response) {
        this.$notifier.showSuccess({ content: 'Set coupon to exchange successfully' });
        this.$emit('created');
      }
    },
  },
};
</script>
