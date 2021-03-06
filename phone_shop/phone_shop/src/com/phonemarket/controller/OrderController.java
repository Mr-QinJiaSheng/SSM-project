package com.phonemarket.controller;

import java.io.FileWriter;
import java.io.IOException;
import java.io.OutputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.alibaba.fastjson.serializer.SerializeConfig;
import com.alibaba.fastjson.serializer.SerializerFeature;
import com.alipay.api.AlipayApiException;
import com.alipay.api.AlipayClient;
import com.alipay.api.DefaultAlipayClient;
import com.alipay.api.internal.util.AlipaySignature;
import com.alipay.api.request.AlipayTradePagePayRequest;
import com.fasterxml.jackson.databind.SerializationFeature;
import com.github.pagehelper.PageInfo;
import com.phonemarket.entity.Address;
import com.phonemarket.entity.Cart;
import com.phonemarket.entity.Goods;
import com.phonemarket.entity.Guess;
import com.phonemarket.entity.Order;
import com.phonemarket.entity.OrderDetail;
import com.phonemarket.entity.Users;
import com.phonemarket.service.IAddressService;
import com.phonemarket.service.ICartService;
import com.phonemarket.service.IGoodsService;
import com.phonemarket.service.IGuessService;
import com.phonemarket.service.IOrderService;
import com.phonemarket.util.AlipayConfig;
import com.phonemarket.util.OrderSearchVO;
import com.phonemarket.util.OrderVO;

@Controller
@RequestMapping("/order")
public class OrderController {
	@Autowired
	private ICartService cartService;
	@Autowired
	private IGoodsService goodsService;
	@Autowired
	private IOrderService orderService;
	@Autowired
	private IAddressService addressService;
	@Autowired
	private IGuessService guessService;
	
	//?????????
	@RequestMapping("takeOrder")
	public String takeOrder(Integer[] goodslist,Integer addr,Model model,HttpServletRequest request){
		List<Cart> cartList=new ArrayList<Cart>();
		List<OrderDetail> detailList=new ArrayList<OrderDetail>();
		Double totalPrice=0D;
		for (Integer i : goodslist) {
			Cart cart = cartService.findCartById(i);
			totalPrice+=cart.getCartNum()*cart.getCartGoods().getGoodsPrice();
			cartList.add(cart);
			OrderDetail detail=new OrderDetail(cart.getCartGoods(), cart.getCartGoods().getGoodsPrice()*cart.getCartNum(), cart.getCartNum());
			detailList.add(detail);
		}
		HttpSession session = request.getSession();
		Users user=(Users) session.getAttribute("user");
		Date orderDate=new Date();
		Address address = addressService.findAddresById(addr);
		String a=address.getAddrProvince()+address.getAddrCity()+address.getAddrArea()+address.getAddrDetail();
		Order order=new Order(user, orderDate, totalPrice, 1, address.getAddrNickname(), address.getAddrPhone(), a);
		order.setDetailList(detailList);
		Order takeOrder = orderService.takeOrder(order);
		for (Cart c : cartList) {
			Goods goods = goodsService.findById(c.getCartGoods().getGoodsId());
			goods.setGoodsNum(goods.getGoodsNum()-c.getCartNum());
			goods.setGoodsVolume(goods.getGoodsVolume()+c.getCartNum());
			goodsService.update(goods);
			cartService.deleteCart(c.getCartId());
		}
		model.addAttribute("order",takeOrder);
		List<Guess> guessList = guessService.findGuessGoodsByUserId(user.getUserId(), 4);
		model.addAttribute("guessList", guessList);
		return "userview/takeorder";
	}
	
