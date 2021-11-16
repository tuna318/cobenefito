<template>
  <v-app>
    <v-main :class="$auth.loggedIn ? 'page' : ''">
      <v-snackbar v-model="snackbar" :color="snackbarColor" top>
        {{ snackbarContent }}
      </v-snackbar>
      <page-header v-if="$auth.loggedIn" />
      <side-navigations v-if="$auth.loggedIn" />
      <Nuxt />
    </v-main>
  </v-app>
</template>

<script>
import layout from '@/mixins/layout';

export default {
  mixins: [layout],
};
</script>
