<template>
  <v-dialog v-model="value" persistent width="500">
    <v-card>
      <v-card-title class="justify">Employee points claim</v-card-title>
      <v-card-text>
        <v-list dense>
          <v-list-item>
            <v-list-item-content>Title:</v-list-item-content>
            <v-list-item-content class="align-end">
              {{ claim.title }}
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>From:</v-list-item-content>
            <v-list-item-content class="align-end">
              {{ claim.username }} <br />
              {{ claim.user_email }}
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>Reference:</v-list-item-content>
            <v-list-item-content class="align-end">
              <a :href="claim.reference_link" target="_blank">link</a>
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>Claim points:</v-list-item-content>
            <v-list-item-content class="align-end">
              <div v-if="claim.status === 'pending'">{{ claim_points }}</div>
              <div v-else>{{ claim.claim_points }}</div>
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>Claimable points:</v-list-item-content>
            <v-list-item-content class="align-end">
              {{ claim.user_claimable_points }}
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-card-text>

      <v-divider />
      <v-card-actions class="justify-center">
        <v-btn v-if="claim.status === 'pending'" @click="updateClaim('rejected')" width="180"
          >Reject</v-btn
        >
        <v-btn
          v-if="claim.status === 'pending'"
          @click="updateClaim('approved')"
          width="180"
          color="primary"
          >Approve</v-btn
        >
        <v-btn v-if="claim.status !== 'pending'" @click="$emit('closed')" width="180">Close</v-btn>
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
    claim: {
      type: Object,
      default: {},
    },
  },
  data() {
    return {
      claim_points: 20,
    };
  },
  methods: {
    async updateClaim(status) {
      const response = this.$axios.put(`/manager/claim_points_requests/${this.claim.id}`, {
        user_id: this.claim.user_id,
        claim_points: this.claim_points,
        status,
      });
      if (response) {
        this.$notifier.showSuccess({ content: 'Update claim successfully' });
        this.$emit('updated');
      }
    },
  },
};
</script>
