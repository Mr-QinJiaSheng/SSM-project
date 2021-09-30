package cn.qin.service;




public interface CartService {
	void insertGoods(int id,int num);
	int deleteAll();
	int deleteCartById(int id);
}
