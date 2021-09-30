var app = new Vue({
	el: '#app',
	data: {
		UserRegisterTitle: '注册',
		Uname: "",
		Upwd: "",
		ReUpwd: "",
		CompanyName: "",
		Director: "",
		Address: "",
		PhoneNUM: "",
		Power:1,
	},
	methods: {
		register() {
			if ($.trim(this.Uname).length == 0) {
				alert("用户名不能为空");
				$(Uname).focus();
			} else if ($.trim(this.Upwd).length == 0) {
				alert("密码不能为空");
				$(Upwd).focus();
			} else if ($.trim(this.ReUpwd).length == 0) {
				alert("确认密码不能为空");
				$(ReUpwd).focus();
			} else if ($.trim(this.ReUpwd) != $.trim(this.Upwd)) {
				alert("两次密码不一致");
				$(ReUpwd).focus();
			} else if ($.trim(this.CompanyName).length == 0) {
				alert("公司名称不能为空");
				$(CompanyName).focus();
			} else if ($.trim(this.Director).length == 0) {
				alert("负责人不能为空");
				$(Director).focus();
			} else if ($.trim(this.Address).length == 0) {
				alert("公司地址不能为空");
				$(Address).focus();
			} else if ($.trim(this.PhoneNUM).length == 0) {
				alert("公司联系方式不能为空");
				$(PhoneNUM).focus();
			} else if ($.trim(this.PhoneNUM).length != 11) {
				alert("联系方式填写有误");
				$(PhoneNUM).focus();
			} else{
				$.ajax({
					url: 'http://localhost:8002/Register',
					// url: 'http://localhost:8002/Register',
					type: "post",
					data: {
						Uname: this.Uname,
						Upwd: this.Upwd,
						CompanyName: this.CompanyName,
						Director: this.Director,
						Address: this.Address,
						PhoneNUM: this.PhoneNUM,
						Power: this.Power,
					},
					dateType: "json",
					crossDomain: true,
					success: function(data) {
						if (data.Code == 0) {
							alert(data.data);
							$(Uname).focus();
						} else {
							sessionStorage.setItem("data", JSON.stringify(data));
							alert("注册成功，点击确认跳转到登入界面");
							$(location).attr("href", "index.html");
						}
					},

				});
			}

		},
	}
});
