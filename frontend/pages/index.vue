<template>
  <div>
    <div class="welcome__header">
      <div class="welcome__logo">
        <v-img src="coupon.png" max-width="50" max-height="50" />
      </div>
      <div class="welcome__app-name">Cobenefito</div>
      <v-spacer />
      <div class="welcome__nav-item">Contact</div>
      <div class="welcome__nav-item">About us</div>
    </div>

    <div class="welcome__content">
      <div class="welcome__text">
        <h1 class="secondary--text">Cobenefito</h1>
        <p>A wonderful place to manage company coupons</p>
        <div class="my-2">
          <h3>
            <nuxt-link to="/register" class="accent--text"> Create a benefito space now </nuxt-link>
          </h3>
          <h3>
            or
            <nuxt-link to="/login" class="accent--text"> Join one </nuxt-link>
          </h3>
        </div>

        <p>It's completely free</p>
      </div>
      <div class="welcome__banner">
        <v-img src="banner.png" max-width="600" max-height="500" />
      </div>
    </div>
  </div>
</template>

<script>
export default {
  layout: 'empty',
  auth: 'guest',
};
</script>

<style lang="sass" scoped>
.welcome
  &__header, &__content
    display: flex
    flex-flow: row wrap

  &__header
    padding: 10px 50px

  &__content
    padding: 80px 100px

  &__text
    padding: 100px 0 50px 100px

  &__app-name
    height: 50px
    line-height: 50px
    margin-left: 20px
    font-size: 24px
    font-weight: 600

  &__nav-item
    height: 50px
    line-height: 50px
    margin-left: 30px
    font-weight: 500
    &:hover
      cursor: pointer

  &__text
    width: 45%

  &__banner
    width: 55%
</style>