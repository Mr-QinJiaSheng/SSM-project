<template>
  <div id="bottom">
    <p class="MainTitle">{{ title }}</p>

    <div
      v-for="(divsdata, index) in divdata"
      :key="index"
      :id="getFunctionalModuleID(index)"
      @click="Entry(divsdata.ClassName)"
    >
      <img :src="require('@/img/' + divsdata.ImgSrc)" />

      <p class="menu">{{ divsdata.Name }}</p>
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
      title: "药品管理追踪溯源系统",
      divdata: "",
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
        this.getFunctionalModule(UserInformation.Power);
      } else {
        alert("网络异常，请重试");
        this.$router.push("/Login");
      }
    },
    //查询用户功能权限
    getFunctionalModule(power) {
      axios
        .get("http://localhost:8002/getFunctionalModule", {
          params: {
            Power: power,
          },
        })
        .then((res) => {
          if (res.data.Code == 0) {
            alert(res.data.data);
          } else {
            this.divdata = res.data.data;
          }
        });
    },
    //设置模块div的id
    getFunctionalModuleID(index) {
      return "FunctionalModule" + (index + 1);
    },
    //模块入口
    Entry(FunctionName) {
      switch (FunctionName) {
        case "Production":
          this.$router.push("Production");
          break;
        case "Research_and_development":
          this.$router.push("Research_and_development");
          break;
        case "Warehouse":
          this.$router.push("Warehouse");
          break;
        case "Anti_counterfeiting":
          this.$router.push("Anti_counterfeiting");
          break;
        case "Trace":
          this.$router.push("Trace");
          break;
        case "Warehousing":
          this.$router.push("Warehousing");
          break;
        case "Shipment":
          this.$router.push("Shipment");
          break;
        case "Retail":
          this.$router.push("Retail");
          break;
      }
    },
  },
};
</script>

<style >
#bottom {
	width: 100%;
	position: absolute;
	top: 75px;
	bottom: 0px;
	left: 0px;

}

#bottom .MainTitle {
	margin: 0 auto;
	margin-top: 50px;
	width: 100%;
	font-size: 50px;
	/* 设置字符间距 */
	letter-spacing: 5px;
	text-align: center;
}
#FunctionalModule1,
#FunctionalModule2,
#FunctionalModule3,
#FunctionalModule4,
#FunctionalModule5,
#FunctionalModule6,
#FunctionalModule7,
#FunctionalModule8 {
  position: absolute;
  padding-top: 10px;
  width: 200px;
  height: 200px;
  text-align: center;
  top: 30%;
}

#FunctionalModule5,
#FunctionalModule6,
#FunctionalModule7,
#FunctionalModule8 {
  top: 63%;
}

#FunctionalModule1,
#FunctionalModule5 {
  left: 15%;
}

#FunctionalModule2,
#FunctionalModule6 {
  left: 35%;
}

#FunctionalModule3,
#FunctionalModule7 {
  right: 35%;
}

#FunctionalModule4,
#FunctionalModule8 {
  right: 15%;
}

/* 设置生产弹窗 */
#productionDialogBox {
  width: 400px;
  height: 300px;

  position: absolute;
  top: 27%;
  left: 39%;

  text-align: center;
}

#productionDialogBox .DialogBox-title {
  width: 100%;
  height: 50px;
  text-align: center;
  background-color: #2a4f4f;
  padding-top: 10px;
}

#productionDialogBox .title {
  background-color: #568686;

  margin: auto;

  width: 150px;
  height: 40px;
  font-size: 30px;
  color: #bfbfbf;
  border-top-left-radius: 15px;
  border-top-right-radius: 15px;
}

#productionDialogBox .DialogBox-body {
  text-align: left;

  width: 100%;
  position: absolute;
  top: 50px;
  bottom: 0;

  background-color: #396868;
}

#productionDialogBox .DrugName,
#productionDialogBox .ProductionDate {
  height: 50px;
  width: 300px;
  line-height: 50px;

  margin: auto;
  margin-top: 30px;
  background-color: #396868;
  color: #bfbfbf;
}

#productionDialogBox .DrugName select,
#productionDialogBox .ProductionDate input {
  line-height: 10px;
  width: 200px;
  height: 45px;
  background-color: transparent;
  border: 0px;
  border-bottom: 1px #ffffff solid;
  font-size: 16px;
  outline: none;
  color: #bfbfbf;
}

/* 设置药物研发弹窗 */
#RAndDBox {
  width: 400px;
  height: 300px;

  position: absolute;
  top: 27%;
  left: 39%;

  text-align: center;
}

#RAndDBox .DialogBox-title {
  width: 100%;
  height: 50px;
  text-align: center;
  background-color: #959dad;
  padding-top: 10px;
}

#RAndDBox .title {
  background-color: #959dad;

  margin: auto;

  width: 150px;
  height: 40px;
  font-size: 30px;
  color: #bfbfbf;
  border-top-left-radius: 15px;
  border-top-right-radius: 15px;
}

#RAndDBox .DialogBox-body {
  text-align: left;

  width: 100%;
  position: absolute;
  top: 50px;
  bottom: 0;

  background-color: #959dad;
}

/* 设置取消和确认按钮 */

#cancelButton,
#determineButton {
  position: absolute;
  bottom: 0px;
  margin-bottom: 10px;
}

#cancelButton {
  left: 30px;
}

#determineButton {
  right: 30px;
}

#cancelButton .cancel,
#determineButton .determine {
  width: 130px;
  height: 40px;

  font-size: 20px;
  font-weight: bold;
  border-radius: 25px;
}

#cancelButton .cancel {
  float: left;
  background-color: #568686;
  color: #bfbfbf;
}

#determineButton .determine {
  float: right;
  background-color: #96cbb7;
  color: #1e1e1e;
}
</style>