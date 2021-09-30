package top.origin.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.origin.dao.CourseDao;
import top.origin.dao.ManagerDao;
import top.origin.model.Course;
import top.origin.model.Manager;
import top.origin.model.Student;
import top.origin.model.Teacher;
import top.origin.service.ManagerService;

import java.util.List;

@Service
public class ManagerServiceImpl implements ManagerService {

    @Autowired
    private ManagerDao managerDao;

    @Autowired
    private CourseDao courseDao;

    @Override
    public Manager adminLogin(Manager m) {

        return managerDao.checkAdmin(m);
    }

    @Override
    public Manager selectAdminById(int id) {

        return managerDao.selectAdminById(id);
    }

    @Override
    public int checkAccount(int id, String pass) {

        if (managerDao.selectAdminById(id).getmPass().equals(pass))
            return 1;
        else
            return 0;
    }

    @Override
    public void changeMPass(Manager manager) {

        managerDao.updateMPass(manager);
    }

    @Override
    public List<Teacher> queryAllTea() {
        List<Teacher> list = managerDao.queryAllTea();
        for (Teacher t : list) {
            List<Course> list2 = managerDao.queryCourseById(t.getTeaId());
            String cName = "";
            for (Course course : list2) {
                cName += course.getClassName() + ",";
                t.setCourseName(cName);
            }
        }
        return list;
    }

    @Override
    public List<Student> queryAllStu() {
        List<Student> list = managerDao.queryAllStu();
        for (Student s : list) {
            List<Integer> list2 = managerDao.queryCheckedcourseById(s.getStuId());
            String cName = "";
            for (Integer i : list2) {
                cName += managerDao.selectClassNameByCId(i).getClassName() + ",";
                s.setClassName(cName);
            }

        }
        return list;
    }

    @Override
    public void addTeacher(Teacher teaname) {

        managerDao.addTeacher(teaname);
    }

    @Override
    public List<Teacher> queryTeacherBytId(int tId) {
        List<Teacher> list = managerDao.queryTeacherBytId(tId);
        for (Teacher t : list) {
            List<Course> list2 = managerDao.queryCourseById(t.getTeaId());
            String cName = "";
            for (Course course : list2) {
                cName += course.getClassName() + ",";
                t.setCourseName(cName);
            }
        }
        return list;
    }

    @Override
    public List<Teacher> queryTeacherBytName(String tName) {
        List<Teacher> list = managerDao.queryTeacherBytName(tName);
        for (Teacher t : list) {
            List<Course> list2 = managerDao.queryCourseById(t.getTeaId());
            String cName = "";
            for (Course course : list2) {
                cName += course.getClassName() + ",";
                t.setCourseName(cName);
            }
        }
        return list;
    }

    @Override
    public void addStudent(Student stuname) {
        stuname.setInsName(courseDao.selectNameByInsId(stuname.getInsId()));
        managerDao.addStudent(stuname);
    }

    @Override
    public List<Student> queryStudentBysId(int sId) {
        List<Student> list = managerDao.queryStudentBysId(sId);
        for (Student s : list) {
            List<Integer> list2 = managerDao.queryCheckedcourseById(s.getStuId());
            String cName = "";
            for (Integer i : list2) {
                cName += managerDao.selectClassNameByCId(i).getClassName() + ",";
                s.setClassName(cName);
            }
        }
        return list;
    }

    @Override
    public List<Student> queryStudentBysName(String sName) {
        List<Student> list = managerDao.queryStudentBysName(sName);
        for (Student s : list) {
            List<Integer> list2 = managerDao.queryCheckedcourseById(s.getStuId());
            String cName = "";
            for (Integer i : list2) {
                cName += managerDao.selectClassNameByCId(i).getClassName() + ",";
                s.setClassName(cName);
            }

        }
        return list;
    }

    @Override
    public void deleteTeacher(int teaid) {
        managerDao.deleteTeacherByTid(teaid);

        List<Course> courses = courseDao.queryCourseById(teaid);
        for (Course course : courses) {
            courseDao.deleteCourseById(course.getClassId());
            courseDao.deleteLimitByClassId(course.getClassId());
            courseDao.deleteStuByClassId(course.getClassId());
        }
    }

    @Override
    public void deleteStudent(int stuid) {

        managerDao.deleteStudentBySid(stuid);

        List<Integer> id = courseDao.queryCourseIdByStuId(stuid);
        for (Integer i : id) {
            Course course = managerDao.queryCourseByClassId(i);

            int num = course.getClassChooseNum();

            if (num != 0) {
                course.setClassChooseNum(num - 1);
            }
            courseDao.updateCourse(course);
        }
    }
}
