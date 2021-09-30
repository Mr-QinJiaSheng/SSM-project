<template>

    <div id="register">
      <p class="UserRegisterTitle">
        <span> {{ UserRegisterTitle }}</span>
      </p>
      <div id="register_left">
        <div>
          <span>用户名：</span
          ><input
            type="text"
            id="Uname"
            class="Uname"
            placeholder="用户名"
            v-model="Uname"
            ref="UnameRef"
          />
        </div>
        <div>
          <span>密码：</span
          ><input
            type="password"
            id="Upwd"
            class="Upwd"
            placeholder="密码"
            v-model="Upwd"
            ref="UpwdRef"
          />
        </div>
        <div>
          <span>确认密码：</span
          ><input
            type="password"
            id="ReUpwd"
            class="ReUpwd"
            placeholder="确认密码"
            v-model="ReUpwd"
            ref="ReUpwdRef"
          />
        </div>
        <div>
          <span>公司名称：</span
          ><input
            type="text"
            id="CompanyName"
            class="CompanyName"
            placeholder="公司名称"
            v-model="CompanyName"
            ref="CompanyNameRef"
          />
        </div>
      </div>
      <div id="register_right">
        <div>
          <span>负责人：</span
          ><input
            type="text"
            id="Director"
            class="Director"
            placeholder="负责人"
            v-model="Director"
            ref="DirectorRef"
          />
        </div>
        <div>
          <span>地址：</span
          ><input
            type="text"
            id="Address"
            class="Address"
            placeholder="地址"
            v-model="Address"
            ref="AddressRef"
          />
        </div>
        <div>
          <span>电话：</span
          ><input
            type="text"
            id="PhoneNUM"
            class="PhoneNUM"
            placeholder="电话"
            v-model="PhoneNUM"
            ref="PhoneNUMRef"
          />
        </div>
        <div id="Power">
          <span>类型：</span
          ><select name="Power" class="selectPower" v-model="Power">
            <option value="1">生产商</option>
            <option value="2">经销商</option>
          </select>
        </div>
      </div>
      <p class="registerButtonP">
        <button type="button" class="registerButton" @click="register()">
          确认注册
        </button>
      </p>
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
      UserRegisterTitle: "注册",
      Uname: "",
      Upwd: "",
      ReUpwd: "",
      CompanyName: "",
      Director: "",
      Address: "",
      PhoneNUM: "",
      Power: 1,
    };
  },
  methods: {
    register() {
      if (this.Uname.trim().length == 0) {
        alert("用户名不能为空");
        this.$refs.UnameRef.focus();
      } else if (this.Upwd.trim().length == 0) {
        alert("密码不能为空");
        this.$refs.UpwdRef.focus();
      } else if (this.ReUpwd.trim().length == 0) {
        alert("确认密码不能为空");
        this.$refs.ReUpwdRef.focus();
      } else if (this.ReUpwd.trim() != this.Upwd.trim()) {
        alert("两次密码不一致");
        this.$refs.ReUpwdRef.focus();
      } else if (this.CompanyName.trim().length == 0) {
        alert("公司名称不能为空");
        this.$refs.CompanyNameRef.focus();
      } else if (this.Director.trim().length == 0) {
        alert("负责人不能为空");
        this.$refs.DirectorRef.focus();
      } else if (this.Address.trim().length == 0) {
        alert("公司地址不能为空");
        this.$refs.AddressRef.focus();
      } else if (this.PhoneNUM.trim().length == 0) {
        alert("公司联系方式不能为空");
        this.$refs.PhoneNUMRef.focus();
      } else if (this.PhoneNUM.trim().length != 11) {
        alert("联系方式填写有误");
        this.$refs.PhoneNUMRef.focus();
      } else {
        let param = new URLSearchParams();
        param.append("Uname", this.Uname);
        param.append("Upwd", this.Upwd);
        param.append("CompanyName", this.CompanyName);
        param.append("Director", this.Director);
        param.append("Address", this.Address);
        param.append("PhoneNUM", this.PhoneNUM);
        param.append("Power", this.Power);
        axios.post("http://localhost:8002/Register", param).then((res) => {
          if (res.data.Code == 0) {
            alert(res.data.data);
            this.$refs.UnameRef.focus();
          } else {
            alert("注册成功，点击确认跳转到登入界面");

            sessionStorage.setItem("data", JSON.stringify(res.data.data));
            this.$router.push('/Login')
          }
        });
      }
    },
  },
};
</script>

<style scoped>
#register {
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

.Uname,
.Upwd,
.ReUpwd,
.CompanyName,
.Director,
.PhoneNUM,
.Address {
  margin-top: 30px;
  width: 240px;
  height: 45px;
  background-color: transparent;
  border: 0px;
  padding-left: 30px;
  border-bottom: 1px #ffffff solid;
  font-size: 16px;
  outline: none;
}

.registerButton {
  margin-top: 30px;
  width: 310px;
  height: 45px;
  background-color: transparent;
  border: 0px;
  box-shadow: 0 0 2px 2px #999;
  font-size: 16px;
  font-weight: bold;
}

.registerButton:hover {
  box-shadow: 0 0 4px 4px #999;
}

.registerButton:active {
  box-shadow: 0 0 3px 3px #999;
}

#register_left,
#register_right {
  width: 50%;
  height: 310px;
  text-align: center;
  float: left;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
}

#register_right {
  float: right;
}

#register_left span,
#register_right span {
  display: inline-block;
  width: 150px;
  height: 45px;
  line-height: 45px;
  text-align: justify;
  text-align-last: justify;
  -moz-text-align-last: justify;
}

.UserRegisterTitle {
  text-align: center;
  margin-top: 10px;
}

.UserRegisterTitle span {
  width: 100%;
  height: 5px;
  letter-spacing: 20px;

  font-size: 50px;
  text-align: justify;
  text-align-last: justify;
}

.registerButton {
  margin-top: 30px;
  width: 310px;
  height: 45px;
  background-color: transparent;
  border: 0px;
  box-shadow: 0 0 2px 2px #999;
  font-size: 16px;
  letter-spacing: 20px;
  font-weight: bold;
}

.registerButtonP {
  text-align: center;
}

#Power {
  /* width: 100%; */
  height: 75px;
  float: left;
  text-align: left;
  margin-left: 40px;
  box-sizing: border-box;
  -moz-box-sizing: border-box;
  -webkit-box-sizing: border-box;
}
#Power span {
  width: 150px;
}
.selectPower {
  width: 150px;
  height: 45px;
  background-color: transparent;
  border: 0px;
  padding-left: 30px;
  margin-top: 30px;
  font-size: 16px;
  outline: none;
  border-bottom: 1px #ffffff solid;
}
</style>