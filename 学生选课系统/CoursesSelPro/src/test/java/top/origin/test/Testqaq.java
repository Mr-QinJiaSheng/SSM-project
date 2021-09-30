package top.origin.test;

import java.util.List;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import top.origin.dao.ManagerDao;
import top.origin.model.Student;


@RunWith(SpringJUnit4ClassRunner.class) //使用junit4进行测试
@ContextConfiguration(locations={"classpath:spring-mybatis.xml"}) //加载配置文件
public class Testqaq {

	  
	  @Autowired
	private ManagerDao managerDao;
	  
	 
	  @Test
	  public void testadd(){
		  
//		 long id = managerDao.addTeacher("戴老师");
//		 System.out.println(id);
		  
		  List<Student> name = managerDao.queryStudentBysName("王");
		  
		  for (Student student : name) {
			System.out.println(student.getClassName());
		}
		 
	  }
}
