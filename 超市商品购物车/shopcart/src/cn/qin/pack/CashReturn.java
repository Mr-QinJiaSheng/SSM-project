package cn.qin.pack;

public class CashReturn implements CashSuper {
	
	private double moneyCondition = 0.0;
	private double moneyReturn = 0.0;
	public CashReturn (double moneyCondition,double moneyReturn){
		this.moneyCondition = moneyCondition;
		this.moneyReturn = moneyReturn;
	}	
	@Override
	public double acceptCash(double money) {
		// TODO Auto-generated method stub
		double result = money;
		result= money - Math.floor(money/moneyCondition)*moneyReturn;
		return result;
	}

	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

}
