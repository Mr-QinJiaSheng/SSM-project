package cn.qin.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import cn.qin.pojo.Goods;
import cn.qin.service.GoodsService;

@Controller
/*@RequestMapping("/Goods")
*/public class GoodsController {
	@Autowired
	private GoodsService goodsService;
	
	//前台商品展示刷新展示商品界面
	@RequestMapping("showgoods")
	public ModelAndView UserLogin(HttpServletRequest req,HttpServletResponse rsp) throws Exception{
		ModelAndView modelAndView=new ModelAndView();
		/*增加参数i的原因
		 * 由于需要从别的controller转发到这个controller进行商品的刷新展示
		 * 但是有需要有提示语句，所有通过传过来的不同参数，在展示商品界面展示不同的提示语
		 * */
		String i = req.getParameter("i");
		if(i!=null&&i.length()>0){
			int r = Integer.parseInt(i);
			//从Cart/addgoods.action加入购物车中跳转过来
			if(r==1){
				modelAndView.addObject("alert", "请输入合理的数量");
			}
			if(r==2){
				modelAndView.addObject("alert", "请输入数量");

			}
			//从Cart/accountcash。action结算中跳转过来
			if(r==3){
				modelAndView.addObject("alert", "结算成功请继续购物");
			}
		}
		List<Goods> goodslist = goodsService.selectAllGoods();
		modelAndView.addObject("goodslist", goodslist);
		modelAndView.setViewName("showgoods");	
		return modelAndView;
		
	}
	
	/*从这里开始是后台商品管理的action*/	
	
	//后台管理中的添加商品
		@RequestMapping("/insert")
		public String insert(Goods record){
		goodsService.insertGoods(record);	
		return "redirect:goodsList.action";
		}
		
		//后台管理中的删除商品
		@RequestMapping("/delete")
		public ModelAndView delete(Integer[] id,HttpServletRequest req,HttpServletResponse res,RedirectAttributes attr){
			ModelAndView modelAndView=new ModelAndView();
			if(req.getParameter("id")!=null&&req.getParameter("id").length()>0){
			int gid=Integer.parseInt(req.getParameter("id"));
			if(gid>0){
			    goodsService.deleteById(id);
				attr.addFlashAttribute("alert", "删除成功");
				modelAndView=new ModelAndView("redirect:goodsList.action");		
			}else{
				 attr.addFlashAttribute("alert", "删除失败");
				 modelAndView=new ModelAndView("redirect:goodsList.action");
			}
			}else{
				 attr.addFlashAttribute("alert", "请选择要删除的商品");
				 modelAndView=new ModelAndView("redirect:goodsList.action");
			}
			return modelAndView;
		}
		
		//后台管理中的根据id查找商品
		@RequestMapping("/toupdate")
		public String toupdate(int id,Model model){
			Goods goods = goodsService.selectGoodsById(id);
			model.addAttribute("goods", goods);
			return "goods/updateGoods";
		}
		//后台管理中的修改商品
		@RequestMapping("/update")
		public String update(Goods record,Model model){
			goodsService.updateByid(record);
			Goods goods = goodsService.selectGoodsById(record.getId());
			model.addAttribute("goods", goods);
			return "redirect:goodsList.action";
		}
		//后台管理刷新展示商品
		@RequestMapping("/goodsList")
		public String goodsList(Model model) throws Exception{
			List<Goods> goodslist = goodsService.selectAllGoods();
			model.addAttribute("goodslist", goodslist);
			return "goods/goodsList";	
		}
		//后台管理根据名称模糊查询商品
		@RequestMapping("/selectName")
		public ModelAndView selectName(HttpServletRequest req,HttpServletResponse rsp)throws Exception{
			String goodsname = req.getParameter("goodsname");
			List<Goods> goodslist=goodsService.selectGoodByName(goodsname);
			ModelAndView modelAndView=new ModelAndView();
			modelAndView.addObject("goodslist",goodslist);
			modelAndView.setViewName("goods/goodsList");
			return modelAndView;
		}
}
