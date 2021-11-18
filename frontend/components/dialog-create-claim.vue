<template>
  <v-dialog v-model="value" persistent max-width="500">
    <v-card>
      <v-card-title class="justify-center">Claim points request</v-card-title>
      <v-card-text>
        <v-form ref="form" v-model="formValid">
          <v-text-field
            v-model="title"
            label="Title"
            placeholder="Title"
            :rules="[rules.required]"
            class="mb-3"
            dense
            outlined
            hide-details
          />
          <v-text-field
            v-model="referenceLink"
            label="Reference Link"
            placeholder="Reference Link"
            :rules="[rules.required]"
            class="mb-3"
            dense
            outlined
            hide-details
          />
          <v-list dense>
            <v-list-item>
              <v-list-item-content>
                Clamable points <br />
                (For this month)
              </v-list-item-content>
              <v-list-item-content class="align-end">
                {{ $auth.user.user_claimable_points }}
              </v-list-item-content>
            </v-list-item>
          </v-list>
        </v-form>
      </v-card-text>

      <v-divider />
      <v-card-actions class="justify-center">
        <v-btn @click="$emit('canceled')" width="180">Cancel</v-btn>
        <v-btn @click="createRequest" width="180" color="primary">Create</v-btn>
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
      title: '',
      referenceLink: '',
      rules: {
        required: v => !!v || 'This field is required',
      },
    };
  },

  watch: {
    value(val) {
      if (!val) {
        this.title = '';
        this.referenceLink = '';
      }
    },
  },

  methods: {
    async createRequest() {
      this.$refs.form.validate();
      if (!this.formValid) return;

      const response = await this.$axios.post('/employee/claim_points_requests', {
        title: this.title,
        reference_link: this.referenceLink,
      });

      if (response) {
        this.$notifier.showSuccess({ content: 'Request sent' });
        this.$emit('confirmed');
      }
    },
  },
};
</script>
