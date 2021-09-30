项目访问地址  http://localhost:8080/shopcart/page/login.jsp

商城购物车项目

店家   手机号 ：19892027565 密码：123456

卖家   手机号 ：12345678910 密码：123456

项目具体代码分类



项目所需要的jar包

# 数据库及表

```sql
Database - shop
```

### 购物车表

```sql
CREATE TABLE `cart` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '购物车id',
  `userid` INT(11) NOT NULL COMMENT '用户id',
  `goodsid` INT(11) NOT NULL COMMENT '商品id',
  `goodsname` VARCHAR(50) NOT NULL COMMENT '商品名称',
  `goodsprice` DOUBLE NOT NULL COMMENT '商品单价',
  `goodscount` INT(11) NOT NULL COMMENT '商品数量',
  PRIMARY KEY (`id`)
) ENGINE=INNODB DEFAULT CHARSET=utf8;

```

### 折扣表

```sql
CREATE TABLE `discount` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '打折编号',
  `moneycondition` DOUBLE DEFAULT NULL COMMENT '满多少',
  `moneyreturn` DOUBLE DEFAULT NULL COMMENT '减多少',
  `rate` DOUBLE DEFAULT NULL COMMENT '打折率',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;
```

### 商品表

```sql
CREATE TABLE `goods` (
  `id` INT(10) UNSIGNED NOT NULL AUTO_INCREMENT COMMENT '商品id',
  `goodsname` VARCHAR(50) NOT NULL COMMENT '商品名称',
  `price` DOUBLE NOT NULL COMMENT '商品价格',
  `number` INT(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;
```

### user表

```sql
CREATE TABLE `user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT COMMENT '用户id',
  `username` VARCHAR(50) NOT NULL COMMENT '用户姓名',
  `phone` VARCHAR(50) NOT NULL COMMENT '用户手机号',
  `password` VARCHAR(50) NOT NULL COMMENT '密码',
  `status` INT(11) NOT NULL COMMENT '1为用户；2为店主',
  PRIMARY KEY (`id`)
) ENGINE=INNODB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;
```

### 插入数据

```sql
INSERT  INTO `goods`(`id`,`goodsname`,`price`,`number`) VALUES (1,'雨伞',20,10),(2,'书包',50,10),(3,'鼠标',200,10),(4,'变形金刚',10,50),(5,'键盘',100,20),(6,'保温杯',100,30),(7,'洗发露',20,50),(8,'香皂',10,50),(9,'插座',60,10),(10,'电吹风',40,15),(11,'水杯',6,20),(12,'遥控汽车',60,20);

INSERT  INTO `user`(`id`,`username`,`phone`,`password`,`status`) VALUES (1,'买家','12345678910','123456',1),(2,'店主','19892027565','123456',2);
```



# 登录注册

#### Controller层

###### UserController.java

```java
package cn.qin.controller;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import cn.qin.pojo.User;
import cn.qin.service.UserService;

@Controller
public class UserController {
	@Autowired
	private UserService userService;
	//用户登录判断
	@RequestMapping("/UserLogin")
	public String UserLogin(Model model,HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		ModelAndView modelAndView=new ModelAndView();
		String phone = req.getParameter("phone");
		String password = req.getParameter("password");
		String status = req.getParameter("status");
		String url="";
		int status1 = Integer.parseInt(status);
		User user = new User();
		user.setPhone(phone);
		user.setPassword(password);
		user.setStatus(status1);
		int i=-1;
		//登录选择用户状态，进入商品展示界面
		if(status1==1){
			i = userService.findUser(user);
			if(i==1){
				url="redirect:showgoods.action";
				model.addAttribute("alert", "登录成功");
			}
			//登录失败
			if(i==2){
				model.addAttribute("alert", "登录失败");
				url="login";
			}
		}
		//店主登录，进入后台
		if(status1==2){
			i = userService.findUser(user);		
			if(i==1){
				String adminName =userService.findUsername(user).getUsername() ;
				req.getSession().setAttribute("adminName", adminName);
				url="index";
				model.addAttribute("alert", "登录成功");
			}
			//登录失败返回2
			if(i==2){
				model.addAttribute("alert", "登录失败");
				url="login";
			}
		}
		return url;
	}
	@RequestMapping("/insertuser")
	public String insertUser(Model model,HttpServletRequest req,HttpServletResponse rsp, String username, String password, String phone, int status) throws Exception{
		User user = new User();
		user.setUsername(username);
		user.setPassword(password);
		user.setPhone(phone);
		user.setStatus(status);
		userService.insertUser(user);
		model.addAttribute("alert", "注册成功");
		return "login";
	}
}
```

#### pojo类

###### User.java

```java
package cn.qin.pojo;

