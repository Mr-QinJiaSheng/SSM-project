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
