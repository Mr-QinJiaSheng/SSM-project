package cn.qin.serviceImpl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;

import cn.qin.mapper.GoodsMapper;
import cn.qin.pojo.Goods;
import cn.qin.service.GoodsService;

public class GoodsServiceImpl implements GoodsService {
	@Autowired
	private GoodsMapper goodsMapper;
	
	@Override
	public List<Goods> selectAllGoods() {
		// TODO Auto-generated method stub
		return goodsMapper.selectAllGoods();
	}
	@Override
	public Goods selectGoodsById(int id) {
		// TODO Auto-generated method stub
		return goodsMapper.selectGoodsById(id);
	}

	@Override
	public List<Goods> selectGoodByName(String goodsname) {
		// TODO Auto-generated method stub
		return goodsMapper.selectGoodByName(goodsname);
	}

	@Override
	public int insertGoods(Goods record) {
		// TODO Auto-generated method stub
		return goodsMapper.insertGoods(record);
	}

	@Override
	public int deleteById(Integer[] id) {
		// TODO Auto-generated method stub
		return goodsMapper.deleteById(id);
	}

	@Override
	public int updateByid(Goods record) {
		return goodsMapper.updateByid(record);
	}
}
