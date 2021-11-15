export default ({ store }, inject) => {
  inject('notifier', {
    showMessage({ content = '', color = 'primary'}) {
      store.commit('snackbar/showMessage', { content, color })
    },

    showError(payload) {
      let content = '';
      if (typeof payload === 'string') {
        content = payload;
      } else {
        content = payload.content;
      }
      store.commit('snackbar/showMessage', { content, color: 'error' });
    },

    showSuccess(payload) {
      let content = '';
      if (typeof payload === 'string') {
        content = payload;
      } else {
        content = payload.content;
      }
      store.commit('snackbar/showMessage', { content, color: 'success' });
    },
  })
}