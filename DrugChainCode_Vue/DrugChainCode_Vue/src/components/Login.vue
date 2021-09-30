<template>
  <div id="login">
    <div id="login-left">
      <p class="nowTime">{{ nowTime }}</p>
      <img src="@/img/go-admin.png" class="logo" /><br />
      <p class="systemIntroduction">{{ title }}</p>
    </div>
    <div id="login-right">
      <p class="UserLoginTitle">{{ UserLoginTitle }}</p>
      <p>
        <input
          type="text"
          name="Uname"
          id="Uname"
          class="Uname"
          placeholder="用户名"
          v-model="Uname"
          ref="UnameRef"
        />
      </p>
      <p>
        <input
          type="password"
          name="Upwd"
          id="Upwd"
          class="Upwd"
          placeholder="密码"
          v-model="Upwd"
          @keyup.enter="login()"
          ref="UpwdRef"
        />
      </p>
      <p>
        <input
          type="button"
          name="loginButton"
          id="loginButton"
          class="loginButton"
          value="登               入"
          @click="login()"
        />
      </p>
      <p class="registerIntoButton">
        <a href="#/Register">还没有账号，现在注册一个--></a>
      </p>
    </div>
  </div>
</template>

<script>
import axios from "axios";
export default {
  components: {
    axios,
  },
  data() {
    return {
      title: "药品管理系统",
      nowTime: "",
      UserLoginTitle: "用户登入",
      Uname: "",
      Upwd: "",
      ReUpwd: "",
    };
  },
  mounted() {
    this.nowTimes();
  },
  created() {
    this.autoLogin();
  },
  methods: {
    timeFormate(timeStamp) {
      let year = new Date(timeStamp).getFullYear();
      let month =
        new Date(timeStamp).getMonth() + 1 < 10
          ? "0" + (new Date(timeStamp).getMonth() + 1)
          : new Date(timeStamp).getMonth() + 1;
      let date =
        new Date(timeStamp).getDate() < 10
          ? "0" + new Date(timeStamp).getDate()
          : new Date(timeStamp).getDate();
      let hh =
        new Date(timeStamp).getHours() < 10
          ? "0" + new Date(timeStamp).getHours()
          : new Date(timeStamp).getHours();
      let mm =
        new Date(timeStamp).getMinutes() < 10
          ? "0" + new Date(timeStamp).getMinutes()
          : new Date(timeStamp).getMinutes();
      let ss =
        new Date(timeStamp).getSeconds() < 10
          ? "0" + new Date(timeStamp).getSeconds()
          : new Date(timeStamp).getSeconds();
      this.nowTime =
        year +
        "-" +
        month +
        "-" +
        date +
        "  " +
        " " +
        hh +
        "时" +
        mm +
        "分" +
        ss +
        "秒";
    },
    nowTimes() {
      this.timeFormate(new Date());
      setInterval(this.nowTimes, 1000);
      this.clear();
    },
    clear() {
      clearInterval(this.nowTimes);
      this.nowTimes = null;
    },
    login() {
      if (this.Uname.trim().length == 0) {
        alert("用户名不能为空");
        this.$refs.UnameRef.focus();
      } else if (this.Upwd.trim().length == 0) {
        alert("密码不能为空");
        this.$refs.UpwdRef.focus();
      } else {
        let param = new URLSearchParams();
        param.append("Uname", this.Uname);
        param.append("Upwd", this.Upwd);
        axios.post("http://localhost:8002/Login", param).then((res) => {
          if (res.data.Code == 0) {
            alert(res.data.data);
            this.$refs.UpwdRef.focus();
          } else {
             alert("登入成功");
            sessionStorage.setItem("UserInformation", JSON.stringify(res.data.data));
            this.$router.push('/Main')
           
          }
        });
      }
    },
    autoLogin() {
      let data = JSON.parse(sessionStorage.getItem("data"));
      if (data != null) {
        this.Uname = data.Uname;
        this.Upwd = data.Upwd;
      }
    },
  },
};
</script>

<style scoped>
#login {
  position: absolute;
  top: 0;
  right: 0;
  bottom: 0;
  left: 0;
  margin: auto;
  width: 1000px;
  height: 500px;
  border: #a99faa 0px solid;
  box-shadow: 0 0 9px 9px #999;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
}

#login-left {
  width: 50%;
  height: 100%;
  float: left;
  border-right: #a99faa 1px solid;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
}

#login-right {
  width: 50%;
  height: 100%;
  float: right;
  text-align: center;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
}

.nowTime {
  margin-top: 13px;
  margin-left: 23px;
  line-height: 45px;
  font-size: 22px;
  font-family: "宋体";
  /* font-weight: bold; */
  color: #ffffff;
}

.systemIntroduction {
  color: #ffffff;
  text-align: center;
  margin-top: 11px;
  font-size: 18px;
  letter-spacing: 4px;
}

.logo {
  margin-left: 205px;
  margin-top: 120px;
  width: 90px;
  height: 90px;
}

.UserLoginTitle {
  margin-top: 100px;
  font-size: 26px;
  letter-spacing: 10px;
}

.Uname,
.Upwd {
  margin-top: 30px;
  width: 290px;
  height: 45px;
  background-color: transparent;
  border: 0px;
  padding-left: 30px;
  border-bottom: 1px #ffffff solid;
  font-size: 16px;
  outline: none;
}

.loginButton {
  margin-top: 30px;
  width: 310px;
  height: 45px;
  background-color: transparent;
  border: 0px;
  box-shadow: 0 0 2px 2px #999;
  font-size: 16px;
  font-weight: bold;
}

.loginButton:hover {
  box-shadow: 0 0 4px 4px #999;
}

.loginButton:active {
  box-shadow: 0 0 3px 3px #999;
}

.registerIntoButton {
  float: right;
  font-family: "微软雅黑";
  margin-top: 50px;
  margin-right: 20px;
}

a {
  color: #000000;
  text-decoration: none;
}

a:active {
  color: #000000;
  text-decoration: none;
}
</style>
