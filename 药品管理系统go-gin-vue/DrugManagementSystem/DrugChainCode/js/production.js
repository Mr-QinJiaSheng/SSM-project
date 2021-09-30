var app = new Vue({
	el: '#app',
	data: {
		title: "药品管理追踪溯源系统——药物生产",
		explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
		DrugID: 0,
		DrugType: "",
		Udata: '',
		ProductionDate: '',
	},
	created() {
		this.getUser();
		this.getDrugType();
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
		//获取药物类别信息
		getDrugType() {
			let self = this;
			$.ajax({
				url: 'http://localhost:8002/getDrugType',
				// url: 'http://localhost:8002/getDrugType',
				type: "get",
				data: {},
				dateType: "json",
				success: function(data) {
					if (data.Code != 0) {
						self.DrugType = data.data;
					} else {
						alert(data.data);
					}
				},

			});
		},
		productionDrug() {
			let UdataByte = JSON.stringify(this.Udata)
			if (this.DrugName == 0) {
				alert('请选择药物名称');
			} else if ($.trim(this.ProductionDate).length == 0) {
				alert('请输入生产日期');
			} else {
				$.ajax({
					url: 'http://localhost:8002/productionDrug',
					// url: 'http://localhost:8002/productionDrug',
					type: "post",
					data: {
						DrugID: this.DrugID,
						ProductionDate: this.ProductionDate,
						Udata: UdataByte,
					},
					dateType: "json",
					success: function(data) {
						alert(data.data);
						
					},

				});
			}

		},
		
		//回到上一个界面
		goback() {
			window.history.back();
		},

	}
});