public class User {
	private int id;
	private String username;
	private String phone;
	private String password;
	private int  status;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getUsername() {
		return username;
	}
	public void setUsername(String username) {
		this.username = username;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public int getStatus() {
		return status;
	}
	public void setStatus(int status) {
		this.status = status;
	}
}
```

#### Service层

###### UserService.java

```java
package cn.qin.service;
import cn.qin.pojo.User;

public interface UserService {
	//根据status判断用户权限
	int findUser(User user);
	//根据user名查询
	User findUsername(User user);
	//注册添加user
	public void insertUser(User user);
}
```

实现类

###### UserServiceImpl.java

```java
package cn.qin.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import cn.qin.mapper.UserMapper;
import cn.qin.pojo.User;
import cn.qin.service.UserService;

public class UserServiceImpl implements UserService {
	//注入依赖
	@Autowired
	private UserMapper userMapper;
	@Override
	public int findUser(User user) {
		// TODO Auto-generated method stub
		int result=0;
		//判断手机号是否为空
			User user1 = userMapper.findUser(user);
			if(user1!=null){
				result=1;
			}else{
				result=2;
			}
		return result;
	}
        @Override
	public void insertUser(User user) {
		userMapper.insertUser(user);
	}
	@Override
	public User findUsername(User user) {
		// TODO Auto-generated method stub
		return userMapper.findUsername(user);
	}
}
```

#### Mapper层

###### UserMapper.java

```java
package cn.qin.mapper;

import cn.qin.pojo.User;

public interface UserMapper {
	User findUser(User user);
	User findUsername(User user);
   	 public void insertUser(User user);
}
```

###### UserMapper.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="cn.qin.mapper.UserMapper" >
<resultMap id="BaseResultMap" type="cn.qin.pojo.Goods" >
    <id column="id" property="id" jdbcType="INTEGER" />
    <result column="username" property="username" jdbcType="VARCHAR" />
    <result column="phone" property="phone" jdbcType="VARCHAR" />  
    <result column="password" property="password" jdbcType="VARCHAR" />   
    <result column="status" property="status" jdbcType="INTEGER" />    
   </resultMap>
<!-- 全部查询 -->
<select id="findAlluser" resultType="cn.qin.pojo.User">
	SELECT * FROM user
</select>
<!-- 向user表中插入数据-->
<insert id="insertUser" parameterType="cn.qin.pojo.User" >
	insert into user (username,password,status,phone) values ('${username}','${password}','${status}','${phone}')
</insert>
<!-- 全部查询 -->
<select id="findUser" parameterType="cn.qin.pojo.User" resultType="cn.qin.pojo.User">
	SELECT * FROM user where phone = '${phone}' and password='${password}' and status=${status}
</select>
<select id="findUsername" parameterType="cn.qin.pojo.User" resultType="cn.qin.pojo.User">
	SELECT * FROM user where phone = '${phone}' and password='${password}' and status=${status}
</select>
</mapper>
```

#### 登录界面

##### 代码展示

###### login.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
	String path=request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>用户登录</title>
</head>
<style>
	.header{
		position: absolute;
		width: 100%;
		height: 100px;
		background-color: #EBEBEB;
		padding-left: 510px;
		pading-top: 10px
	}
	.formdiv{
		position: absolute;
		width: 500px;
		height: 500px;
		background-color:#EBEBEB;
		top:118px;
		left: 400px;
	}
</style>
<body>
<!--对于输入手机号和密码的正则校验  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.js"></script>
<script type="text/javascript">
//手机号必须是1开头的11位数字
function checkPhone(){
    var  phone  = document.getElementById("phone").value;
    if(phone.length>0){
    	//符合当前时代的手机号
/*         	var reg= /^1[3|4|5|7|8][0-9]{9}$/; 
*/         var reg =/^1[0-9]{10}$/;
        var passSPan = document.getElementById("PhoneId");
        if(reg.test(phone)){
           //符合规则 
           passSPan.innerHTML="手机格式正确".fontcolor("green");
           return true;
        }else{
           //不符合规则
           passSPan.innerHTML="手机号格式不正确".fontcolor("red");
           return false;
       }
    }  
 }
//校验密码  必须是6位
function checkPass(){
    var  userPass  = document.getElementById("userPass").value;
    if(userPass.length>0){
       var reg = /^\w{6}$/;
        var passSPan = document.getElementById("passId");
        if(reg.test(userPass)){
           //符合规则 
           passSPan.innerHTML="密码格式正确".fontcolor("green");
           return true;
        }else{
           //不符合规则
           passSPan.innerHTML="密码必须是六位".fontcolor("red");
           return false;
       }
    }  
 }
//总体校验表单是否可以提交了 如果返回的true表单才可以提交。上面的表单项必须要每个都填写正确。

function checkForm(){
   var userPass = checkPass();
   var phone  = checkPhone();
   if(userPass&&phone){
      return true;
   }else{
       return false;
   }
}
</script> 
```

<div class="header">
<h2 style="color: black;font-size: 40px">登录界面</h2>
<div>
<div class="formdiv">
<form method="post" action="<%=request.getContextPath()%>/UserLogin.action" onsubmit="return checkForm()">
<table border="0" style="width: 500px;height: 300px">
	<tr align="center">
		<td>手机号：</td>
		<td><input type="text" name="phone" id="phone" onblur="checkPhone()"/><span id="PhoneId"></span></td>
	</tr>
	<tr align="center">
		<td>密码：</td>
		<td><input type="password" name="password" id="userPass" onblur="checkPass()"><span id="passId"></span></td>
	</tr>
	<tr align="center"	>
		<td>状态：</td>
		<td><input type="radio" name="status" value="1">用户<input type="radio" name="status" value="2">店家</td>
	</tr>
	<tr align="center">
		<td colspan="2"><input type="submit" value="登录">
           <a href="<%=path%>/page/register.jsp">点击注册</a>
		</td>
	</tr>
</table>
    <c:if test="${not empty alert}">
           <script type="text/javascript">
    	var loginError=""+'${alert}';
    	if(loginError!=""){
        alert(loginError);
        loginError="";
        }
</script>
         </c:if>
</form>
</div>
</body>
</html>

###### register.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%
	String path=request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>注册界面</title>
</head>
<body>
<!--对于输入手机号和密码的正则校验  -->
<script type="text/javascript" src="<%=request.getContextPath()%>/js/jquery-1.4.2.js"></script>
<script type="text/javascript">
//手机号必须是1开头的11位数字
function checkPhone(){
    var  phone  = document.getElementById("phone").value;
    if(phone.length>0){
    	//符合当前时代的手机号
/*         	var reg= /^1[3|4|5|7|8][0-9]{9}$/; 
*/         var reg =/^1[0-9]{10}$/;
        var passSPan = document.getElementById("PhoneId");
        if(reg.test(phone)){
           //符合规则 
           passSPan.innerHTML="手机格式正确".fontcolor("green");
           return true;
        }else{
           //不符合规则
           passSPan.innerHTML="手机号格式不正确".fontcolor("red");
           return false;
       }
    }  
 }
//校验密码  必须是6位
function checkPass(){
    var  userPass  = document.getElementById("userPass").value;
    if(userPass.length>0){
       var reg = /^\w{6}$/;
        var passSPan = document.getElementById("passId");
        if(reg.test(userPass)){
           //符合规则 
           passSPan.innerHTML="密码格式正确".fontcolor("green");
           return true;
        }else{
           //不符合规则
           passSPan.innerHTML="密码必须是六位".fontcolor("red");
           return false;
       }
    }  
 }
//总体校验表单是否可以提交了 如果返回的true表单才可以提交。上面的表单项必须要每个都填写正确。
function checkForm(){
   var userPass = checkPass();
   var phone  = checkPhone();
   if(userPass&&phone){
      return true;
   }else{
       return false;
   }
}
</script> 
<form action="<%=request.getContextPath()%>/insertuser.action" method="post" onsubmit="return checkForm()">
	注册用户名字：<input type="text" name="username" id="username"  /><br/>
	注册用户密码：<input type="password" name="password" id="userPass" onblur="checkPass()"><span id="passId"></span><br/>
	注册用户名字手机号：<input type="text" name="phone" id="phone" onblur="checkPhone()"/><span id="PhoneId"></span><br/>
	注册用户状态：<input type="text" name="status" id="status"><br/>
	<input type="submit" value="提交"/>
	<input type="reset" value="重置"/>
</form>
</body>
</html
```



项目分店家和用户两类人对该项目进行的操作

# 用户前台操作

http://localhost:8080/shopcart/showgoods.action?alert=%E7%99%BB%E5%BD%95%E6%88%90%E5%8A%9F

## 登录用户进入页面

#### Controller层

###### GoodsController.java

```java
package cn.qin.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import cn.qin.pojo.Goods;
import cn.qin.service.GoodsService;

@Controller
/*@RequestMapping("/Goods")
*/public class GoodsController {
	@Autowired
	private GoodsService goodsService;
	//前台商品展示刷新展示商品界面
	@RequestMapping("showgoods")
	public ModelAndView UserLogin(HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		ModelAndView modelAndView=new ModelAndView();
		/*增加参数i的原因
		 * 由于需要从别的controller转发到这个controller进行商品的刷新展示
		 * 但是有需要有提示语句，所有通过传过来的不同参数，在展示商品界面展示不同的提示语
		 * */
		String i = req.getParameter("i");
		if(i!=null&&i.length()>0){
			int r = Integer.parseInt(i);
			//从Cart/addgoods.action加入购物车中跳转过来
			if(r==1){
				modelAndView.addObject("alert", "请输入合理的数量");
			}
			if(r==2){
				modelAndView.addObject("alert", "请输入数量");
			}
			//从Cart/accountcash。action结算中跳转过来
			if(r==3){
				modelAndView.addObject("alert", "结算成功请继续购物");
			}
		}
		List<Goods> goodslist = goodsService.selectAllGoods();
		modelAndView.addObject("goodslist", goodslist);
		modelAndView.setViewName("showgoods");	
		return modelAndView;
	}
	/*从这里开始是后台商品管理的action*/	
	//后台管理中的添加商品
		@RequestMapping("/insert")
		public String insert(Goods record){
		goodsService.insertGoods(record);	
		return "redirect:goodsList.action";
		}
		//后台管理中的删除商品
		@RequestMapping("/delete")
		public ModelAndView delete(Integer[] id,HttpServletRequest req,HttpServletResponse res,RedirectAttributes attr){
			ModelAndView modelAndView=new ModelAndView();
			if(req.getParameter("id")!=null&&req.getParameter("id").length()>0){
			int gid=Integer.parseInt(req.getParameter("id"));
			if(gid>0){
			    goodsService.deleteById(id);
				attr.addFlashAttribute("alert", "删除成功");
				modelAndView=new ModelAndView("redirect:goodsList.action");		
			}else{
				 attr.addFlashAttribute("alert", "删除失败");
				 modelAndView=new ModelAndView("redirect:goodsList.action");
			}
			}else{
				 attr.addFlashAttribute("alert", "请选择要删除的商品");
				 modelAndView=new ModelAndView("redirect:goodsList.action");
			}
			return modelAndView;
		}
		//后台管理中的根据id查找商品
		@RequestMapping("/toupdate")
		public String toupdate(int id,Model model){
			Goods goods = goodsService.selectGoodsById(id);
			model.addAttribute("goods", goods);
			return "goods/updateGoods";
		}
		//后台管理中的修改商品
		@RequestMapping("/update")
		public String update(Goods record,Model model){
			goodsService.updateByid(record);
			Goods goods = goodsService.selectGoodsById(record.getId());
			model.addAttribute("goods", goods);
			return "redirect:goodsList.action";
		}
		//后台管理刷新展示商品
		@RequestMapping("/goodsList")
		public String goodsList(Model model) throws Exception{
			List<Goods> goodslist = goodsService.selectAllGoods();
			model.addAttribute("goodslist", goodslist);
			return "goods/goodsList";	
		}
		//后台管理根据名称模糊查询商品
		@RequestMapping("/selectName")
		public ModelAndView selectName(HttpServletRequest req,HttpServletResponse rsp)throws Exception{
			String goodsname = req.getParameter("goodsname");
			List<Goods> goodslist=goodsService.selectGoodByName(goodsname);
			ModelAndView modelAndView=new ModelAndView();
			modelAndView.addObject("goodslist",goodslist);
			modelAndView.setViewName("goods/goodsList");
			return modelAndView;
		}
}
```

#### pojo类

###### Goods.java

```java
package cn.qin.pojo;

public class Goods {
	private int id;
	private String goodsname;
	private double price;
	private int number;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGoodsname() {
		return goodsname;
	}
	public void setGoodsname(String goodsname) {
		this.goodsname = goodsname;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
}
```

#### Service层

###### GoodsService.java

```java
package cn.qin.service;

import java.util.List;
import cn.qin.pojo.Goods;

public interface GoodsService {
    //显示全部商品列表
	List<Goods>	selectAllGoods();
	//根据id查商品
	Goods selectGoodsById(int id);
	//根据名称模糊查询
	List<Goods> selectGoodByName(String goodsname);
	//添加商品
	public int insertGoods(Goods record);
	//根据id删除商品
	public int deleteById(Integer[] id);
	//修改商品属性
	 int updateByid(Goods record);
}

```

实现类

###### GoodsServiceImpl.java

```java
package cn.qin.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.qin.mapper.GoodsMapper;
import cn.qin.pojo.Goods;
import cn.qin.service.GoodsService;

public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsMapper goodsMapper;
	@Override
    //显示全部商品列表
	public List<Goods> selectAllGoods() {
		// TODO Auto-generated method stub
		return goodsMapper.selectAllGoods();
	}
	@Override
    //根据id查商品
	public Goods selectGoodsById(int id) {
		// TODO Auto-generated method stub
		return goodsMapper.selectGoodsById(id);
	}
	@Override
    //根据名称模糊查询
	public List<Goods> selectGoodByName(String goodsname) {
		// TODO Auto-generated method stub
		return goodsMapper.selectGoodByName(goodsname);
	}
	@Override
    //添加商品
	public int insertGoods(Goods record) {
		// TODO Auto-generated method stub
		return goodsMapper.insertGoods(record);
	}
	@Override
    //根据id删除商品
	public int deleteById(Integer[] id) {
		// TODO Auto-generated method stub
		return goodsMapper.deleteById(id);
	}
	@Override
    //修改商品属性
	public int updateByid(Goods record) {
		// TODO Auto-generated method stub
		return goodsMapper.updateByid(record);
	}
}
```

#### Mapper层

###### GoodsMapper.java

```java
package cn.qin.mapper;

import java.util.List;

import cn.qin.pojo.Goods;

public interface GoodsMapper {
	List<Goods>	selectAllGoods();
	Goods selectGoodsById(int id);
	//根据商品名称模糊查询
		List<Goods> selectGoodByName(String goodsname);
		//添加商品
		public int insertGoods(Goods record);
		//根据ID删除商品
		public int deleteById(Integer[] id);
		//修改商品属性
		 int updateByid(Goods record);
}

```

###### GoodsMapper.xml

```sql
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="cn.qin.mapper.GoodsMapper" >
<resultMap id="BaseResultMap" type="cn.qin.pojo.Goods" >
    <id column="id" property="id" jdbcType="INTEGER" />
    <result column="goodsname" property="goodsname" jdbcType="VARCHAR" />
    <result column="price" property="price" jdbcType="DOUBLE" />  
    <result column="number" property="number" jdbcType="INTEGER" />  
    
  </resultMap>
<select id="selectAllGoods" resultMap="BaseResultMap">
	select * from goods
</select>
<select id="selectGoodsById" parameterType="int" resultMap="BaseResultMap">
	select * from goods where id = #{id}
</select>
<select id="selectGoodByName" parameterType="String" resultMap="BaseResultMap">
	select * from goods where goodsname like '%${value}%'
</select>
<insert id="insertGoods" parameterType="cn.qin.pojo.Goods">
	insert into goods (goodsname,price,number)
		values (#{goodsname}, #{price}, #{number})
</insert>
<!-- <delete id="deleteById" parameterType="Integer[]">
	delete  from goods where id=${value}
</delete> -->
<update id="updateByid" parameterType="cn.qin.pojo.Goods">
	update goods 
	set goodsname = #{goodsname},price= #{price},number = #{number}
		   where id=#{id}
</update>
<sql id="delete_where">
		<foreach item="id" collection="array" open="id in ("
			separator="," close=")">
			${id}
		</foreach>
	</sql>
	<delete id="deleteById" parameterType="java.lang.Integer">
		delete from goods
		<where>
			<include refid="delete_where"></include>
		</where>
	</delete>
</mapper>
```

#### 页面详解(及具体实现代码段)

进入showgoods页面

```html
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商品展示界面</title>
</head>
<style>
	.header{
		position: absolute;
		width: 100%;
		height: 100px;
		background-color: #EBEBEB;
		padding-left: 510px;
		padding-top: 10px;
	}
	.formdiv{
		position: absolute;
		width: 1300px;
		height: 500px;
		background-color:#EBEBEB;
		top:120px;
		 left:30px; 
	}
	.buttom{
	position: absolute;
		width: 1300px;
		height: 20px;
		background-color:#EBEBEB;
		top:420px;
		left:30px; 
	}
</style>
<body> 
<div class="header">
<h1>商品清单</h1>
</div>
<div class="formdiv">
	<table width="50%" border="5" cellpadding="0" cellspacing="1"align="center">
      <tr>       
        <td width="100" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">商品名称</span></div></td>
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">单价</span></div></td>
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">数量</span></div></td>        
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">选择</span></div></td>   
     </tr>
      <c:if test="${not empty goodslist}">
	      <c:forEach items="${goodslist}" var="a">	
		      <form action="<%=request.getContextPath()%>/Cart/addgoods.action" method="post">      
			      <tr>
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodsname }</div></td>
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.price}</div></td>   
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">数量：<input type="text" name="num" value="1">	</div></td>             				              
			    	<input type="hidden" name="goodsId" value="${a.id}">             				              	        
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><input type="submit" value="加入购物车"></div></td>	             	
			      </tr>
		      </form> 	    
	  	 </c:forEach>
      </c:if>
       <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath() %>/Account/account.action" style="text-decoration: none;">我的购物车</a></div></td>
      </tr>
      <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath() %>/Account/cashier.action" style="text-decoration: none;">结算</a></div></td>
      </tr>
      <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><span><a href="${pageContext.request.contextPath}/page/login.jsp" style="text-decoration: none;"><i class="iconfont icon-loginout" ></i><cite>退出登录</cite></a></span></div></td>
      </tr>
       <c:if test="${empty goodslist}">
      <tr>
          <td height="20" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center">没有商品信息</div></td>
      </tr>
      </c:if>
    </table>
</div> 
 <c:if test="${not empty alert}">
    	<script type="text/javascript">
    	var loginError=""+'${alert}';
    	if(loginError!=""){
        alert(loginError);
        loginError="";
        }
		</script>
 </c:if>
</body>
</html>
```

用户操作根据用户想要商品数量和对商品加入购物车以及对商品的结算，最后退出登录 不是店家不能对商品进行添加

#### Controller层

###### CartController.java

```java
package cn.qin.controller;

import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import cn.qin.pojo.Cart;
import cn.qin.pojo.Goods;
import cn.qin.service.CartService;
import cn.qin.service.GoodsService;

@Controller
@RequestMapping("/Cart")
public class CartController {
	@Autowired
	private GoodsService goodsService;
	@Autowired
	private CartService cartService;
	//向购物车添加商品
	@RequestMapping("/addgoods")
	public String addgoods(Model model,HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		String goodsid = req.getParameter("goodsId");
		String num = req.getParameter("num");
		String url="";
		if(num!=null&&num.length()>0){
			int count = Integer.parseInt(num);
			int id = Integer.parseInt(goodsid);
			//如果购物车数量合理则加入购物车ﳵ
			if(count>0){
				cartService.insertGoods(id,count);
				url="redirect:/showgoods.action";
			}else{
			//如果数量不合理则返回购物页面，并带着一个参数i
			//为的是在购物界面根据不同问题显示不同的提示语句
				url = "redirect:/showgoods.action?i=1";
			}
		}else{
			//当购物车没有填写任何数据时，返回参数2
			url = "redirect:/showgoods.action?i=2";
		}
		return url;
	}
	//ͨ通过id删除购物车商品
	@RequestMapping("/deleteCart")
	public String deletecart(HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		String cartid = req.getParameter("id");
		int id = Integer.parseInt(cartid);
		int res = cartService.deleteCartById(id);
		String url = "";
		if(res>0){
			 url = "redirect:/Account/account.action";
		}
		return url;
	}
}
```

#### pojo类

###### Cart.java

```java
package cn.qin.pojo;

public class Cart {
	private int id;
	private int userid;//用户id
	private int goodsid;//商品id
	private String goodsname;
	private double goodsprice;
	private int goodscount;//
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getUserid() {
		return userid;
	}
	public void setUserid(int userid) {
		this.userid = userid;
	}
	public int getGoodsid() {
		return goodsid;
	}
	public void setGoodsid(int goodsid) {
		this.goodsid = goodsid;
	}
	public int getGoodscount() {
		return goodscount;
	}
	public void setGoodscount(int goodscount) {
		this.goodscount = goodscount;
	}
	public String getGoodsname() {
		return goodsname;
	}
	public void setGoodsname(String goodsname) {
		this.goodsname = goodsname;
	}
	public double getGoodsprice() {
		return goodsprice;
	}
	public void setGoodsprice(double goodsprice) {
		this.goodsprice = goodsprice;
	}
}
```

#### Service层

###### CartService.java

```java
package cn.qin.service;

public interface CartService {
	void insertGoods(int id,int num);
	int deleteAll();
	int deleteCartById(int id);
}

```

实现类

###### CartServiceImpl.java

```java
package cn.qin.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;
import cn.qin.mapper.CartMapper;
import cn.qin.mapper.GoodsMapper;
import cn.qin.pojo.Cart;
import cn.qin.pojo.Goods;
import cn.qin.service.CartService;

public  class CartServiceImpl implements CartService {
	
	@Autowired
	private CartMapper cartMapper;
	@Autowired
	private GoodsMapper goodsMapper;
	@Override
	public void insertGoods(int id,int num) {
		// TODO Auto-generated method stub
		Cart cart = cartMapper.selectGoodsById(id);
		if(cart!=null){
			int count = cart.getGoodscount();
			count  = count +num;
			Cart cart1 = new Cart();
			cart1.setId(cart.getId());
			cart1.setGoodscount(count);
			cartMapper.updatecount(cart1);
		}else{
			Goods goods = goodsMapper.selectGoodsById(id);
			Cart cart1 = new Cart();
			cart1.setUserid(1);
			cart1.setGoodscount(num);
			cart1.setGoodsid(id);
			cart1.setGoodsname(goods.getGoodsname());
			cart1.setGoodsprice(goods.getPrice());
			cartMapper.insertgoods(cart1);
		}
	}
	@Override
	public int deleteAll() {
		// TODO Auto-generated method stub
		return cartMapper.deleteAll();
	}
	@Override
	public int deleteCartById(int id) {
		// TODO Auto-generated method stub
		return cartMapper.deleteCartById(id);
	}
}
```

#### Mapper层

###### CartMapper.java

```java
package cn.qin.mapper;

import java.util.List;
import cn.qin.pojo.Cart;

public interface CartMapper {
	Cart selectGoodsById(int id);
	int updatecount(Cart cart);
	int insertgoods(Cart cart);
	List<Cart> selectcartByUserId(int userid);
	int deleteAll();
	int deleteCartById(int id);
}

```

###### CartMapper.xml

```sql
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="cn.qin.mapper.CartMapper" >
<resultMap id="BaseResultMap" type="cn.qin.pojo.Cart" >
    <id column="id" property="id" jdbcType="INTEGER" />
    <result column="goodsname" property="goodsname" jdbcType="VARCHAR" />
    <result column="price" property="price" jdbcType="DOUBLE" />  
  </resultMap>
<select id="selectGoodsById" parameterType="int" resultType="cn.qin.pojo.Cart">
select * from cart where goodsid=${value}
</select>
<update id="updatecount" parameterType="cn.qin.pojo.Cart">
update  cart set goodscount = ${goodscount} where id=${id}
</update>
<insert id="insertgoods" parameterType="cn.qin.pojo.Cart">
INSERT INTO cart (userid,goodsid,goodsname,goodsprice,goodscount) value(${userid},${goodsid},'${goodsname}',${goodsprice},${goodscount})
</insert>
<select id="selectcartByUserId" parameterType="int" resultMap="BaseResultMap">
select * from cart where userid=${value}
</select>
<delete id="deleteAll" >
	delete from cart
</delete>
<delete id="deleteCartById" parameterType="int">
delete from cart where id=${value}
</delete>
</mapper>
```

#### 用商品加入购物车后操作

代码展示

AccountController.java

```java
package cn.qin.controller;

import java.util.Iterator;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import cn.qin.pack.CashContext;
import cn.qin.pojo.Cart;
import cn.qin.pojo.Discount;
import cn.qin.service.AccountService;
import cn.qin.service.DiscountService;

@Controller
@RequestMapping("/Account")
public class AccountController {
	@Autowired
	private AccountService accountService;
	@Autowired
	private DiscountService discountService;
	//添加商品
	@RequestMapping("/account")
	public ModelAndView account(HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		List<Cart> listcart = accountService.findallcart();
		if(listcart==null){
			modelAndView.setViewName("account");
		}else{
			modelAndView.addObject("listcart", listcart);
			modelAndView.setViewName("account");
		}
		return modelAndView;
	}
	//点击结算跳转的controller
	@RequestMapping("/cashier")
	public ModelAndView cashier(HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		List<Cart> listcart = accountService.findallcart();
			Iterator<Cart> iterator = listcart.iterator();
			double totalprice = 0.0;
			double discountprice = 0.0;
			while(iterator.hasNext()){
				Cart next = iterator.next();
				int goodscount = next.getGoodscount();
				double price = next.getGoodsprice();
				totalprice =totalprice+ (double)goodscount *price;				
			}		
			modelAndView.addObject("totalprice", totalprice);			
			//查出现在的优惠
			Discount discount = discountService.selectDiscount();
			if(discount!=null){
				double moneycondition = discount.getMoneycondition();
				double moneyreturn = discount.getMoneyreturn();
				double rate = discount.getRate();
				//有折扣 没满减
				if(moneycondition==0.0&&moneyreturn==0.0){
					if(rate!=0.0){
						CashContext csuper = new CashContext(rate);
						double totalmoney = csuper.getResult(totalprice);
						modelAndView.addObject("rebate",rate);
						modelAndView.addObject("totalmoney", totalmoney);
					}
				}
				//有满减 没折扣
				if(rate==0.0){
					if(moneycondition!=0.0&&moneyreturn!=0.0){
						CashContext csuper = new CashContext(moneycondition,moneyreturn);
						double totalmoney = csuper.getResult(totalprice);
						modelAndView.addObject("man",moneycondition);
						modelAndView.addObject("jian",moneyreturn);
						modelAndView.addObject("totalmoney", totalmoney);
					}
				}
			}else{				
				//没有活动
					CashContext csuper = new CashContext();
					double totalmoney = csuper.getResult(totalprice);
					modelAndView.addObject("tell", "没有活动可以参与");
					modelAndView.addObject("totalmoney", totalmoney);
			}
			modelAndView.setViewName("cashier");	
			return modelAndView;
	}
}
```

AccountService.java

```java
package cn.qin.service;

import java.util.List;
import cn.qin.pojo.Cart;

public interface AccountService {
	List<Cart> findallcart();
}

```

AccountServiceImpl.java

```java
package cn.qin.serviceImpl;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import cn.qin.mapper.CartMapper;
import cn.qin.pojo.Cart;
import cn.qin.service.AccountService;

public class AccountServiceImpl implements AccountService {
	@Autowired
	private CartMapper cartMapper;
	@Override
	public List<Cart> findallcart() {
		// TODO Auto-generated method stub
		List<Cart> list = cartMapper.selectcartByUserId(1);
		return list;
	}
}
```



<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>我的购物车界面</title>
<style>
.formdiv{
		position: absolute;
		width: 500px;
		height: 500px;
		background-color:#EBEBEB;
		top:118px;
		left: 400px;
	}
</style>
</head>
<body> 
	<table width="50%" border="5" cellpadding="0" cellspacing="1" align="center">
	<tr align="center">  
	<td colspan="4" height="30px">
		<h1>我的购物车</h1>
	</td>
	</tr>
      <tr>       
        <td width="100" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">商品名称</span></div></td>
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">单价</span></div></td>
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">数量</span></div></td>   
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">总价</span></div></td>        
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">选择</span></div></td>           
     </tr>
      <c:if test="${not empty listcart}">
	      <c:forEach items="${listcart}" var="a">
	      <tr>
	        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodsname }</div></td>
	        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodsprice}</div></td>        
	        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodscount}</div></td>	       
	       	<td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodscount*a.goodsprice}</div></td>	       	       	      		     
	     	<td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath()%>/Cart/deleteCart.action?id=${a.id}">删除</a></div></td>	       	       	      		     	     
	      </tr>    
	  </c:forEach>
             <tr>
      <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath() %>/Account/cashier.action">结算</a></div></td>
  </tr>
   <tr>
      <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath() %>/showgoods.action">继续购物</a></div></td>
  </tr>
   </c:if>
   <c:if test="${empty listcart}">
  <tr>
      <td height="20" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center">您还没有购买任何商品，请前去<a href="<%=request.getContextPath() %>/showgoods.action">购物</a></div></td>
  </tr>
  </c:if>
