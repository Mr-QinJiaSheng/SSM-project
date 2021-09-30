var app = new Vue({
	el: '#app',
	data: {
		title: "药品管理追踪溯源系统——溯源查询",
		// explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
		Udata: '',
		DrugCode: '',
		TraceInformation: [],
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
		getTraceInformation() {
			if (this.DrugCode.trim().length == 0) {
				this.isShow_result = false;
				alert('请输入药物链码');
			} else {
				let self = this;
				$.ajax({
					url: 'http://localhost:8002/getTraceInformation',
					// url: 'http://localhost:8002/getAnti_counterfeitingInformation',
					type: "get",
					data: {
						DrugCode: this.DrugCode,
					},
					dateType: "json",
					success: function(data) {
						if (data.Code != 0) {
							self.TraceInformation[0] = data.data[0].ProductionDate + '  生产于 ' + data
								.data[0].ProductionCompany;
							for (i = 1; i < data.data.length; i++) {
								if (data.data[i].OptStatus == 1) {
									self.TraceInformation[i] = data.data[i].TradingTime + '  由  ' +
										data.data[i].Owner + '  完成收货';
								} else if (data.data[i].OptStatus == 2) {
									self.TraceInformation[i] = data.data[i].TradingTime + '  由  ' +
										data.data[i].Owner + '  发往  ' + data.data[i].Receive;
								} else {
									self.TraceInformation[i] = data.data[i].TradingTime + '  完成销售';
								}

							}
							self.isShow_result = true;
						} else {
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
