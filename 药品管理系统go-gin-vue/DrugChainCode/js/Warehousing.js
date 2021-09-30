var app = new Vue({
	el: '#app',
	data: {
		title: "药品管理追踪溯源系统——收货",
		// explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
		Udata: '',
		warehouseDateJSON: '',
		Page: 0,
		
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
				this.getwarehousingDates();
			}

		},
		//获取可收货的数据
		getwarehousingDates() {
			let self = this;
			$.ajax({
				url: 'http://localhost:8002/getWarehousingInformation',
				// url: 'http://localhost:8002/getWarehousingInformation',
				type: "get",
				data: {
					ReceiveID: this.Udata.UID,
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
		//收货
		Warehousing(DrugCode) {
			let self=this;
			
				$.ajax({
					url: 'http://localhost:8002/Warehousing',
					// url: 'http://localhost:8002/Warehousing',
					type: "post",
					data: {
						DrugCode:DrugCode,
						Owner:this.Udata.CompanyName,
						OwnerID:this.Udata.UID,
					},
					dateType: "json",
					crossDomain: true,
					success: function(data) {
						alert(data.data);
						if (data.Code != 0) {
							self.getwarehousingDates();
						}

					},

				});
			
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
