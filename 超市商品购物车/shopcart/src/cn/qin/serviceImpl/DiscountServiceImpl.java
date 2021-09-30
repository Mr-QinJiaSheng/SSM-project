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
