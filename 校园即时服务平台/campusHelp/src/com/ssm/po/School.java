package com.ssm.po;

import java.util.Date;

public class School {
    private Integer schoolid;//学校id

    private String name;//学校名称

    private Date addtime;//添加时间

    private Integer state;//状态
    
    public School() {
		super();
	}

	public School(Integer schoolid, String name, Date addtime, Integer state) {
		super();
		this.schoolid = schoolid;
		this.name = name;
		this.addtime = addtime;
		this.state = state;
	}

	public Integer getSchoolid() {
        return schoolid;
    }

    public void setSchoolid(Integer schoolid) {
        this.schoolid = schoolid;
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
		return "School [schoolid=" + schoolid + ", name=" + name + ", addtime=" + addtime + ", state=" + state + "]";
	}
    
    
}