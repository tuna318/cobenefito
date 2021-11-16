<template>
  <v-dialog v-model="value" persistent max-width="500">
    <v-card>
      <v-card-title class="justify-center">Register Coupons</v-card-title>
      <v-card-text>
        <v-form ref="form" v-model="formValid">
          <v-text-field
            v-model="coupons.name"
            label="Coupon name"
            placeholder="Coupon name"
            :rules="[rules.required]"
            class="mb-3"
            dense
            outlined
            hide-details
          />
          <div class="d-flex mb-3">
            <v-text-field
              v-model="coupons.usuable_at"
              label="Usuable at"
              placeholder="Usuable at"
              class="mr-1"
              :rules="[rules.required]"
              dense
              outlined
              hide-details
            />
            <v-select
              v-model="coupons.usuable_for"
              label="Usuable at"
              class="ml-1"
              :items="usableFors"
              :rules="[rules.required]"
              dense
              outlined
              hide-details
            />
          </div>
          <v-text-field
            v-model="coupons.value"
            label="Value"
            placeholder="Value"
            class="mb-3"
            :rules="[rules.required]"
            dense
            outlined
            hide-details
            suffix="$"
          />

          <v-menu
            v-model="dateMenu"
            :close-on-content-click="false"
            :nudge-right="40"
            class="mb-3"
            transition="scale-transition"
            offset-y
            min-width="auto"
          >
            <template v-slot:activator="{ on, attrs }">
              <v-text-field
                v-model="coupons.expire_at"
                label="Expiration date"
                append-icon="mdi-calendar"
                class="mb-3"
                :rules="[rules.required]"
                readonly
                outlined
                v-bind="attrs"
                dense
                hide-details
                v-on="on"
              ></v-text-field>
            </template>

            <v-date-picker v-model="coupons.expire_at" @input="dateMenu = false"></v-date-picker>
          </v-menu>

          <v-textarea
            v-model="codes"
            label="Code"
            :rules="[rules.required]"
            outlined
            class="mb-3"
            hide-details
          />
        </v-form>
      </v-card-text>
      <v-divider />
      <v-card-actions class="justify-center">
        <v-btn @click="$emit('canceled')" width="180">Cancel</v-btn>
        <v-btn @click="register" width="180" color="primary">Register</v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
import { UsuableFor } from '@/common/const';

export default {
  props: {
    value: {
      type: Boolean,
      default: false,
    },
  },

  data() {
    return {
      formValid: false,
      rules: {
        required: v => !!v || 'This field is required',
      },
      usableFors: Object.values(UsuableFor).map(item => {
        return {
          text: item,
          value: item,
        };
      }),
      codes: '',
      coupons: {
        name: '',
        usuable_at: '',
        usuable_for: '',
        expire_at: '',
        codes: [],
        value: null,
      },
      dateMenu: false,
    };
  },

  watch: {
    codes(value) {
      let codes = value.split(',');
      codes = codes.map(code => code.replace(/\s/g, ''));
      codes = codes.filter(code => !!code);
      this.coupons.codes = codes;
    },
  },

  methods: {
    async register() {
      this.$refs.form.validate();
      if (!this.formValid) return;

      const response = await this.$axios.post('/manager/coupons', { ...this.coupons });

      if (response) {
        this.$notifier.showSuccess({ content: 'Register Coupons Successfully' });
        this.$emit('confirmed');
      }
    },
  },
};
</script>