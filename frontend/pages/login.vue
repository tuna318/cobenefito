<template>
  <div class="login">
    <div class="text-center">
      <img src="coupon.png" class="login__logo" />
      <h2 class="secondary--text">Cobenefito</h2>
    </div>
    <v-form ref="form" v-model="formValid" class="login__form">
      <v-text-field
        v-model="credentials.space_name"
        label="Space name"
        placeholder="Space name"
        :rules="[rules.required]"
        outlined
        dense
      />
      <v-text-field
        v-model="credentials.user_email"
        label="Login email"
        placeholder="Login email"
        :rules="[rules.required, rules.email]"
        outlined
        dense
      />
      <v-text-field
        v-model="credentials.user_password"
        label="Login password"
        placeholder="Login password"
        :rules="[rules.required, rules.password]"
        outlined
        dense
        type="password"
      />
      <v-btn class="mb-2" depressed color="primary" width="400" @click="login"> Login </v-btn>
      <nuxt-link to="/">
        <v-btn width="400" depressed> Back </v-btn>
      </nuxt-link>
    </v-form>
  </div>
</template>

<script>
export default {
  auth: false,
  data() {
    return {
      formValid: false,
      rules: {
        required: v => !!v || 'This field is required',
        email: v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
        password: v => v.length >= 8 || 'Password must be at least 8 characters',
        confirmationPassword: v =>
          v === this.manager.password || 'Password and confirmation password must be the same',
      },
      credentials: {
        space_name: '',
        user_email: '',
        user_password: '',
      },
    };
  },
  methods: {
    async login() {
      this.$refs.form.validate();
      if (!this.formValid) return;

      await this.$auth.loginWith('normal', {
        data: this.credentials,
      });
    },
  },
};
</script>
<style lang="sass" scoped>
.login
  margin: 50px auto

  &__logo
    width: 50px
    height: 50px

  &__form
    width: 400px
    margin: 20px auto
</style>