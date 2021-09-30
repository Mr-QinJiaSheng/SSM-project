package top.origin.service;

import top.origin.model.Student;
import top.origin.model.Teacher;

import java.util.List;

/**
 * UserService接口
 */
public interface UserService {
    /**
     * 根据id和密码检查用户
     *
     * @param id   学号/教师账号
     * @param pass 密码
     * @return 用户角色, 1: 学生, 2: 教师
     */
    int checkAccount(int id, String pass);

    /**
     * 根据学号获取学生姓名
     *
     * @param id 学号
     * @return 学生姓名
     */
    String getStuNameById(int id);

    /**
     * 根据id获取教师姓名
     *
     * @param id 教师账号
     * @return 教师姓名
     */
    String getTeaNameById(int id);

    Student getStuInfoById(int id);

    Teacher getTeaInfoById(int id);

    void changeStuPass(Student student);

    void changeTeaPass(Teacher teacher);

    List<Teacher> queryAllTeacher();

    Teacher selectTeaById(int id);
}