</table>


 <div class="buttom" align="center">
<span><a href="${pageContext.request.contextPath}/page/login.jsp" style="text-decoration: none;"><i class="iconfont icon-loginout" ></i><cite>退出登录</cite></a></span>
</div>
</body>
</html>

###### （查询数据）

 传递数据页面得到数据并列表出来

     <c:if test="${not empty listcart}">
    	      <c:forEach items="${listcart}" var="a">
     <tr>
    	        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodsname }</div></td>
    	        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodsprice}</div></td>        
    	        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodscount}</div></td>	       
    	       	<td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodscount*a.goodsprice}</div></td>	       	       	      		     
    	     	<td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath()%>/Cart/deleteCart.action?id=${a.id}">删除</a></div></td>	       	       	      		     	     
    	      </tr>    
    	  </c:forEach>


###### （删除数据）

用户能对加入购物车的商品进行删除

```
//ͨ通过id删除购物车商品
	@RequestMapping("/deleteCart")
	public String deletecart(HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		String cartid = req.getParameter("id");
		int id = Integer.parseInt(cartid);
		int res = cartService.deleteCartById(id);
		String url = "";
		if(res>0){
			 url = "redirect:/Account/account.action";
		}
		return url
	}
```

如果用户没有添加商品至于购物车或者购物车内商品删除

