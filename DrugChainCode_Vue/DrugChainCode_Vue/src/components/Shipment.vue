<template>
  <div id="bottom">
    <p class="MainTitle">{{ title }}</p>
    <div id="function_body">
      <table>
        <tr>
          <th class="DrugCode borderRight">药物链码</th>
          <th class="DrugName borderRight">药物名称</th>
          <th class="ProductionDate borderRight">生产日期</th>

          <th class="ProductionCompany borderRight">生产公司</th>
          <th>发货</th>
        </tr>
        <tr
          v-for="(item, index) in warehouseDateJSON[Page]"
          v-show="item.OptStatus != 0"
          :key="index"
        >
          <td class="DrugCode borderRight">{{ item.DrugCode }}</td>
          <td class="DrugName borderRight">{{ item.DrugName }}</td>
          <td class="ProductionDate borderRight">{{ item.ProductionDate }}</td>

          <td class="ProductionCompany borderRight">
            {{ item.ProductionCompany }}
          </td>
          <td>
            <button
              type="button"
              class="shipment"
              @click="prepareShipment(item.DrugCode, item.DrugID)"
            >
              发货
            </button>
          </td>
        </tr>
      </table>
    </div>
    <div id="previousPage" @click="previousPage()">
      <img src="@/img/翻页1.svg" />
    </div>
    <div id="nextPage" @click="nextPage()">
      <img src="@/img/翻页2.svg" />
    </div>

    <div id="prepareShipmentBox" v-if="isShowprepareShipment">
      <div class="prepareShipmentDrugCodetext">
        药物：{{ prepareShipmentDrugCode }}
      </div>
      <div class="Receive">
        <span>将发往至：</span>
        <select v-model="ReceiveID">
          <option value="0" disabled="disabled">请选择</option>
          <option
            v-for="(item, index) in Receives"
            :value="item.UID"
            :key="index"
          >
            {{ item.CompanyName }}
          </option>
        </select>
      </div>
      <div id="cancelButton">
        <button type="button" class="cancel" @click="closePrepareShipment()">
          返回
        </button>
      </div>
      <div id="determineButton">
        <button type="button" class="determine" @click="Shipment()">
          确定
        </button>
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
      title: "药品管理追踪溯源系统——发货",
      // explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
      UserInformation: "",
      warehouseDateJSON: "",
      Page: 0,
      prepareShipmentDrugCode: "",
      prepareShipmentDrugID: "",
      isShowprepareShipment: false,
      ReceiveID: 0,
      Receives: "",
    };
  },
  created() {
    this.getUser();
  },
  mounted() {
    this.getShipmentDates();
    this.getReceives();
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
        alert("网络异常，请重试");
        this.$router.push("/Login");
      }
    },
    //获取仓库中可发货的数据
    getShipmentDates() {
      axios
        .get("http://localhost:8002/getShipmentInformation", {
          params: {
            OwnerID: this.UserInformation.UID,
          },
        })
        .then((res) => {
          if (res.data.Code != 0) {
            this.warehouseDateJSON = res.data.data;
          } else {
            alert(data.data);
          }
        });
    },
    //准备发货
    prepareShipment(DrugCode, DrugID) {
      this.prepareShipmentDrugCode = DrugCode;
      (this.prepareShipmentDrugID = DrugID),
        (this.isShowprepareShipment = true);
    },
    //关闭准备发货的界面
    closePrepareShipment() {
      this.prepareShipmentDrugCode = "";
      this.isShowprepareShipment = false;
      this.ReceiveID = 0;
    },
    //获取收件方信息
    getReceives() {
      axios
        .get("http://localhost:8002/getReceive", {
          params: {
            UID: this.UserInformation.UID,
          },
        })
        .then((res) => {
          if (res.data.Code != 0) {
            this.Receives = res.data.data;
          } else {
            alert(res.data.data);
          }
        });
    },
    //发货
    Shipment() {
      if (this.ReceiveID == 0) {
        alert("请选择收获方");
      } else {
        let param = new URLSearchParams();
        param.append("DrugCode", this.prepareShipmentDrugCode);
        param.append("DrugID", this.prepareShipmentDrugID);
        param.append("ReceiveID", this.ReceiveID);
        axios.post("http://localhost:8002/Shipment", param).then((res) => {
          if (res.data.Code == 0) {
            alert("网络异常，请重试");
          } else {
            this.closePrepareShipment();
            alert(res.data.data);
          }
          this.getShipmentDates();
        });
      }
    },
    //上一页
    previousPage() {
      if (this.Page > 0) {
        this.Page--;
      } else {
        alert("已经是第一页了");
      }
    },
    //下一页
    nextPage() {
      if (this.Page < this.warehouseDateJSON.length - 1) {
        this.Page++;
      } else {
        alert("已经是最后一页了");
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


#previousPage,
#nextPage {
	position: absolute;
	top: 45%;
}

#previousPage {
	left: 20px;
}

#nextPage {
	right: 20px;
}

#function_body {
	border: #A99FAA 0px solid;
	box-shadow: 0 0 5px 5px #799998;
	margin: 0 auto;
	margin-top: 70px;
	width: 80%;

	position: relative;
}

#function_body table {


	width: 100%;
	height: 40px;
	line-height: 40px;
	text-align: center;
	border-spacing: 10px;
}

#function_body .borderRight {

	border-right: #000000 1px solid;
}
#function_body .shipment{
	width: 100px;
	height: 30px;
	
	font-size: 20px;
	font-weight: bold;
	border-radius: 25px;
	background-color: #96CBB7;
	color: #1E1E1E;
}
#prepareShipmentBox{
	width: 20%;
	height: 30%;
	background-color: #396868;
	position: absolute;
	top: 30%;
	
	left: 39%;
	font-size: 22px;
}
#prepareShipmentBox .prepareShipmentDrugCodetext,#prepareShipmentBox .Receive{
	margin-top: 20px;
	margin-left: 50px;
	height: 45px;
	line-height: 45px;
}
#prepareShipmentBox .prepareShipmentDrugCodetext{
	margin-top: 0px;
	padding-top: 40px;
}
#prepareShipmentBox .Receive span{
	height: 45px;
	line-height: 45px;
}
#prepareShipmentBox .Receive select{
	width: 170px;
	height: 45px;
	BACKGROUND-COLOR: transparent;
	border: 0px;
	padding-left: 0px;
	margin-top: 30px;
	font-size: 16px;
	outline: none;
	border-bottom: 1px #FFFFFF solid;
	text-align: center;
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
	background-color: #96CBB7;
	color: #1E1E1E;
}
</style>