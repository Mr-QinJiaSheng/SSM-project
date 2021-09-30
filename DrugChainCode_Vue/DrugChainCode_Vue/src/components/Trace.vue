<template>
  <div id="bottom">
    <p class="MainTitle">{{ title }}</p>

    <div id="Search">
      <input
        type="text"
        placeholder="在这里输入药物链码"
        v-model="DrugCode"
        @keyup-enter="getTraceInformation()"
      />
      <img src="@/img/搜索.svg" @click="getTraceInformation()" />
    </div>

    <div id="result" v-if="isShow_result">
      <div
        class="TraceInformation"
        v-for="(item, index) in TraceInformation"
        :key="index"
      >
        {{ item }}
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
      title: "药品管理追踪溯源系统——溯源查询",
      // explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
      DrugCode: "",
      TraceInformation: [],
      isShow_result: false,
    };
  },
  methods: {
    //获取防伪信息
    getTraceInformation() {
      if (this.DrugCode.trim().length == 0) {
        this.isShow_result = false;
        alert("请输入药物链码");
      } else {
        axios
          .get("http://localhost:8002/getTraceInformation", {
            params: {
              DrugCode: this.DrugCode,
            },
          })
          .then((res) => {
            this.TraceInformation = [];

            //当Code为0的时候，查询出错
            if (res.data.Code != 0) {
              //设置药物的第一天记录固定为  生产日期加上生产公司
              this.TraceInformation[0] =
                res.data.data[0].ProductionDate +
                "  生产于 " +
                res.data.data[0].ProductionCompany;
              //从第二条记录开始，分析药物的历史记录
              for (let i = 1; i < res.data.data.length; i++) {
                //OptStatus为1时，说明药物当时正保存在厂库中
                if (res.data.data[i].OptStatus == 1) {
                  this.TraceInformation[i] =
                    res.data.data[i].TradingTime +
                    "  由  " +
                    res.data.data[i].Owner +
                    "  完成收货";
                  //OptStatus为2时，说明药物当时正保存在运输过程中
                } else if (res.data.data[i].OptStatus == 2) {
                  this.TraceInformation[i] =
                    res.data.data[i].TradingTime +
                    "  由  " +
                    res.data.data[i].Owner +
                    "  发往  " +
                    res.data.data[i].Receive;
                  //OptStatus为3时，说明药物已完成销售
                } else {
                  this.TraceInformation[i] =
                    res.data.data[i].TradingTime + "  完成销售";
                }
              }
              //将结果显示出来，显示结果的地方默认隐藏
              this.isShow_result = true;
            } else {
              //打印错误信息
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
  box-shadow: 0 0 5px 5px #838a90;
  position: relative;
}

#result .TraceInformation {
  font-size: 26px;
  margin-top: 40px;
  margin-left: 15%;
}
#result .TraceInformation {
  margin-top: 0px;
  padding-top: 30px;
}
</style>