package cn.qin.mapper;

import java.util.List;

import cn.qin.pojo.Goods;

public interface GoodsMapper {
	List<Goods>	selectAllGoods();
	Goods selectGoodsById(int id);
	//根据商品名称模糊查询
		List<Goods> selectGoodByName(String goodsname);
		//添加商品
		public int insertGoods(Goods record);
		//根据ID删除商品
		public int deleteById(Integer[] id);
		//修改商品属性
		public int  updateByid(Goods record);
}
