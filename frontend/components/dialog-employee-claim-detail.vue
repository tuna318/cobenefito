<template>
  <v-dialog v-model="value" persistent width="400">
    <v-card>
      <v-card-title class="justify-center">Points claim</v-card-title>
      <v-card-text>
        <v-list dense>
          <v-list-item>
            <v-list-item-content>Title:</v-list-item-content>
            <v-list-item-content class="align-end">
              {{ claim.title }}
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>Status:</v-list-item-content>
            <v-list-item-content class="align-end">
              {{ claim.status }}
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>Reference:</v-list-item-content>
            <v-list-item-content class="align-end">
              <a :href="claim.reference_link" target="_blank">{{ claim.reference_link }}</a>
            </v-list-item-content>
          </v-list-item>
          <v-list-item>
            <v-list-item-content>Claim points:</v-list-item-content>
            <v-list-item-content class="align-end">
              <div>{{ claim.claim_points }}</div>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-card-text>

      <v-divider />
      <v-card-actions class="justify-center">
        <v-btn @click="$emit('closed')" width="180">Close</v-btn>
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
};
</script>