进行判断

```jsp
 <c:if test="${empty listcart}">
      <tr>
          <td height="20" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center">您还没有购买任何商品，请前去<a href="<%=request.getContextPath() %>/showgoods.action">购物</a></div></td>
      </tr>
      </c:if>
```

点击购物返回商品列表进行购物

#### 结算

##### 用户加入购物车后进行（店家还没有推出活动时）

结算页面cashier.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>cashier</title>
<!-- 结算界面 -->
</head>
<style>
	.header{
		position: absolute;
		width: 100%;
		height: 100px;
		background-color:  #EBEBEB ;
		padding-left: 510px;
		padding-top: 10px
	}
	.formdiv{
		position: absolute;
		width: 500px;
		height: 500px;
		background-color:#EBEBEB;
		top:118px;
		left: 400px;
	}
	.buttom{
	position: absolute;
		width: 500px;
		height: 20px;
		background-color:#EBEBEB;
		top:450px;
		left:400px; 
	}
</style>
<body>
```

<div class="header">
<h2 style="font-size: 40px">商品结算</h2>
</div>
<div class="formdiv">
<form action="<%=request.getContextPath()%>/Cash/lastcash.action" method="post">
<table border="1" cellspacing="1" style="width: 500px;height: 300px">
<tr align="center">
<td colspan="3">商场收银</td>
</tr>
<tr align="center">
	<td>总价</td>
	<td>${totalprice }</td>
</tr>
<tr align="center">
	<td colspan="2">
		<c:if test="${man!=null&&jian!=null&&rebate==null}">
			您好，现在有满${man }减${jian }的活动！
		</c:if>	
		<c:if test="${rebate!=null&&man==null&& jian==null}">
			您好，现在有${rebate}折的折扣活动！
		</c:if>	
		<c:if test="${tell!=null}">
			${tell }
		</c:if>	
	</td>
</tr>

```jsp
<tr align="center">
	<td>折扣价</td>
	<td>${totalmoney }</td>
