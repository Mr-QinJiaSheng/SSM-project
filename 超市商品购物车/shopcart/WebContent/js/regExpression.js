/**
 * 输入数字的验证
 */

function RegExpression(regExp,flag){
	var reg= "";
	if(flag == "0") {
		//只能为正整数匹配
		reg = /^[1-9]\d{0,6}$/;
	} else if(flag == "1") {
		//正数匹配，保留一位小数
		reg =/^([1-9]\d{0,6}\.\d{1})$|^(0\.\d{1})$/;
	}
	if(!reg.test(regExp)){
		//不符合
		return false ;
	} else {
		//符合
		return true;
	}
}