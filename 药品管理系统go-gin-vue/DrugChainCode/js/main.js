var app = new Vue({
	el: '#app',
	data: {
		title: "药品管理追踪溯源系统",
		divdata: "",
		Udata: "",
	},
	created() {
		this.getUser();
		// this.hideAll();
	},
	mounted() {
		this.displaySignOut();
	},
	computed: {

	},
	methods: {
		//获取用户信息
		getUser() {
			var data = JSON.parse(sessionStorage.getItem("data"));
			if (data != null) {
				this.Udata = data.data;
				this.getFunctionalModule(data.data.Power);
			}

		},
		//查询用户功能权限
		getFunctionalModule(power) {
			var self = this;
			$.ajax({
				// url: 'http://localhost:8002/getFunctionalModule',
				url: 'http://localhost:8002/getFunctionalModule',
				type: "get",
				data: {
					Power: power,
				},
				dateType: "json",
				success: function(data) {
					if (data.data == '网络异常，请重试') {
						alert(data.data);
					} else {
						self.divdata = data.data;
					}

				},

			});
		},
		// //隐藏所有弹窗
		// hideAll(){
		// 	$('#productionDialogBox').hide();
		// 	$('#RAndDBox').hide();
		// },
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
		//设置模块div的id
		getFunctionalModuleID(index) {
			return "FunctionalModule" + (index + 1);
		},
		//模块入口
		Entry(FunctionName) {
			sessionStorage.setItem("Udata", JSON.stringify(this.Udata));
			switch (FunctionName) {
				case 'Production':
					$(location).attr("href", "production.html");
					break;
				case 'R&D':
					$(location).attr("href", "R&D.html");
					break;
				case 'Warehouse':
					$(location).attr("href", "Warehouse.html");
					break;
				case 'Anti_counterfeiting':
					$(location).attr("href", "Anti_counterfeiting.html");
					break;
				case 'Trace':
					$(location).attr("href", "Trace.html");
					break;
				case 'Warehousing':
					$(location).attr("href", "Warehousing.html");
					break;
				case 'Shipment':
					$(location).attr("href", "Shipment.html");
					break;
				case 'Retail':
					$(location).attr("href", "Retail.html");
					break;


			}

		}
	}
});