</tr>

<!-- <tr align="center">
	<td colspan="3" >

	</td>

</tr> -->
<tr align="center">
	<td colspan="3" >
	<a href="<%=request.getContextPath() %>/Cash/accountcash.action" style="text-decoration: none;">结算</a>
	</td>
</tr>
<tr align="center">
	<td>
	<a href="<%=request.getContextPath() %>/showgoods.action" style="text-decoration: none;">继续购物</a>
	</td>
	<td>
	<a href="<%=request.getContextPath() %>/Account/account.action" style="text-decoration: none;">返回购物车</a>
	</td>
</tr>
</table>
</form>
<c:if test="${totalprice==0.0}">
 <tr>
        <td height="20" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center">您还没有购买任何商品，请前去<a href="<%=request.getContextPath() %>/showgoods.action">购物</a></div></td>
      </tr>

</c:if>
 <c:if test="${not empty alert}">
    	<script type="text/javascript">
    	var loginError=""+'${alert}';
    	if(loginError!=""){
        alert(loginError);
        loginError="";
        }
		</script>
 </c:if>
 </div>
 <div class="buttom">
<span><a href="${pageContext.request.contextPath}/page/login.jsp" style="text-decoration: none;"><i class="iconfont icon-loginout" ></i><cite>退出登录</cite></a></span>
</div>

</body>
</html>
```

点击结算 注意！i=3

结算后可继续购物

返回商品列表页面

结束！

##### 用户在活动购物时

用户操作结束退出登录返回登录界面



# 店家后台操作

## 登录

运用layui后台管理模板

main.html

```html
<!DOCTYPE html>
<html>
<head>
	<meta charset="utf-8">
	<title>首页--layui后台管理模板</title>
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="apple-mobile-web-app-status-bar-style" content="black">
	<meta name="apple-mobile-web-app-capable" content="yes">
	<meta name="format-detection" content="telephone=no">
	<link rel="stylesheet" href="../layui/css/layui.css" media="all" />
	<link rel="stylesheet" href="../css/font_eolqem241z66flxr.css" media="all" />
	<link rel="stylesheet" href="../css/main.css" media="all" />
</head>
<script type="text/javascript">
    var t = null;
    t = setTimeout(time,1000);//开始执行
    function time(){
        clearTimeout(t);//清除定时器
        var dt = new Date();
        var y=dt.getYear()+1900;
        var mm=dt.getMonth()+1;
        var d=dt.getDate();
        var weekday=["星期日","星期一","星期二","星期三","星期四","星期五","星期六"];
        var day=dt.getDay();
        var h=dt.getHours();
        var m=dt.getMinutes();
        var s=dt.getSeconds();
        if(h<10){h="0"+h;}
        if(m<10){m="0"+m;}
        if(s<10){s="0"+s;}
        document.getElementById("nowTime").innerHTML =  "上午好！ 欢迎使用网站后台管理系统。当前时间为："+y+"年"+mm+"月"+d+"日"+weekday[day]+""+h+":"+m+":"+s+"";
        t = setTimeout(time,1000); //设定定时器，循环执行
    }
</script>
<body class="childrenBody">

    <blockquote class="layui-elem-quote">
        <div id="nowTime"></div>
    </blockquote>

	<script type="text/javascript" src="../layui/layui.js"></script>
