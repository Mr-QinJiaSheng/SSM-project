package cn.qin.mapper;

import cn.qin.pojo.User;

public interface UserMapper {
	User findUser(User user);
	User findUsername(User user);
	public void insertUser(User user);
}
