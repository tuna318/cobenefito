<template>
  <div class="register">
    <div class="text-center">
      <img src="coupon.png" class="register__logo" />
      <h2 class="secondary--text">Cobenefito</h2>
    </div>
    <v-form ref="form" v-model="formValid" class="register__form">
      <v-text-field
        v-model="space.name"
        label="Space name"
        placeholder="Space name"
        :rules="[rules.required]"
        outlined
        dense
      />
      <v-text-field
        v-model="manager.email"
        label="Manager email"
        placeholder="Manager email"
        :rules="[rules.required, rules.email]"
        outlined
        dense
      />
      <v-text-field
        v-model="manager.username"
        label="Manager full name"
        placeholder="Manager full name"
        :rules="[rules.required]"
        outlined
        dense
      />
      <v-text-field
        v-model="manager.password"
        label="Manager password"
        placeholder="Manager password"
        :rules="[rules.required, rules.password]"
        outlined
        dense
        type="password"
      />
      <v-text-field
        v-model="manager.confirmationPassword"
        label="Manager confirmation password"
        placeholder="Manager confirmation password"
        :rules="[rules.required, rules.confirmationPassword]"
        outlined
        dense
        type="password"
      />
      <v-btn class="mb-2" depressed color="primary" width="400" @click="register"> Register </v-btn>
      <nuxt-link to="/">
        <v-btn width="400" depressed> Back </v-btn>
      </nuxt-link>
    </v-form>
  </div>
</template>

<script>
export default {
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
      space: {
        name: '',
      },
      manager: {
        email: '',
        username: '',
        password: '',
        confirmationPassword: '',
      },
    };
  },

  methods: {
    async register() {
      this.$refs.form.validate();

      if (!this.formValid) return;

      const response = await this.$axios.post('/spaces', {
        space: this.space,
        manager: this.manager,
      });

      if (response) {
        this.$router.push('/login');
      }
    },
  },
};
</script>
<style lang="sass" scoped>
.register
  margin: 50px auto

  &__logo
    width: 50px
    height: 50px

  &__form
    width: 400px
    margin: 20px auto
</style>