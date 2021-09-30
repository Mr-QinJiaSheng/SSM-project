package cn.qin.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import cn.qin.pack.CashContext;
import cn.qin.service.CartService;


@Controller
@RequestMapping("/Cash")
public class CashController {
	@Autowired
	private CartService cartService;
	//在结算界面点结算跳转的controller
	@RequestMapping("/accountcash")
	public String accountcash(HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		ModelAndView modelAndView = new ModelAndView();
		int ret = cartService.deleteAll();
		String url = "";
		if(ret>0){
			modelAndView.addObject("alert", "结算成功，继续购物");
			//如果结算成功，则返回购物界面并带着一个参数i
			//为的是在购物界根据不同的问题显示不同的提示语句
			url = "redirect:/showgoods.action?i=3";
		}else{
			modelAndView.addObject("alert", "结算失败");
			url = "account";
		}
		return url;
		
	}
}
