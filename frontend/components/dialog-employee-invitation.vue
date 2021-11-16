<template>
  <v-dialog v-model="value" persistent max-width="450">
    <v-card>
      <v-card-title class="justify-center">Invite new employee</v-card-title>
      <v-card-text>
        <v-form ref="form" v-model="formValid">
          <v-text-field
            v-model="email"
            label="Employee email"
            placeholder="Employee email"
            :rules="[rules.required, rules.email]"
            dense
            outlined
            clearable
            hide-details
          />
        </v-form>
      </v-card-text>
      <v-divider />
      <v-card-actions class="justify-center">
        <v-btn @click="$emit('canceled')" width="180">Cancel</v-btn>
        <v-btn @click="sendInvitation" width="180" color="primary">Send Invitation</v-btn>
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
  },
  data() {
    return {
      formValid: false,
      email: '',
      rules: {
        required: v => !!v || 'This field is required',
        email: v => /.+@.+\..+/.test(v) || 'E-mail must be valid',
      },
    };
  },

  watch: {
    value() {
      if (!this.value) {
        this.email = '';
      }
    },
  },

  methods: {
    async sendInvitation() {
      this.$refs.form.validate();
      if (!this.formValid) return;

      const response = await this.$axios.post('/manager/employees', { email: this.email });

      if (response) {
        this.$notifier.showSuccess({ content: 'Send invitation successfully' });
        this.$emit('confirmed');
      }
    },
  },
};
</script>