</body>
</html>
```

首页index.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>商城后台管理系统</title>
<meta name="renderer" content="webkit">
<meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
<meta http-equiv="Access-Control-Allow-Origin" content="*">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<meta name="apple-mobile-web-app-status-bar-style" content="black">
<meta name="apple-mobile-web-app-capable" content="yes">
<meta name="format-detection" content="telephone=no">
<link rel="icon" href="favicon.ico">
<link rel="stylesheet" href="${pageContext.request.contextPath}/layui/css/layui.css" media="all" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/font_eolqem241z66flxr.css" media="all" />
<link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css" media="all" />
</head>
<body class="main_body">
	<div class="layui-layout layui-layout-admin">
		<!-- 顶部 -->
		<div class="layui-header header">
			<div class="layui-main">
				<a href="#" class="logo">商城后台管理系统</a>
			    <!-- 顶部右侧菜单 -->
			    <ul class="layui-nav top_menu">
					<li class="layui-nav-item" pc>
						<a href="javascript:;">
							<cite><%=request.getSession().getAttribute("adminName") %></cite>
						</a>
						<dl class="layui-nav-child">
							<dd><a href="${pageContext.request.contextPath}/page/login.jsp"><i class="iconfont icon-loginout"></i><cite>退出</cite></a></dd>
						</dl>
					</li>
				</ul>
			</div>
		</div>
		<!-- 左侧导航 -->
		<div class="layui-side layui-bg-black">
			<div class="user-photo">				
				<p>你好！<span class="userName"><%=request.getSession().getAttribute("adminName") %></span>, 欢迎登录</p>
			</div>
			<div class="navBar layui-side-scroll"></div>
		</div>
		<!-- 右侧内容 -->
		<div class="layui-body layui-form">
			<div class="layui-tab marg0" lay-filter="bodyTab">
				<ul class="layui-tab-title top_tab">
					<li class="layui-this" lay-id=""><i class="iconfont icon-computer"></i> <cite>后台首页</cite></li>
				</ul>
				<div class="layui-tab-content clildFrame">
					<div class="layui-tab-item layui-show">
						<iframe src="${pageContext.request.contextPath}/page/main.html"></iframe>
					</div>
				</div>
			</div>
		</div>
		<!-- 底部 -->
		<div class="layui-footer footer">
			<p>商品管理</p>
		</div>
	</div>
	<!-- 移动导航-->
	<div class="site-tree-mobile layui-hide"><i class="layui-icon">&#xe602;</i></div>
	<div class="site-mobile-shade"></div>
	<script type="text/javascript" src="${pageContext.request.contextPath}/layui/layui.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/nav.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/leftNav.js"></script>
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/index.js"></script>
</body>
</html>
```

浏览器元素审查

店家进入商品管理

商品展示列表页面

goodsList.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    <%
	String path=request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>
<script type="text/javascript">
function selectAll(field){
	//根据checkbox框的名称，查询得到所有的checkbox对象
	var idCheckboxs = document.getElementsByName("id");
	for(var i=0; i<idCheckboxs.length; i++){
		//判断顶上那个checkbox框的选中状态
		if(field.checked){
			idCheckboxs[i].checked = true;
		}else{
			idCheckboxs[i].checked = false;
		}
	}
}
function del(){
	//判断有哪些checkbox框被选中了
	var idCheckboxs = document.getElementsByName("id");
	var flag = confirm("确定要删除吗？");
	  if (flag==true){  
        var url = "<%=request.getContextPath()%>/delete.action";
      	var checkedIds = [];    	
      	for(var i=0; i<idCheckboxs.length; i++){
      		if(idCheckboxs[i].checked){
      			checkedIds[checkedIds.length] = idCheckboxs[i].value;
      		}
      	}
      	for(var i=0; i<checkedIds.length; i++){
      		if(i == 0){
      			url = url + "?id="+checkedIds[i];
      		}else{
      			url = url + "&id="+checkedIds[i];
      		}
      	}
      	window.location = url;
	  }else{  
          return false;  
      }  
  }  
</script>
<body>
<table width="600" border="1" style="margin: 0 auto;margin-top:25px;" id="showTable">
<tr>
	<td colspan="3" width="600"><input type="checkbox" name="checkbox" onclick="selectAll(this)" />全选/全不选</td>
	<td colspan="3" width="600" align="right" ><a href="<%=path%>/page/goods/insertGoods.jsp">添加</a></td>
</tr>
<tr>
	<form action="<%=request.getContextPath() %>/selectName.action" method="post">
	<td colspan="6" width="600" align="center">
	分类模糊查询：<input type="text" id="title" name="goodsname">
			<input type="submit" value="查询">				
	</td>
	</form>
</tr>
<tr>
	<td colspan="6" width="600" align="center">商品目录</td>
</tr>
<tr>
<td colspan="6" style="text-align: left;">
</tr>
		<tr style="background:#666">
				<td>选择框</td>
			    <td>商品编号</td>
				<td>商品名称</td>
				<td>商品价格</td>
				<td>商品数量</td>
				<td>操作</td>
			</tr>
	<c:forEach var="Goods" items="${requestScope.get('goodslist')}">
			<tr style="background:#CCC">
				<td width="100"><div align="left"><input type="checkbox" name="id" class="checkb" value="${Goods.id}"/></div></td>
				<td width="100">${Goods.id}</td>
				<td width="100">${Goods.goodsname}</td>
				<td width="100">${Goods.price}</td>
				<td width="100">${Goods.number}</td>
				<td width="100"><a href="<%=request.getContextPath()%>/toupdate.action?id=${Goods.id}">修改</a></td>			
		</tr>
	</c:forEach>
<tr>
<td align="center" colspan="6">
<div>

<input type="button" value="删除" onclick="del()">
<input type="button" name="Submit" onclick="javascript:history.back(-1);" value="返回"/>
</div>
</td>
</tr>
	</table>
 <c:if test="${not empty alert}">
    	<script type="text/javascript">
    	var loginError=""+'${alert}';
    	if(loginError!=""){
        alert(loginError);
        loginError="";
        }
		</script>
  </c:if>
</body>
</html>
```

## 具体实现代码展示

##### Controller层

###### GoodsController.java

```java
package cn.qin.controller;

import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;
import cn.qin.pojo.Goods;
import cn.qin.service.GoodsService;

