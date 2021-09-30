package cn.qin.mapper;

import java.util.HashMap;

import cn.qin.pojo.Discount;

public interface DiscountMapper {
	int insertCashReturn(HashMap<String,Object> map);
	int insertCashRebate(double rate);
	int deleteAll();
	Discount selectDiscount();
}
