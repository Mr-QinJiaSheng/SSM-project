var app = new Vue({
	el: '#app',
	data: {
		title: "药品管理追踪溯源系统——防伪查询",
		// explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
		Udata: '',
		DrugCode: '',
		DrugName: '',
		ProductionDate: '',
		ProductionCompany: '',
		OptStatus: '',
		isShow_result: false,
	},
	created() {
		this.getUser();
	},
	mounted() {
		this.displaySignOut();
	},
	computed: {

	},
	methods: {
		//获取用户信息
		getUser() {
			var Udata = JSON.parse(sessionStorage.getItem("Udata"));
			if (Udata != null) {
				this.Udata = Udata;
			}

		},
		//退出延时器
		displaySignOut() {
			$('.twoMenu').hide();
			$('.welecomTitle').hover(function() {
				$('.twoMenu').show();

			}, function() {
				var b = setTimeout(function() {
					$('.twoMenu').hide();
				}, 500)
			})
		},
		//获取防伪信息
		getAnti_counterfeitingInformation() {
			if (this.DrugCode.trim().length == 0) {
				this.isShow_result = false;
				alert('请输入药物链码');
			} else {
				let self = this;
				$.ajax({
					// url: 'http://localhost:8002/getAnti_counterfeitingInformation',
					url: 'http://localhost:8002/getAnti_counterfeitingInformation',
					type: "get",
					data: {
						DrugCode: this.DrugCode,
					},
					dateType: "json",
					success: function(data) {
						if (data.Code != 0) {
							self.DrugName = data.data.DrugName;

							self.ProductionDate = data.data.ProductionDate;

							self.ProductionCompany = data.data.ProductionCompany;

							if (data.data.OptStatus == 1) {
								self.OptStatus = '本产品目前存放于  "' + data.data.Owner + '"  的仓库中';
							} else if (data.data.OptStatus == 2) {
								self.OptStatus = '本产品目前正在运输中，由' + data.data.Owner + '"  仓库正在发往' +
									data.data.Receive + '"  仓库,交易订单为："' + data.data.ShipmentNUM + '"';
							}else{
								self.OptStatus ='已售出';
							}

							self.isShow_result = true;
						}else{
							alert(data.data);
						}

					},

				});
			}
		},
		goback() {
			window.history.back();
		},

	}
});
