package top.origin.dao;

import top.origin.model.Course;
import top.origin.model.Manager;
import top.origin.model.Student;
import top.origin.model.Teacher;

import java.util.List;

public interface ManagerDao {

    Manager checkAdmin(Manager m);

    Manager selectAdminById(int id);

    void updateMPass(Manager m);

    List<Teacher> queryAllTea();

    List<Course> queryCourseById(int teaId);

    List<Student> queryAllStu();

    List<Integer> queryCheckedcourseById(int stuId);

    void addTeacher(Teacher t);

    List<Teacher> queryTeacherBytId(int tId);

    List<Teacher> queryTeacherBytName(String tName);

    Course selectClassNameByCId(Integer i);

    void addStudent(Student s);

    List<Student> queryStudentBysId(int sId);

    List<Student> queryStudentBysName(String sName);

    void deleteTeacherByTid(int id);

    void deleteStudentBySid(int stuid);

    Course queryCourseByClassId(int id);


}
