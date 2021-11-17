<template>
  <v-dialog v-model="value" persistent width="500">
    <v-card>
      <v-card-title class="justify-center">Offer Coupons</v-card-title>
      <v-card-text>
        <v-list dense>
          <v-list-item>
            <v-list-item-content>Name:</v-list-item-content>
            <v-list-item-content class="align-end">
              {{ couponInfo.name }}
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>Value:</v-list-item-content>
            <v-list-item-content class="align-end"> {{ couponInfo.value }}$ </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>Expiration time:</v-list-item-content>
            <v-list-item-content class="align-end">
              {{ couponInfo.expire_at }}
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>Number of coupons:</v-list-item-content>
            <v-list-item-content class="align-end">
              {{ couponInfo.quantity }}
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>Number of employees:</v-list-item-content>
            <v-list-item-content class="align-end">
              {{ selectedEmployeeIds.length }}
            </v-list-item-content>
          </v-list-item>
        </v-list>
        <v-form ref="form" v-model="formValid">
          <v-autocomplete
            v-model="selectedEmployeeIds"
            :items="employees"
            chips
            label="Select employees"
            item-text="username"
            item-value="id"
            :rules="[rules.required, rules.selectedEmployeesLessThanCoupons]"
            multiple
            outlined
          >
            <template v-slot:selection="data">
              <v-chip
                v-bind="data.attrs"
                :input-value="data.selected"
                close
                @click="data.select"
                @click:close="removeEmployee(data.item)"
              >
                {{ data.item.username }}
              </v-chip>
            </template>
          </v-autocomplete>
        </v-form>
      </v-card-text>

      <v-divider />
      <v-card-actions class="justify-center">
        <v-btn @click="$emit('canceled')" width="180">Cancel</v-btn>
        <v-btn @click="offerCoupons" width="180" color="primary">Offer</v-btn>
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
    couponInfo: {
      type: Object,
      default: {},
    },
  },

  data() {
    return {
      formValid: false,
      employees: [],
      selectedEmployeeIds: [],
      rules: {
        required: v => !!v || 'This field is required',
        selectedEmployeesLessThanCoupons: v =>
          v.length <= this.couponInfo.quantity || 'Not enough coupons',
      },
    };
  },

  fetch() {
    this.fetchEmployees();
  },

  watch: {
    value(val) {
      if (!val) {
        this.selectedEmployeeIds = [];
      }
    },
  },

  methods: {
    async fetchEmployees() {
      this.employees = await this.$axios.$get('/manager/employees');
    },
    async offerCoupons() {
      this.$refs.form.validate();
      if (!this.formValid) return;

      const response = await this.$axios.patch('/manager/coupons', {
        ...this.couponInfo,
        user_ids: this.selectedEmployeeIds,
      });

      if (response) {
        this.$notifier.showSuccess({ content: 'Offer coupons successfully' });
        this.$emit('confirmed');
      }
    },
    removeEmployee(employee) {
      this.selectedEmployeeIds = this.selectedEmployeeIds.filter(id => id !== employee.id);
    },
  },
};
</script>
