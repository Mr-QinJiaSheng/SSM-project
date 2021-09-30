var navs = [{
	"title" : "后台首页",
	"icon" : "icon-computer",
	"href" : "page/main.html",
	"spread" : false //是否默认展开
}, {
    "title": "商品管理",
    "icon": "icon-text",
    "href": "goodsList.action",
    "spread": false
    
}, {
	"title" : "活动管理",
	"icon" : "icon-text",
	"href" : "",
	"spread" : false,
	"children" : [ {
		"title" : "设置活动",
		"icon" : "&#xe631;",
		"href" : "page/rebate.jsp",
		"spread" : false
	}, {
		"title" : "取消活动",
		"icon" : "&#xe631;",
		"href" : "page/cancle.jsp",
		"spread" : false
	}, {
		"title" : "今日活动",
		"icon" : "&#xe631;",
		"href" : "page/today.jsp",
		"spread" : false
	}]
}]