package cn.qin.serviceImpl;

import org.springframework.beans.factory.annotation.Autowired;

import cn.qin.mapper.UserMapper;
import cn.qin.pojo.User;
import cn.qin.service.UserService;

public class UserServiceImpl implements UserService {
	@Autowired
	private UserMapper userMapper;
	
	@Override
	public int findUser(User user) {
		// TODO Auto-generated method stub
		int result=0;
		//判断手机号是否为空
			User user1 = userMapper.findUser(user);
			if(user1!=null){
				result=1;
			}else{
				result=2;
			}
		
		return result;
	}
	@Override
	public void insertUser(User user) {
		userMapper.insertUser(user);
	}

	@Override
	public User findUsername(User user) {
		// TODO Auto-generated method stub
		return userMapper.findUsername(user);
	}

}
