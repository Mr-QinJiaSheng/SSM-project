<template>
  <div id="bottom">
    <p class="MainTitle">{{ title }}</p>

    <div id="function_body">
      <div class="DrugName">
        <span> 药物名称： </span>
        <select v-model="DrugID">
          <option value="0" disabled>请选择</option>
          <option v-for="(item, index) in DrugType" :value="item.DrugID" :key="index">
            {{ item.DrugName }}
          </option>
        </select>
      </div>
      <div class="ProductionDate">
        <span> 生产日期： </span>
        <input type="date" v-model="ProductionDate" />
      </div>
      <div class="explanation">
        {{ explanation }}
      </div>
      <div id="cancelButton">
        <button type="button" class="cancel" @click="goback()">返回</button>
      </div>
      <div id="determineButton">
        <button type="button" class="determine" @click="productionDrug()">
          确定
        </button>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios'
export default {
  components: {
    axios
  },
  data() {
    return {
      title: '药品管理追踪溯源系统——药物生产',
      explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
      DrugID: 0,
      DrugType: [],
      UserInformation: '',
      ProductionDate: ''
    }
  },
  created() {
    this.getUser()
  },
  mounted() {
    this.getDrugType()
  },
  methods: {
    //获取用户信息
    getUser() {
      var UserInformation = JSON.parse(sessionStorage.getItem('UserInformation'))
      if (UserInformation != null) {
        this.UserInformation = UserInformation
      } else {
        alert('网络异常，请重试')
        this.$router.push('/Login')
      }
    },

    //获取药物类别信息
    getDrugType() {
      axios.get('http://localhost:8002/getDrugType').then(res => {
        if (res.data.Code != 0) {
          this.DrugType = res.data.data
        } else {
          alert(res.data.data)
        }
      })
    },
    productionDrug() {
      let UdataByte = JSON.stringify(this.UserInformation)

      //获取年月日
      let year = new Date().getFullYear()
      let month = new Date().getMonth() + 1 < 10 ? '0' + (new Date().getMonth() + 1) : new Date().getMonth() + 1
      let day = new Date().getDate() < 10 ? '0' + new Date().getDate() : new Date().getDate()
      let date = year + '' + month + '' + day
      //我也不知道为什么需要两次才能去掉"-"
      let productionDrugNUM = this.ProductionDate.replace('-', '')
      productionDrugNUM = productionDrugNUM.replace('-', '')

      if (this.DrugID == 0) {
        alert('请选择药物名称')
      } else if (this.ProductionDate.trim().length == 0) {
        alert('请输入生产日期')
      } else if (productionDrugNUM > date) {
        alert('请输入正确的生产日期')
      } else {
        let param = new URLSearchParams()
        param.append('DrugID', this.DrugID)
        param.append('ProductionDate', this.ProductionDate)
        param.append('Udata', UdataByte)
        axios.post('http://localhost:8002/productionDrug', param).then(res => {
          alert(res.data.data)
        })
      }
    },
    //回到上一个界面
    goback() {
      this.$router.back()
    }
  }
}
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
#function_body {
  border: #a99faa 0px solid;
  box-shadow: 0 0 5px 5px #799998;
  margin: 0 auto;
  margin-top: 100px;
  width: 25%;
  height: 45%;
  position: relative;
}

#function_body .DrugName,
#function_body .ProductionDate {
  height: 50px;
  width: 300px;
  line-height: 50px;
  margin: 0 auto;
  padding-top: 40px;

  color: #000000;
}

#function_body .DrugName select,
#function_body .ProductionDate input {
  width: 200px;
  height: 45px;
  background-color: transparent;
  border: 0px;
  border-bottom: 1px #ffffff solid;
  font-size: 16px;
  outline: none;
  color: #000000;
}

#function_body .explanation {
  width: 80%;
  margin: 0 auto;
  margin-top: 50px;
  color: #666;
  text-indent: 2em;
  line-height: 25px;
  font-size: 12px;
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
