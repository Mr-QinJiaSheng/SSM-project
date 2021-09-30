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
