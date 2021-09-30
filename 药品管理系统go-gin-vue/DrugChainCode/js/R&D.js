var app = new Vue({
	el: '#app',
	data: {
		title: "药品管理追踪溯源系统——药物研发",
		explanation: '注：当药物生产后，每一件都会自动生成独一无二的身份码，用于防伪，溯源。且不需要手动入库，会自动加入库存中。',
		DrugName: '',
		DrugComposition: '',
		UsageMethod: '',
		MainFunction: '',
		Udata:'',
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
		goback() {
			window.history.back();
		},
		//新增药品种类
		addDrugType() {
			let self = this;
			if ($.trim(this.DrugName).length == 0) {
				alert("药物名称不能为空");
				$(DrugName).focus();
			} else if ($.trim(this.DrugComposition).length == 0) {
				alert("药物成分不能为空");
				$(DrugComposition).focus();
			} else if ($.trim(this.UsageMethod).length == 0) {
				alert("使用方法不能为空");
				$(UsageMethod).focus();
			} else if ($.trim(this.MainFunction).length == 0) {
				alert("主治功能不能为空");
				$(MainFunction).focus();
			} else $.ajax({
				url: 'http://localhost:8002/addDrugType',
				// url: 'http://localhost:8002/addDrugType',
				type: "post",
				data: {
					DrugName: this.DrugName,
					DrugComposition: this.DrugComposition,
					UsageMethod: this.UsageMethod,
					MainFunction: this.MainFunction,
				},
				dateType: "json",
				success: function(data) {
					if (data.Code == 0) {
						const reg = RegExp(/Error 1062/);
						if (data.data.match(reg)) {
							alert('该药品已存在');
						}
					} else {
						alert(data.data);
						self.DrugName = '';
						self.DrugComposition = '';
						self.UsageMethod = '';
						self.MainFunction = '';
					}

				},

			});
		},
	}
});

// http://localhost:8002/addDrugType
