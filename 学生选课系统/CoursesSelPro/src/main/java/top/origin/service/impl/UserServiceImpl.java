package top.origin.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.origin.dao.UserDao;
import top.origin.model.Student;
import top.origin.model.Teacher;
import top.origin.service.UserService;

import java.util.List;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    public int checkAccount(int id, String pass) {
        if (Integer.toString(id).charAt(4) == '1') {
            if (userDao.selectTeaById(id).getTeaPass().equals(pass))
                return 2;
            else
                return 0;
        } else {
            if (userDao.selectStuById(id).getStuPass().equals(pass))
                return 1;
            else
                return 0;
        }
    }

    @Override
    public String getStuNameById(int id) {
        return userDao.selectStuById(id).getStuName();
    }

    @Override
    public String getTeaNameById(int id) {
        return userDao.selectTeaById(id).getTeaName();
    }

    @Override
    public Student getStuInfoById(int id) {
        return userDao.selectStuById(id);
    }

    @Override
    public Teacher getTeaInfoById(int id) {
        return userDao.selectTeaById(id);
    }

    @Override
    public void changeStuPass(Student student) {
        userDao.updateStuPass(student);
    }

    @Override
    public void changeTeaPass(Teacher teacher) {
        userDao.updateTeaPass(teacher);
    }

    @Override
    public List<Teacher> queryAllTeacher() {
        return userDao.queryAllTeacher();
    }

    @Override
    public Teacher selectTeaById(int id) {

        return null;
    }
}