@Controller
/*@RequestMapping("/Goods")
*/public class GoodsController {
	@Autowired
	private GoodsService goodsService;
	/*从这里开始是后台商品管理的action*/	
	//后台管理中的添加商品
		@RequestMapping("/insert")
		public String insert(Goods record){
		goodsService.insertGoods(record);	
		return "redirect:goodsList.action";
		}
		//后台管理中的删除商品
		@RequestMapping("/delete")
		public ModelAndView delete(Integer[] id,HttpServletRequest req,HttpServletResponse res,RedirectAttributes attr){
			ModelAndView modelAndView=new ModelAndView();
			if(req.getParameter("id")!=null&&req.getParameter("id").length()>0){
			int gid=Integer.parseInt(req.getParameter("id"));
			if(gid>0){
			    goodsService.deleteById(id);
				attr.addFlashAttribute("alert", "删除成功");
				modelAndView=new ModelAndView("redirect:goodsList.action");		
			}else{
				 attr.addFlashAttribute("alert", "删除失败");
				 modelAndView=new ModelAndView("redirect:goodsList.action");
			}
			}else{
				 attr.addFlashAttribute("alert", "请选择要删除的商品");
				 modelAndView=new ModelAndView("redirect:goodsList.action");
			}
			return modelAndView;
		}
		//后台管理中的根据id查找商品
		@RequestMapping("/toupdate")
		public String toupdate(int id,Model model){
			Goods goods = goodsService.selectGoodsById(id);
			model.addAttribute("goods", goods);
			return "goods/updateGoods";
		}
		//后台管理中的修改商品
		@RequestMapping("/update")
		public String update(Goods record,Model model){
			goodsService.updateByid(record);
			Goods goods = goodsService.selectGoodsById(record.getId());
			model.addAttribute("goods", goods);
			return "redirect:goodsList.action";
		}
		//后台管理刷新展示商品
		@RequestMapping("/goodsList")
		public String goodsList(Model model) throws Exception{
			List<Goods> goodslist = goodsService.selectAllGoods();
			model.addAttribute("goodslist", goodslist);
			return "goods/goodsList";	
		}
		//后台管理根据名称模糊查询商品
		@RequestMapping("/selectName")
		public ModelAndView selectName(HttpServletRequest req,HttpServletResponse rsp)throws Exception{
			String goodsname = req.getParameter("goodsname");
			List<Goods> goodslist=goodsService.selectGoodByName(goodsname);
			ModelAndView modelAndView=new ModelAndView();
			modelAndView.addObject("goodslist",goodslist);
			modelAndView.setViewName("goods/goodsList");
			return modelAndView;
		}
}
```

##### pojo类

###### Goods.java

```java
package cn.qin.pojo;
public class Goods {
	private int id;
	private String goodsname;
	private double price;
	private int number;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getGoodsname() {
		return goodsname;
	}
	public void setGoodsname(String goodsname) {
		this.goodsname = goodsname;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public int getNumber() {
		return number;
	}
	public void setNumber(int number) {
		this.number = number;
	}
}
```

##### Service层

###### GoodsService.java

```java
package cn.qin.service;

import java.util.List;
import cn.qin.pojo.Goods;

public interface GoodsService {
    //显示全部商品列表
	List<Goods>	selectAllGoods();
	//根据id查商品
	Goods selectGoodsById(int id);
	//根据名称模糊查询
	List<Goods> selectGoodByName(String goodsname);
	//添加商品
	public int insertGoods(Goods record);
	//根据id删除商品
	public int deleteById(Integer[] id);
	//修改商品属性
	 int updateByid(Goods record);
}

```

##### 实现类

###### GoodsServiceImpl.java

```java
package cn.qin.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.qin.mapper.GoodsMapper;
import cn.qin.pojo.Goods;
import cn.qin.service.GoodsService;

public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsMapper goodsMapper;
	@Override
    //显示全部商品列表
	public List<Goods> selectAllGoods() {
		// TODO Auto-generated method stub
		return goodsMapper.selectAllGoods();
	}
	@Override
    //根据id查商品
	public Goods selectGoodsById(int id) {
		// TODO Auto-generated method stub
		return goodsMapper.selectGoodsById(id);
	}
	@Override
    //根据名称模糊查询
	public List<Goods> selectGoodByName(String goodsname) {
		// TODO Auto-generated method stub
		return goodsMapper.selectGoodByName(goodsname);
	}
	@Override
    //添加商品
	public int insertGoods(Goods record) {
		// TODO Auto-generated method stub
		return goodsMapper.insertGoods(record);
	}
	@Override
    //根据id删除商品
	public int deleteById(Integer[] id) {
		// TODO Auto-generated method stub
		return goodsMapper.deleteById(id);
	}
	@Override
    //修改商品属性
	public int updateByid(Goods record) {
		// TODO Auto-generated method stub
		return goodsMapper.updateByid(record);
	}
}
```

##### Mapper层

###### GoodsMapper.java

```java
package cn.qin.mapper;

import java.util.List;

import cn.qin.pojo.Goods;

public interface GoodsMapper {
	List<Goods>	selectAllGoods();
	Goods selectGoodsById(int id);
	//根据商品名称模糊查询
		List<Goods> selectGoodByName(String goodsname);
		//添加商品
		public int insertGoods(Goods record);
		//根据ID删除商品
		public int deleteById(Integer[] id);
		//修改商品属性
		 int updateByid(Goods record);
}

```

###### GoodsMapper.xml

```sql
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="cn.qin.mapper.GoodsMapper" >
<resultMap id="BaseResultMap" type="cn.qin.pojo.Goods" >
    <id column="id" property="id" jdbcType="INTEGER" />
    <result column="goodsname" property="goodsname" jdbcType="VARCHAR" />
    <result column="price" property="price" jdbcType="DOUBLE" />  
    <result column="number" property="number" jdbcType="INTEGER" />  
    
  </resultMap>
<select id="selectAllGoods" resultMap="BaseResultMap">
	select * from goods
</select>
<select id="selectGoodsById" parameterType="int" resultMap="BaseResultMap">
	select * from goods where id = #{id}
</select>
<select id="selectGoodByName" parameterType="String" resultMap="BaseResultMap">
	select * from goods where goodsname like '%${value}%'