	@RequestMapping("findReadPayOrder")
	@ResponseBody
	public List<Order> findReadyPayOrder(HttpServletRequest request){
		HttpSession session = request.getSession();
		Users user=(Users) session.getAttribute("user");
		List<Order> orderList = orderService.findOrdersByUserIdAndState(user.getUserId(), 1);
		return orderList;
	}
	@RequestMapping("findReadyToDeliverOrder")
	@ResponseBody
	public List<Order> findReadyToDeliverOrder(HttpServletRequest request){
		HttpSession session = request.getSession();
		Users user = (Users) session.getAttribute("user");
		List<Order> orderList = orderService.findOrdersByUserIdAndState(user.getUserId(), 2);
		return orderList;
	}
	@RequestMapping("findReadyToReceiveOrder")
	@ResponseBody
	public List<Order> findReadToReceiveOrder(HttpServletRequest request){
		HttpSession session = request.getSession();
		Users user = (Users) session.getAttribute("user");
		List<Order> orderList = orderService.findOrdersByUserIdAndState(user.getUserId(), 3);
		return orderList;
	}
	@RequestMapping("findReadyToEvaluateOrder")
	@ResponseBody
	public List<Order> findReadyToEvaluateOrder(HttpServletRequest request){
		HttpSession session = request.getSession();
		Users user = (Users) session.getAttribute("user");
		List<Order> orderList = orderService.findOrdersByUserIdAndState(user.getUserId(), 4);
		return orderList;
	}
	@RequestMapping("findFinishOrder")
	@ResponseBody
	public List<Order> findFinishOrder(HttpServletRequest request){
		HttpSession session = request.getSession();
		Users user = (Users) session.getAttribute("user");
		List<Order> orderList = orderService.findOrdersByUserIdAndState(user.getUserId(), 5);
		return orderList;
		
	}
	
	@RequestMapping("receiveOrder")
	@ResponseBody
	public String receiveOrder(String orderId){
		Integer rs = orderService.receiveOrder(orderId);
		if(rs>0){
			return "success";
		}else{
			return "fail";
		}
	}
	@RequestMapping("deleteOrder")
	@ResponseBody
	public String deleteOrder(String orderId){
		Integer rs = orderService.deleteOrder(orderId);
		if(rs>0){
			return "success";
		}else{
			return "fail";
		}
	}
	@RequestMapping("findOrderBySplitPage")
	@ResponseBody
	public JSONObject findOrderBySplitPage(Integer page,Integer limit,OrderSearchVO vo){
		if(vo!=null){
			System.out.println(vo.getOrderState()+"========================");
		}
		PageInfo<Order> info = orderService.findOrdersBySplitPage(page, limit,vo);
		JSONObject obj=new JSONObject();
		obj.put("msg", "");
		obj.put("code", 0);
		obj.put("count", info.getTotal());
		obj.put("data", info.getList());
		return obj;
	}
	@RequestMapping("updateOrder")
	@ResponseBody
	public String updateOrder(Order order){
		Integer rs = orderService.updateOrder(order);
		if(rs>0){
			return "success";
		}else{
			return "fail";
		}
	}
	@RequestMapping("deliverOrder")
	@ResponseBody
	public String deliverOrder(String orderId,String expressNo){
		if(!expressNo.trim().equals("")){
			Integer rs = orderService.deliverOrder(orderId, expressNo);
			if(rs>0){
				return "success";
			}else{
				return "fail";
			}
		}else{
			return "fail";
		}
	}
	@RequestMapping("findOrderById")
	@ResponseBody
	public Order findOrderById(String orderId){
		Order order = orderService.findOrderById(orderId);
		return order;
	}
	@RequestMapping("findTotalOrder")
	@ResponseBody
	public JSONObject findOrderTotalMoney(){
		List<OrderVO> list = orderService.findTotalMoneyByMonth(6);
		String[] month=new String[6];
		Long[] total=new Long[6];
		Integer[] sheets=new Integer[6];
		for(int i=0;i<list.size();i++){
			month[i]=list.get(i).getOrderMonth();
			total[i]=list.get(i).getTotalMoney();
			sheets[i]=list.get(i).getSheets();
		}
		JSONObject obj=new JSONObject();
		obj.put("month", month);
		obj.put("total", total);
		obj.put("sheets", sheets);
		return obj;
	}
	@RequestMapping("findToDo")
	@ResponseBody
	public JSONObject findToDo(){
		Integer totalOrder = orderService.findTotalOrder();
		Integer totalDediver = orderService.findTotalDeliverOrder();
		JSONObject obj=new JSONObject();
		obj.put("total", totalOrder);
		obj.put("deliver", totalDediver);
		return obj;
	}
	
