package cn.qin.pack;



public class CashContext {
	//父类对象
	CashSuper cs = null;
	
	//根据传入参数不同，实现不同策略
	public CashContext(){
		CashNormal cs0 = new CashNormal();
		cs = cs0;
	}
	public CashContext(double rebate){
		CashRebate cr2 = new CashRebate(rebate);
		cs = cr2;
	}
	public CashContext(double moneyCondition,double moneyReturn){
		CashReturn cr1 = new CashReturn(moneyCondition, moneyReturn);
		cs = cr1;
	}
	
	public double getResult(double money){
		return cs.acceptCash(money);
		
	}
	
	
	
}
