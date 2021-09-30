<template>
  <div id="bottom">
				<p class="MainTitle">{{title}}</p>

				<div id="function_body">
					<div class="DrugName">
						<span>
							药物名称：
						</span>
						<input type="text" id="DrugName" v-model="DrugName" ref="DrugNameRef"/>
					</div>
					<div class="DrugComposition">
						<span>
							药物成分：
						</span>
						<input type="text" id="DrugComposition" v-model="DrugComposition" ref="DrugCompositionRef"/>
					</div>
					<div class="UsageMethod">
						<span>
							使用方法：
						</span>
						<input type="text" id="UsageMethod" v-model="UsageMethod" ref="UsageMethodRef"/>
					</div>
					<div class="MainFunction">
						<span>
							主治功能：
						</span>
						<input type="text" id="MainFunction" v-model="MainFunction" ref="MainFunctionRef"/>
					</div>
					<!-- <div class="explanation">
						{{explanation}}
					</div> -->
					<div id="cancelButton">
						<button type="button" class="cancel" @click="goback()">返回</button>
					</div>
					<div id="determineButton">
						<button type="button" class="determine" @click="addDrugType()">确定</button>
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
      title: "药品管理追踪溯源系统——药物研发",
		explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
		DrugName: '',
		DrugComposition: '',
		UsageMethod: '',
		MainFunction: '',
		UserInformation:'',
    };
  },
  created() {
    this.getUser();
  },
  methods:{
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
    //新增药品种类
		addDrugType() {
			if (this.DrugName.trim().length == 0) {
				alert("药物名称不能为空");
                this.$refs.DrugNameRef.focus()
			} else if (this.DrugComposition.trim().length == 0) {
				alert("药物成分不能为空");
				 this.$refs.DrugCompositionRef.focus()
			} else if (this.UsageMethod.trim().length == 0) {
				alert("使用方法不能为空");
				 this.$refs.UsageMethodRef.focus()
			} else if (this.MainFunction.trim().length == 0) {
				alert("主治功能不能为空");
				 this.$refs.MainFunctionRef.focus()
			} else{
                let param =new URLSearchParams
                param.append('DrugName',this.DrugName)
                param.append('DrugComposition',this.DrugComposition)
                param.append('UsageMethod',this.UsageMethod)
                param.append('MainFunction',this.MainFunction)
                axios.post('http://localhost:8002/addDrugType',param).then((res)=>{
                    if (res.data.Code == 0) {
						const reg = RegExp(/Error 1062/);
						if (res.data.data.match(reg)) {
							alert('该药品已存在');
						}
					} else {
						alert(res.data.data);
						this.DrugName = '';
						this.DrugComposition = '';
						this.UsageMethod = '';
						this.MainFunction = '';
					}
                })
            }
		},
        //回到上一个界面
		goback() {
			this.$router.back();
		},
  }
}
</script>

<style scoped>


#function_body {
	border: #A99FAA 0px solid;
	box-shadow: 0 0 5px 5px #799998;
	margin: 0 auto;
	margin-top: 100px;
	width: 25%;
	height: 55%;
	position: relative;
}




#function_body .DrugName,
#function_body .DrugComposition,
#function_body .UsageMethod,
#function_body .MainFunction {
	height: 50px;
	width: 350px;
	line-height: 50px;
	margin: 0 auto;
	padding-top: 40px;

	color: #000000;
}




#function_body input {
	line-height: 10px;
	width: 250px;
	height: 45px;
	BACKGROUND-COLOR: transparent;
	border: 0px;
	border-bottom: 1px #FFFFFF solid;
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
	background-color: #96CBB7;
	color: #1E1E1E;
}

</style>