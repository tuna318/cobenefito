export default {
  data() {
    return {
      snackbar: false,
      snackbarContent: '',
      snackbarColor: 'error'
    }
  },

  created() {
    this.$store.subscribe((mutation, state) => {
      if (mutation.type === 'snackbar/showMessage') {
        this.snackbarContent = state.snackbar.content;
        this.snackbarColor = state.snackbar.color;
        this.snackbar = true;
      }
    }); 

    this.registerAxiosErrorHandler();
  },

  methods: {
    registerAxiosErrorHandler() {
      this.$axios.onResponseError(error => {
        if (process.client) {
          const content = error.response && error.response.data ? error.response.data.message : 'Unknow error'
          this.$notifier.showError({ content })
          return Promise.resolve(false);
        }
      })
    }
  }
}