	@RequestMapping("toPay")
	public String toPayFor(String orderId,HttpServletResponse response){
		AlipayClient alipayClient = new DefaultAlipayClient(AlipayConfig.gatewayUrl, AlipayConfig.app_id, AlipayConfig.merchant_private_key, "json", AlipayConfig.charset, AlipayConfig.alipay_public_key, AlipayConfig.sign_type);
		//??????????????????
		AlipayTradePagePayRequest alipayRequest = new AlipayTradePagePayRequest();
		alipayRequest.setReturnUrl(AlipayConfig.return_url);
		alipayRequest.setNotifyUrl(AlipayConfig.notify_url);
		Order order = orderService.findOrderById(orderId);
		//?????????????????????????????????????????????????????????????????????
		String out_trade_no=null;
		//?????????????????????
		String total_amount=null;
		//?????????????????????
		String subject=null;
		try {
			out_trade_no = new String(orderId.getBytes("ISO-8859-1"),"UTF-8");
			total_amount = new String((order.getOrderPrice()+"").getBytes("ISO-8859-1"),"UTF-8");
			subject = new String("????????????");
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}
		//?????????????????????
		List<OrderDetail> detailList = order.getDetailList();
		String body = null;
		for (OrderDetail o : detailList) {
			body=body+o.getDetailGoods().getGoodsName()+",";
		}
		body=body.substring(0, body.length()-1)+"?????????";
		
		alipayRequest.setBizContent("{\"out_trade_no\":\""+ out_trade_no +"\"," 
				+ "\"total_amount\":\""+ total_amount +"\"," 
				+ "\"subject\":\""+ subject +"\"," 
				+ "\"body\":\""+ body +"\"," 
				+ "\"product_code\":\"FAST_INSTANT_TRADE_PAY\"}");
		//			String result = alipayClient.pageExecute(alipayRequest).getBody();
					Integer rs = orderService.payForOrder(out_trade_no);
					String result = "";
					if(rs>0){
						return "paysuccess";	
					}else {
						return null;
					}
					
	}
	@RequestMapping("notify_url")
	public void notifyUrl(HttpServletRequest request,HttpServletResponse response){
		Map<String,String> params = new HashMap<String,String>();
		Map<String,String[]> requestParams = request.getParameterMap();
		for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
			String name = (String) iter.next();
			String[] values = (String[]) requestParams.get(name);
			String valueStr = "";
			for (int i = 0; i < values.length; i++) {
				valueStr = (i == values.length - 1) ? valueStr + values[i]
						: valueStr + values[i] + ",";
			}
			//???????????????????????????????????????????????????
			try {
				valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			params.put(name, valueStr);
		}
		
		boolean signVerified=false;
		try {
			signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type);
		} catch (AlipayApiException e1) {
			e1.printStackTrace();
		} //??????SDK????????????

		//????????????????????????????????????????????????????????????????????????
		
		/* ?????????????????????????????????????????????????????????
		1????????????????????????????????????out_trade_no?????????????????????????????????????????????
		2?????????total_amount?????????????????????????????????????????????????????????????????????????????????
		3?????????????????????seller_id?????????seller_email) ?????????out_trade_no??????????????????????????????????????????????????????????????????????????????seller_id/seller_email???
		4?????????app_id???????????????????????????
		*/
		PrintWriter out=null;
		try {
			out = response.getWriter();
		} catch (IOException e) {
			e.printStackTrace();
		}
		if(signVerified) {//????????????
			//???????????????
			String out_trade_no="";
			//????????????
			String trade_status="";
			try {
				out_trade_no = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");

				//??????????????????
				String trade_no = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");

				trade_status = new String(request.getParameter("trade_status").getBytes("ISO-8859-1"),"UTF-8");
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
			
			if(trade_status.equals("TRADE_FINISHED")||trade_status.equals("TRADE_SUCCESS")){
				//????????????????????????????????????????????????????????????
				//?????????????????????????????????????????????out_trade_no????????????????????????????????????????????????????????????????????????????????????????????????
				//??????????????????????????????????????????????????????
				Integer rs = orderService.payForOrder(out_trade_no);
				if(rs>0){
					System.out.println("????????????????????????");
				}
				//?????????
				//????????????????????????????????????????????????????????????
			}
			
			out.println("success");
			
		}else {//????????????
			out.println("fail");
		
			//???????????????????????????????????????????????????????????????
			//String sWord = AlipaySignature.getSignCheckContentV1(params);
			//AlipayConfig.logResult(sWord);
		}
	}
	@RequestMapping("return_url")
	public String returnUrl(String out_trade_no){
		Integer rs = orderService.payForOrder(out_trade_no);
		if(rs>0){
			System.out.println("????????????????????????");
		}
		return "paysuccess";
	}
	
}
