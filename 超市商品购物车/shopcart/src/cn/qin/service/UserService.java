package cn.qin.service;

import cn.qin.pojo.User;

public interface UserService {
	//根据status判断用户权限
	int findUser(User user);
	//根据user名查询
	User findUsername(User user);
	//注册添加user
	public void insertUser(User user);
}
