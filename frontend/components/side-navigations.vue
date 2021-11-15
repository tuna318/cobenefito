<template>
  <v-navigation-drawer app clipped :width="sidebarWidth">
    <v-list>
      <v-list-item
        v-for="item in items"
        :key="item.title"
        link
        active-class="primary--text font-weight-bold"
        :to="item.to"
      >
        <v-list-item-icon>
          <v-icon>{{ item.icon }}</v-icon>
        </v-list-item-icon>

        <v-list-item-content>
          <v-list-item-title>{{ item.title }}</v-list-item-title>
        </v-list-item-content>
      </v-list-item>
    </v-list>
  </v-navigation-drawer>
</template>

<script>
import { UserRole } from '@/common/const';
export default {
  computed: {
    items() {
      if (!this.$auth.loggedIn) return [];
      const items = {};

      items.manager = [
        { title: 'Employees Management', icon: 'mdi-account-group', to: '/manager/employees' },
        { title: 'Coupons Management', icon: 'mdi-ticket-percent', to: '/manager/coupons' },
        { title: 'Point-claims Management', icon: 'mdi-star-circle', to: '/manager/point-claims' },
      ];

      items.employee = [
        { title: 'Coupons', icon: 'mdi-shopping', to: '/employee/coupons' },
        { title: 'Point Claims', icon: 'mdi-clipboard-text', to: '/employee/point-claims' },
        { title: 'Coupons Exchange', icon: 'mdi-gavel', to: '/employee/coupons-exchange' },
      ];

      return items[this.$auth.user.user_role];
    },

    sidebarWidth() {
      return this.$auth.user?.user_role === UserRole.MANAGER ? '300' : '250';
    },
  },
};
</script>