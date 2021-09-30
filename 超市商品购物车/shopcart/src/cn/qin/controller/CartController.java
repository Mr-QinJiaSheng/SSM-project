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
