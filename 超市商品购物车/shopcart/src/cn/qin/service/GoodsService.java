package cn.qin.service;

import java.util.List;

import cn.qin.pojo.Goods;

public interface GoodsService {
	
	List<Goods>	selectAllGoods();
	//根据id查商品
	Goods selectGoodsById(int id);
	//根据名称模糊查询
	List<Goods> selectGoodByName(String goodsname);
	//添加商品
	public int insertGoods(Goods record);
	//根据id删除商品
	public int deleteById(Integer[] id);
	//修改商品属性
	public int updateByid(Goods goods);
}
