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
