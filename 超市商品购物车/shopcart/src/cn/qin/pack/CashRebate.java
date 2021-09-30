package cn.qin.pack;

public class CashRebate implements CashSuper {
	
	private double moneyRebate = 1.0;
	public CashRebate(double moneyRebate){
		this.moneyRebate = moneyRebate;
	}
	@Override
	public double acceptCash(double money) {
		// TODO Auto-generated method stub
		return money*moneyRebate;
	}

}
