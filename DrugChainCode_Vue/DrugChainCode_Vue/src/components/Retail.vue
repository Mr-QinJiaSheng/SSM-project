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
        <tr v-for="(item, index) in warehouseDateJSON[Page]" v-show="item.OptStatus != 0" :key="index">
          <td class="DrugCode borderRight">{{ item.DrugCode }}</td>
          <td class="DrugName borderRight">{{ item.DrugName }}</td>
          <td class="ProductionDate borderRight">{{ item.ProductionDate }}</td>

          <td class="ProductionCompany borderRight">
            {{ item.ProductionCompany }}
          </td>
          <td>
            <button type="button" class="shipment" @click="Retailing(item.DrugCode, item.DrugID)">
              售出
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
      title: '药品管理追踪溯源系统——零售',
      // explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
      UserInformation: '',
      warehouseDateJSON: '',
      Page: 0
    }
  },

  created() {
    this.getUser()
  },
  mounted() {
    this.getRetailDates()
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

    //获取可零售的数据
    getRetailDates() {
      axios
        .get('http://localhost:8002/getRetailDates', {
          params: {
            OwnerID: this.UserInformation.UID
          }
        })
        .then(res => {
          if (res.data.Code != 0) {
            this.warehouseDateJSON = res.data.data
          } else {
            alert(res.data.data)
          }
        })
    },

    //售出
    Retailing(DrugCode, DrugID) {
      let param = new URLSearchParams()
      param.append('DrugCode', DrugCode)
      param.append('DrugID', DrugID)
      axios.post('http://localhost:8002/Retailing', param).then(res => {
        alert(res.data.data)
        if (res.data.Code != 0) {
          this.getRetailDates()
        }
      })
    }

    //
  }
}
</script>

<style scoped>
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
  border: #a99faa 0px solid;
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
#function_body .shipment {
  width: 100px;
  height: 30px;

  font-size: 20px;
  font-weight: bold;
  border-radius: 25px;
  background-color: #96cbb7;
  color: #1e1e1e;
}
</style>
