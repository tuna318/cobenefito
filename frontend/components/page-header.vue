<template>
  <v-app-bar fixed app color="white" clipped-left class="header">
    <nuxt-link :to="defaultRoute" class="header__logo align-items--center cursor--pointer">
      <v-img src="/coupon.png" max-width="50" max-height="50" />
      <h3 class="header__app-name secondary--text">Cobenefito</h3>
    </nuxt-link>

    <v-spacer />

    <div v-if="$auth.user.user_role === 'employee'" class="mr-10">
      {{ $auth.user.user_reward_points }}
      <v-icon color="secondary">mdi-star-circle</v-icon>
    </div>
    <div>
      <span class="mr-4">
        {{ $auth.user.username }}
      </span>
      <v-icon @click="logout">mdi-exit-to-app</v-icon>
    </div>
  </v-app-bar>
</template>

<script>
import { RoleDefaultRoutes } from '@/common/const';

export default {
  computed: {
    defaultRoute() {
      if (!this.$auth.loggedIn) return '/';

      const role = this.$auth.user.user_role;
      return RoleDefaultRoutes[role];
    },
  },
  methods: {
    logout() {
      this.$auth.logout();
      this.$router.push('/');
    },
  },
};
</script>

<style lang="sass" scoped>
.header
  padding: 0px 10px
  &__logo
    display: flex
    font-size: 16px
    font-weight: 700

  &__app-name
    line-height: 50px
    height: 50px
    margin-left: 15px
</style>