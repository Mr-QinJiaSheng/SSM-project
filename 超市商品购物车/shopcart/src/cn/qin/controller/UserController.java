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


