<template>
  <div id="top">
    <div id="close">
      <img src="@/img/返回.svg" @click="goback()" />
    </div>
    <div id="welcome">
      <ul class="oneMenu">
        <li class="welecomTitle" @mouseenter="enterFun()"  @mouseleave="leaveFun()">
          {{ UserInformation.CompanyName }}
          <ul class="twoMenu" v-if="isShow">
            <li class="signout">
              <a href="#/Login">退出登入<img src="@/img/退出.svg" /></a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </div>
</template>

<script>
export default {
  props: ["UserInformationRead"],
  data() {
    return {
      isShow: false,
      UserInformation:this.UserInformationRead
    };
  },
  created() {
  },
  methods: {
    //鼠标移入
    enterFun() {
      this.isShow = true;
    },
    //鼠标移出
    leaveFun() {
      setTimeout(() => {
        this.isShow = false;
      },500);
    },
    //回到上一个界面
    goback() {
      this.$router.back();
    },
  },
};
</script>

<style >
a {
  color: #000000;
  text-decoration: none;
}

a:active {
  color: #000000;
  text-decoration: none;
}


#top {
  width: 100%;
  height: 75px;
}

#close {
  margin-top: 20px;
  margin-left: 50px;
}

#welcome {
  position: absolute;
  top: 0;
  right: 0;
  z-index: 1;
}

/* 消除样式 */
ul,
li {
  list-style: none;
}

.oneMenu {
  /* 设置边距 */
  margin-right: 20px;
  margin-top: 20px;
  /* 浮动 */
  float: right;
  /* 设置字体 */
  font-size: 30px;
}

.twoMenu {
  /* 设置行高 */
  height: 50px;
  line-height: 50px;
  /* 设置字体 */
  letter-spacing: 5px;
  font-size: 22px;
  text-align: right;

  /* 设置背景图 */
}
.twoMenu img {
  vertical-align: middle;
}
#top a:link,
#top a:visited {
  display: block;
  /*给a标签设置成块级元素*/
  width: 100%;
  height: 100%;
}


</style>