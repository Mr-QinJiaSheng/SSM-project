<template>
  <div>
    <HeadNavigationBar :UserInformationRead="UserInformation"></HeadNavigationBar>
    <router-view></router-view>
  </div>
</template>

<script>
export default {
  data() {
    return {
      UserInformation: "",
    };
  },
  created() {
    this.getUser();
  },
  methods: {
    //获取用户信息
    getUser() {
      var UserInformation = JSON.parse(
        sessionStorage.getItem("UserInformation")
      );
      if (UserInformation != null) {
        this.UserInformation = UserInformation;
      } else {
        this.$router.push("/Login");
      }
    },
  },
};
</script>

<style>
</style>