var app = new Vue({
	el: '#app',
	data: {
		title: "药品管理系统",
		nowTime: "",
		UserLoginTitle: '用户登入',
		Uname: "",
		Upwd: "",
		ReUpwd: "",
	},
	mounted() {
		this.nowTimes();
	},
	created() {
		this.autoLogin();
	},
	methods: {
		timeFormate(timeStamp) {
			let year = new Date(timeStamp).getFullYear();
			let month = new Date(timeStamp).getMonth() + 1 < 10 ? "0" + (new Date(timeStamp).getMonth() +
				1) : new Date(timeStamp).getMonth() + 1;
			let date = new Date(timeStamp).getDate() < 10 ? "0" + new Date(timeStamp).getDate() : new Date(
				timeStamp).getDate();
			let hh = new Date(timeStamp).getHours() < 10 ? "0" + new Date(timeStamp).getHours() : new Date(
				timeStamp).getHours();
			let mm = new Date(timeStamp).getMinutes() < 10 ? "0" + new Date(timeStamp).getMinutes() :
				new Date(timeStamp).getMinutes();
			let ss = new Date(timeStamp).getSeconds() < 10 ? "0" + new Date(timeStamp).getSeconds() :
				new Date(timeStamp).getSeconds();
			this.nowTime = year + "-" + month + "-" + date + "  " + " " + hh + "时" + mm + '分' + ss + '秒';
		},
		nowTimes() {
			this.timeFormate(new Date());
			setInterval(this.nowTimes, 1000);
			this.clear()
		},
		clear() {
			clearInterval(this.nowTimes);
			this.nowTimes = null;
		},
		login() {
			if ($.trim(this.Uname).length == 0) {
				alert("用户名不能为空");
				$(Uname).focus();
			} else if ($.trim(this.Upwd).length == 0) {
				alert("密码不能为空");
				$(Upwd).focus();
			} else {
				$.ajax({
					// url: 'http://localhost:8002/Login',
					url: 'http://localhost:8002/Login',
					type: "post",
					data: {
						Uname: this.Uname,
						Upwd: this.Upwd,
					},
					dateType: "json",
					crossDomain: true,
					success: function(data) {
						if (data.Code == 0) {
							alert(data.data);
							$(Upwd).focus();
						} else {
							sessionStorage.setItem("data", JSON.stringify(data));
							$(location).attr("href", "main.html");
						}
					},

				});
			}

		},
		autoLogin() {
			let data = JSON.parse(sessionStorage.getItem("data"));
			if (data != null) {
				this.Uname = data.data.Uname;
				this.Upwd = data.data.Upwd;
			}
		}

	}
});
