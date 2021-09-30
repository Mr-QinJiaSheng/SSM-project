package top.origin.service;

import top.origin.model.Manager;
import top.origin.model.Student;
import top.origin.model.Teacher;

import java.util.List;

public interface ManagerService {

    Manager adminLogin(Manager m);

    Manager selectAdminById(int id);

    int checkAccount(int id, String prepass);

    void changeMPass(Manager manager);


    List<Teacher> queryAllTea();

    List<Student> queryAllStu();

    void addTeacher(Teacher teaname);

    List<Teacher> queryTeacherBytId(int tId);

    List<Teacher> queryTeacherBytName(String tName);

    void addStudent(Student stuname);

    List<Student> queryStudentBysId(int sId);

    List<Student> queryStudentBysName(String sName);

    void deleteTeacher(int teaid);

    void deleteStudent(int stuid);


}