</select>
<insert id="insertGoods" parameterType="cn.qin.pojo.Goods">
	insert into goods (goodsname,price,number)
		values (#{goodsname}, #{price}, #{number})
</insert>
<!-- <delete id="deleteById" parameterType="Integer[]">
	delete  from goods where id=${value}
</delete> -->
<update id="updateByid" parameterType="cn.qin.pojo.Goods">
	update goods 
	set goodsname = #{goodsname},price= #{price},number = #{number}
		   where id=#{id}
</update>
<sql id="delete_where">
		<foreach item="id" collection="array" open="id in ("
			separator="," close=")">
			${id}
		</foreach>
	</sql>
	<delete id="deleteById" parameterType="java.lang.Integer">
		delete from goods
		<where>
			<include refid="delete_where"></include>
		</where>
	</delete>
</mapper>
```



店家对商品进行curd 操作

## 添加商品

#### insertGoods.jsp

```jsp
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
</head>

<body>
<form action="<%=request.getContextPath()%>/insert.action" method="post" >
<table border="1" width="600px" style="margin: 0 auto;margin-top:25px;" id="table1">
<tr>
<td align="center" colspan="2">商品添加</td>
</tr>
<tr style="background:#CCC">
<td align="right" width="250px;">商品名称：</td>
<td><input type="text" name="goodsname"  value="${goods.goodsname}" id="goodsname">*<span id="nameSpan"></span></td>
</tr>
<tr style="background:#CCC">
<td align="right">商品价格：</td>
<td><input type="text" name="price" value="${goods.price}" >*</td>
</tr>
<tr style="background:#CCC">
<td align="right">商品数量：</td>
<td><input type="text" name="number" id="number" value="${goods.number}">*<span id="numSpan"></span></td>
</tr>
<tr>   
 <td align="center"  colspan="2"><input type="submit" value="添加">&nbsp;&nbsp;

<input type="button" name="Submit" onclick="javascript:history.back(-1);" value="返回"/>
 </td>   
</tr>
</table>
 </form>
 <c:if test="empty alert">
 	<c:out value="${alert}"></c:out>
 </c:if>
</body>
</html>
```



# 折扣

#### DiscountController.java

```java
package cn.qin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import cn.qin.pack.CashContext;
import cn.qin.service.DiscountService;

@Controller
@RequestMapping("/Discount")
public class DiscountController {
	@Autowired
	private DiscountService discountService;
	//在后台活动设置界面增加满减活动跳转的controller
	@RequestMapping("/fullreduction")
	public ModelAndView cash(HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		String man = req.getParameter("man");
		String jian  = req.getParameter("jian");
		if(man!=null&&jian!=null&&man.length()>0&&jian.length()>0){
			double man1 = Double.parseDouble(man);
			double jian1 = Double.parseDouble(jian);
			if(man1>jian1){
				discountService.deleteAll();
				int i = discountService.insertCashReturn(man1, jian1);
				if(i>0){
					modelAndView.addObject("alert", "添加成功");
					modelAndView.setViewName("rebate");
					String zhekou = "满" + man1 + "减" + jian1;
					req.getSession().setAttribute("zhekou",zhekou);
				}else{
					modelAndView.addObject("alert", "添加失败");
					modelAndView.setViewName("rebate");
				}
			}else{
				modelAndView.addObject("alert", "您输入的格式不正确");
				modelAndView.setViewName("rebate");
			}
			}	
		return modelAndView;
	}
	//在后台活动设置界面增加打折活动跳转到controller
	@RequestMapping("/rebate")
	public ModelAndView rebate(HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		String rebate = req.getParameter("rebate");
		if(rebate!=null&&rebate.length()>0){
			double rate = Double.parseDouble(rebate);			
				discountService.deleteAll();
				int i = discountService.insertCashRebate(rate);
				if(i>0){
					modelAndView.addObject("alert", "添加成功！");
					modelAndView.setViewName("rebate");
					String zhekou = rate + "折";
					req.getSession().setAttribute("zhekou",zhekou);
				}else{
					modelAndView.addObject("alert", "添加失败！");
					modelAndView.setViewName("rebate");
				}
			}else{
				modelAndView.addObject("alert", "请输入折扣！");
				modelAndView.setViewName("rebate");
			}	
		return modelAndView;
	}
	//在后台取消活动后跳转的controller
		@RequestMapping("/cancle")
		public ModelAndView cancle(HttpServletRequest request){
			ModelAndView modelAndView = new ModelAndView();

			int result = discountService.deleteAll();
			if(result > 0){
				//取消成功
				request.getSession().removeAttribute("zhekou");
				modelAndView.addObject("cancle", "取消活动成功");
				modelAndView.setViewName("cancle");
			}else{
				//取消失败
				modelAndView.addObject("cancle", "取消活动失败");
				modelAndView.setViewName("cancle");
			}
			return modelAndView;
		}
}
```

#### DiscountMapper.java

```java
package cn.qin.mapper;

import java.util.HashMap;

import cn.qin.pojo.Discount;

public interface DiscountMapper {
	int insertCashReturn(HashMap<String,Object> map);
	int insertCashRebate(double rate);
	int deleteAll();
	Discount selectDiscount();
}

```

#### DiscountMapper.xml

```xml
<?xml version="1.0" encoding="UTF-8" ?>
<!DOCTYPE mapper PUBLIC "-//mybatis.org//DTD Mapper 3.0//EN" "http://mybatis.org/dtd/mybatis-3-mapper.dtd" >
<mapper namespace="cn.qin.mapper.DiscountMapper" >
<resultMap id="BaseResultMap" type="cn.qin.pojo.Discount" >
    <id column="id" property="id" jdbcType="INTEGER" />
    <result column="moneycondition" property="moneycondition" jdbcType="DOUBLE" />
    <result column="moneyreturn" property="moneyreturn" jdbcType="DOUBLE" />  
      <result column="rate" property="rate" jdbcType="DOUBLE" />  
  </resultMap>
<!-- 向discount表中插入数据-->
<insert id="insertCashReturn" parameterType="Map" >
	insert into discount (moneycondition,moneyreturn) value (${moneyCondition},${moneyReturn})
</insert>
<insert id="insertCashRebate" parameterType="double">
	insert into discount (rate) value (${value})
</insert>
<delete id="deleteAll">
	delete from discount
</delete>
<select id="selectDiscount" resultMap="BaseResultMap">
	select * from discount
</select>
</mapper>
```

#### Discount.java

```
package cn.qin.pojo;

public class Discount {
	private int id;
	private double moneycondition;
	private double moneyreturn;
	private double rate;
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public double getMoneycondition() {
		return moneycondition;
	}
	public void setMoneycondition(double moneycondition) {
		this.moneycondition = moneycondition;
	}
	
	public double getMoneyreturn() {
		return moneyreturn;
	}
	public void setMoneyreturn(double moneyreturn) {
		this.moneyreturn = moneyreturn;
	}
	public double getRate() {
		return rate;
	}
	public void setRate(double rate) {
		this.rate = rate;
	}
}
```

#### DiscountService.java

```java
package cn.qin.service;

import java.util.Map;

import cn.qin.pojo.Discount;

public interface DiscountService {
	int insertCashReturn(double moneyCondition,double moneyRebate);
	int insertCashRebate(double rate);
	int deleteAll();
	Discount selectDiscount();
}

```

#### DiscountServiceImpl.java

```
package cn.qin.serviceImpl;

import java.util.HashMap;

import org.springframework.beans.factory.annotation.Autowired;

import cn.qin.mapper.DiscountMapper;
import cn.qin.pojo.Discount;
import cn.qin.service.DiscountService;

public class DiscountServiceImpl implements DiscountService {
	@Autowired
	private DiscountMapper discountMapper;
	@Override
	public int insertCashRebate(double rate) {
		// TODO Auto-generated method stub
		return discountMapper.insertCashRebate(rate);
	}
	@Override
	public int insertCashReturn(double moneyCondition, double moneyReturn) {
		// TODO Auto-generated method stub
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("moneyCondition",moneyCondition);
		map.put("moneyReturn", moneyReturn);
		return discountMapper.insertCashReturn(map);
	}
	@Override
	public int deleteAll() {
		// TODO Auto-generated method stub
		return discountMapper.deleteAll();
	}
	@Override
	public Discount selectDiscount() {
		// TODO Auto-generated method stub
		return discountMapper.selectDiscount();
	}
}

```

![image-20210616195831880](C:\Users\asus\AppData\Roaming\Typora\typora-user-images\image-20210616195831880.png)

![image-20210616195842600](C:\Users\asus\AppData\Roaming\Typora\typora-user-images\image-20210616195842600.png)

![image-20210616195851139](C:\Users\asus\AppData\Roaming\Typora\typora-user-images\image-20210616195851139.png)

![image-20210616210048244](C:\Users\asus\AppData\Roaming\Typora\typora-user-images\image-20210616210048244.png)

![image-20210616210131395](C:\Users\asus\AppData\Roaming\Typora\typora-user-images\image-20210616210131395.png)

![image-20210616210310329](C:\Users\asus\AppData\Roaming\Typora\typora-user-images\image-20210616210310329.png)

```html
<%@ page language="java" contentType="text/html; charset=utf-8"
    pageEncoding="utf-8"%>
    <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
    
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>商品展示界面</title>
</head>
<style>
	.header{
		position: absolute;
		width: 100%;
		height: 100px;
		background-color: #EBEBEB;
		padding-left: 510px;
		padding-top: 10px;
		
	}
	.formdiv{
		position: absolute;
		width: 1300px;
		height: 500px;
		background-color:#EBEBEB;
		top:120px;
		 left:30px; 
	}
	.buttom{
	position: absolute;
		width: 1300px;
		height: 20px;
		background-color:#EBEBEB;
		top:420px;
		left:30px; 
	}
</style>
<body> 
<div class="header" >
<h1>商品清单</h1>
</div>
<div class="formdiv">
	<table width="50%" border="5" cellpadding="0" cellspacing="1"align="center">
	<tr>
	<form action="<%=request.getContextPath() %>/selectName1.action" method="post">
	<td colspan="6" width="600" align="center">
	分类模糊查询：<input type="text" id="title" name="goodsname"><input type="submit" value="查询">				
	</td>
	</form>
</tr>
      <tr>       
        <td width="100" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">商品名称</span></div></td>
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">单价</span></div></td>
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">数量</span></div></td>        
        <td width="50" height="20" bgcolor="d3eaef" class="STYLE6"><div align="center"><span class="STYLE10">选择</span></div></td> 
     </tr>
      <c:if test="${not empty goodslist}">
	      <c:forEach items="${goodslist}" var="a">	
		      <form action="<%=request.getContextPath()%>/Cart/addgoods.action" method="post">      
			      <tr>
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.goodsname }</div></td>
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">${a.price}</div></td>   
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center">数量：<input type="text" name="num" value="1">	</div></td>             				              
			    	<input type="hidden" name="goodsId" value="${a.id}">             				              	        
			        <td height="20" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><input type="submit" value="加入购物车"></div></td>	             	
			      </tr>
		      </form> 	    
	  	 </c:forEach>
      </c:if>
       <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath() %>/Account/account.action" style="text-decoration: none;">我的购物车</a></div></td>
      </tr>
      <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><a href="<%=request.getContextPath() %>/Account/cashier.action" style="text-decoration: none;">结算</a></div></td>
      </tr>
      <tr>
          <td height="30" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center"><span><a href="${pageContext.request.contextPath}/page/login.jsp" style="text-decoration: none;"><i class="iconfont icon-loginout" ></i><cite>退出登录</cite></a></span></div></td>
      </tr>
       <c:if test="${empty goodslist}">
      <tr>
          <td height="20" colspan="9" bgcolor="#FFFFFF" class="STYLE19"><div align="center">没有商品信息</div></td>
      </tr>
      </c:if>
    </table>
</div> 
 <c:if test="${not empty alert}">
    	<script type="text/javascript">
    	var loginError=""+'${alert}';
    	if(loginError!=""){
        alert(loginError);
        loginError="";
        }</script>
 </c:if>
</body>
</html>
```

