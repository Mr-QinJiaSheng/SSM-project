<template>
  <div id="bottom">
    <p class="MainTitle">{{ title }}</p>

    <div id="Search">
      <input type="text"  placeholder="在这里输入药物链码" v-model="DrugCode" @keyup-enter="getAnti_counterfeitingInformation()"
      />
      <img src="@/img/搜索.svg" @click="getAnti_counterfeitingInformation()" />
    </div>

    <div id="result" v-if="isShow_result">
      <div class="DrugName">药物名称：{{ DrugName }}</div>
      <div class="ProductionCompany">生产公司：{{ ProductionCompany }}</div>
      <div class="ProductionDate">生产日期：{{ ProductionDate }}</div>
      <div class="OptStatus">当前状态：</div>
      <div class="OptStatus_text">
        {{ OptStatus }}
      </div>
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
      title: "药品管理追踪溯源系统——防伪查询",
      // explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
      DrugCode: "",
      DrugName: "",
      ProductionDate: "",
      ProductionCompany: "",
      OptStatus: "",
      isShow_result: false,
    };
  },
  methods: {
    //获取防伪信息
    getAnti_counterfeitingInformation() {
      if (this.DrugCode.trim().length == 0) {
        this.isShow_result = false;
        alert("请输入药物链码");
      } else {
        axios
          .get("http://localhost:8002/getAnti_counterfeitingInformation", {
            params: {
              DrugCode: this.DrugCode,
            },
          })
          .then((res) => {
            if (res.data.Code != 0) {
              this.DrugName = res.data.data.DrugName;

              this.ProductionDate = res.data.data.ProductionDate;

              this.ProductionCompany = res.data.data.ProductionCompany;

              if (res.data.data.OptStatus == 1) {
                this.OptStatus =
                  '本产品目前存放于  "' + res.data.data.Owner + '"  的仓库中';
              } else if (res.data.data.OptStatus == 2) {
                this.OptStatus =
                  "本产品目前正在运输中，由" +
                  res.data.data.Owner +
                  '"  仓库正在发往' +
                  res.data.data.Receive +
                  '"  仓库,交易订单为："' +
                  res.data.data.ShipmentNUM +
                  '"';
              } else {
                this.OptStatus = "已售出";
              }

              this.isShow_result = true;
            } else {
              alert(res.data.data);
            }
          });
      }
    },
  },
};
</script>

<style scoped>
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
#Search {
  position: relative;
  margin: 0 auto;
  margin-top: 40px;
  height: 50px;
  text-align: center;
}

#Search input {
  line-height: 10px;
  width: 600px;
  height: 45px;
  line-height: 45px;
  background-color: transparent;
  border: 0px;
  box-shadow: 0 0 3px 5px #838a90;

  font-size: 22px;
  outline: none;
  color: #000000;
  text-align: center;
}

#Search img {
  position: absolute;
  z-index: 1;
  right: 660px;
  border-left: #838a90 3px solid;
  width: 45px;
  height: 45px;

  margin-bottom: 7px;
}

#result {
  margin: 0 auto;
  margin-top: 40px;
  width: 50%;
  height: 60%;
  box-shadow: 0 0 3px 5px #838a90;
  position: relative;
}

#result .DrugName,
#result .ProductionCompany,
#result .ProductionDate,
#result .OptStatus {
  font-size: 30px;
  margin-top: 40px;
  margin-left: 25%;
}
#result .DrugName {
  margin-top: 0px;
  padding-top: 30px;
}
#result .OptStatus_text {
  position: absolute;
  font-size: 30px;
  width: 350px;
  left: 390px;
  top: 270px;
}
</style>