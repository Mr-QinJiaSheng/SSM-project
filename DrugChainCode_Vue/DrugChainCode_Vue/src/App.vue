<template>
  <div id="app">
    <router-view></router-view>
  </div>
</template>

<script>
import Login from "@/components/Login.vue";
import Register from "@/components/Register.vue";
export default {
  components: {
    Login,
    Register,
  },
  data() {
    return {
      comName: "Login",
    };
  },
  created() {},
  methods: {},
};
</script>

<style >
* {
  padding: 0;
  margin: 0;
}

#app {
  width: 100%;
  height: 100%;
  z-index: -1;
  left: 0;
  top: 0;
  position: absolute;
  background-image: url(~@/img/background1.jpg);
  background-repeat: no-repeat;
  background-size: 100%;
}
</style>
