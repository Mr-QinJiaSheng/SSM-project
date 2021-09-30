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
