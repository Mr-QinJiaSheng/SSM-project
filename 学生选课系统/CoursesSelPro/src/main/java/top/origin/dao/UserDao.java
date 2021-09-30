package top.origin.dao;

import top.origin.model.Student;
import top.origin.model.Teacher;

import java.util.List;

public interface UserDao {
    Student selectStuById(int id);

    Teacher selectTeaById(int id);

    void updateStuPass(Student student);

    void updateTeaPass(Teacher teacher);

    List<Teacher> queryAllTeacher();
}
