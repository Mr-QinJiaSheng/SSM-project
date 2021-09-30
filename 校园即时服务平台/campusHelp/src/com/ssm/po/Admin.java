package com.ssm.po;

import java.util.Date;

public class Admin {
    private Integer aid;//管理员id

    private String account;//管理员账户

    private String password;//管理员密码

    private String name;//管理员姓名

    private Date addtime;//注册时间

    private Integer state;//状态
    
    
    public Admin() {
		super();
	}

	public Admin(Integer aid, String account, String password, String name, Date addtime, Integer state) {
		super();
		this.aid = aid;
		this.account = account;
		this.password = password;
		this.name = name;
		this.addtime = addtime;
		this.state = state;
	}

	public Integer getAid() {
        return aid;
    }

    public void setAid(Integer aid) {
        this.aid = aid;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Date getAddtime() {
        return addtime;
    }

    public void setAddtime(Date addtime) {
        this.addtime = addtime;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

	@Override
	public String toString() {
		return "Admin [aid=" + aid + ", account=" + account + ", password=" + password + ", name=" + name + ", addtime="
				+ addtime + ", state=" + state + "]";
	}
    
    
}