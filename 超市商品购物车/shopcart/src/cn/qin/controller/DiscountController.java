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
