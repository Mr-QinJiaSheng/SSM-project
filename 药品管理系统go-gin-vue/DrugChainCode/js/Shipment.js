var app = new Vue({
	el: '#app',
	data: {
		title: "药品管理追踪溯源系统——发货",
		// explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
		Udata: '',
		warehouseDateJSON: '',
		Page: 0,
		prepareShipmentDrugCode: '',
		prepareShipmentDrugID: '',
		isShowprepareShipment: false,
		ReceiveID: 0,
		Receives: '',
	},
	created() {
		this.getUser();
		this.getReceives();
	},
	mounted() {
		this.displaySignOut();

	},
	methods: {
		//获取用户信息
		getUser() {
			var Udata = JSON.parse(sessionStorage.getItem("Udata"));
			if (Udata != null) {
				this.Udata = Udata;
				this.getShipmentDates();
			}

		},
		//获取仓库中可发货的数据
		getShipmentDates() {
			let self = this;
			$.ajax({
				url: 'http://localhost:8002/getShipmentInformation',
				// url: 'http://localhost:8002/getShipmentInformation',
				type: "get",
				data: {
					OwnerID: this.Udata.UID,
				},
				dateType: "json",
				crossDomain: true,
				success: function(data) {
					if (data.Code != 0) {
						self.warehouseDateJSON = data.data;
					} else {
						alert(data.data);
					}
				},

			});
		},
		//准备发货
		prepareShipment(DrugCode, DrugID) {
			this.prepareShipmentDrugCode = DrugCode;
			this.prepareShipmentDrugID = DrugID,
				this.isShowprepareShipment = true;
		},
		//关闭准备发货的界面
		closePrepareShipment() {
			this.prepareShipmentDrugCode = '';
			this.isShowprepareShipment = false;
			this.ReceiveID = 0;
		},
		//获取收件方信息
		getReceives() {
			let self = this;
			$.ajax({
				url: 'http://localhost:8002/getReceive',
				// url: 'http://localhost:8002/getReceive',
				type: "get",
				data: {
					UID: this.Udata.UID,
				},
				dateType: "json",
				crossDomain: true,
				success: function(data) {
					if (data.Code != 0) {
						self.Receives = data.data;
					} else {
						alert(data.data);
					}
				},

			});
		},
		//发货
		Shipment() {
			let self=this;
			if (this.ReceiveID == 0) {
				alert('请选择收获方')
			} else {
				$.ajax({
					url: 'http://localhost:8002/Shipment',
					// url: 'http://localhost:8002/Shipment',
					type: "post",
					data: {
						DrugCode: this.prepareShipmentDrugCode,
						DrugID: this.prepareShipmentDrugID,
						ReceiveID: this.ReceiveID,
					},
					dateType: "json",
					crossDomain: true,
					success: function(data) {
						alert(data.data);
						if (data.Code != 0) {
							self.closePrepareShipment();
							self.getShipmentDates();
						}

					},

				});
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

		//回到上一个界面
		goback() {
			window.history.back();
		},
		//上一页
		previousPage() {
			if (this.Page > 0) {
				this.Page--;
			}

		},
		//下一页
		nextPage() {
			if (this.Page < (this.warehouseDateJSON.length - 1)) {
				this.Page++;
			}

		},

	}
});
