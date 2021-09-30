package cn.qin.service;

import java.util.Map;

import cn.qin.pojo.Discount;

public interface DiscountService {
	int insertCashReturn(double moneyCondition,double moneyRebate);
	int insertCashRebate(double rate);
	int deleteAll();
	Discount selectDiscount();
}
