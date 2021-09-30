package top.origin.controller.manager;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import top.origin.model.Manager;
import top.origin.model.Student;
import top.origin.model.Teacher;
import top.origin.service.CourseService;
import top.origin.service.ManagerService;
import top.origin.service.PageService;
import top.origin.service.UserService;

import javax.servlet.http.HttpServletRequest;
import java.util.List;

/**
 * 管理员控制器
 */
@Controller
@RequestMapping("manager")
@SessionAttributes({"manager", "username", "mid"}) // 将管理员用户信息保存至会话
public class ManagerController {

    @Autowired
    private ManagerService managerService; // 管理员服务
    @Autowired
    private PageService pageService; // 页面服务
    @Autowired
    private CourseService courseService; // 课程服务
    @Autowired
    private UserService userService;

    @Value("manager/login")
    private String login; // 管理员登录页面
    
    @Value("manager/managerIndex")
    private String Index; // 管理员首页
    
    @Value("manager/teacherList")
    private String teacherList; // 教师列表页面
    @Value("manager/studentList")
    private String studentList; // 学生列表页面

    @Value("padding")
    private String padding;

    @PostMapping(value = "check")
    public String checkAccount(@RequestParam("userid") String id, @RequestParam("userpass") String pass, Model model) {

        Manager manager = new Manager();
        manager.setmName(id);
        manager.setmPass(pass);
        Manager m = managerService.adminLogin(manager);
        if (m != null) {
            model.addAttribute("mid", m.getmId());
            model.addAttribute("username", m.getmName());
            return "manager/managerIndex";
        } else {
            model.addAttribute("msg", "密码错误");
            //这里不加redirect，否则前端el取不到值
            return login;
        }
    }

    @RequestMapping("/login")
    public String managerlogin() {
        return login;
    }

    @RequestMapping("/managerIndex")
    public String managerIndex() {
        return "manager/managerIndex";
    }

    @RequestMapping("/managerInfo")
    public String managerInfo(@RequestParam("mid") int id, Model model) {

        Manager m = managerService.selectAdminById(id);
        model.addAttribute("manager", m);
        return "manager/managerInfo";
    }

    @RequestMapping("/teacherList")
    public String teacherList(@RequestParam("page") int page, Model model) {

        List<Teacher> list = managerService.queryAllTea();
        model.addAttribute(padding, pageService.subList(page, list));

        return teacherList;
    }


    @RequestMapping("/insertTeacher")
    public String toInsetTeacher(Model model) {


        return "manager/insertTeacher";
    }


    @RequestMapping("/addTeacher")
    public String insertTeacher(@RequestParam("teaname") String teaname, @RequestParam("tid") int tid, Model model, HttpServletRequest request) {
        Teacher teacher = new Teacher();
        teacher.setTeaId(tid);
        teacher.setTeaName(teaname);
        teacher.setTeaPass(String.valueOf(tid));
        managerService.addTeacher(teacher);


        List<Teacher> list = managerService.queryAllTea();
        model.addAttribute(padding, pageService.subList(1, list));
        return teacherList;
    }

    @RequestMapping("/deleteTeacher")
    public String deleteTeacher(@Param("teaid") int teaid, Model model, HttpServletRequest request) {
        managerService.deleteTeacher(teaid);

        List<Teacher> list = managerService.queryAllTea();
        model.addAttribute(padding, pageService.subList(1, list));
        return teacherList;
    }

    @RequestMapping("/deleteStudent")
    public String deleteStudent(@Param("stuid") int stuid, Model model, HttpServletRequest request) {
        managerService.deleteStudent(stuid);
        List<Student> list = managerService.queryAllStu();
        model.addAttribute(padding, pageService.subList(1, list));
        return teacherList;
    }

    @RequestMapping("/studentList")
    public String studentList(@RequestParam("page") int page, Model model) {

        List<Student> list = managerService.queryAllStu();
        model.addAttribute(padding, pageService.subList(page, list));

        return studentList;
    }

    @RequestMapping("/insertStudent")
    public String toInsertStudent(Model model) {
        model.addAttribute("insList", courseService.queryAllIns());
        return "manager/insertStudent";
    }

    @RequestMapping("/addStudent")
    public String insertStudent(@RequestParam("stuname") String stuname, @RequestParam("sid") int sid, @RequestParam("insid") int insid, Model model, HttpServletRequest request) {
        Student student = new Student();
        student.setStuId(sid);
        student.setStuName(stuname);
        student.setStuPass(String.valueOf(sid));


        student.setInsId(insid);
        managerService.addStudent(student);


        List<Student> list = managerService.queryAllStu();
        model.addAttribute(padding, pageService.subList(1, list));
        return studentList;
    }

    @RequestMapping("/searchByTid")
    public String searchByTid(@RequestParam("tId") int tId, Model model) {
        List<Teacher> list = managerService.queryTeacherBytId(tId);
        model.addAttribute(padding, pageService.subList(1, list));
        return teacherList;
    }

    @RequestMapping("/searchByTname")
    public String searchByTname(@RequestParam("tName") String tName, Model model) {
        List<Teacher> list = managerService.queryTeacherBytName(tName);
        model.addAttribute(padding, pageService.subList(1, list));
        return teacherList;
    }

    @RequestMapping("/searchBySid")
    public String searchBySid(@RequestParam("sId") int sId, Model model) {
        List<Student> list = managerService.queryStudentBysId(sId);
        model.addAttribute(padding, pageService.subList(1, list));
        return studentList;
    }

    @RequestMapping("/searchBySname")
    public String searchBySname(@RequestParam("sName") String sName, Model model) {
        List<Student> list = managerService.queryStudentBysName(sName);
        model.addAttribute(padding, pageService.subList(1, list));
        return studentList;
    }

    @RequestMapping("/editMPass")
    public String editMPass(HttpServletRequest request) {

        return "manager/editMPass";
    }

    @RequestMapping("/changeMPass")
    public String changeMPass(@RequestParam("prepass") String prepass, @RequestParam("nowpass") String nowpass, Model model, HttpServletRequest request) {
        int id = (int) request.getSession().getAttribute("mid");
        if (managerService.checkAccount(id, prepass) == 0) {
            model.addAttribute("msg", "原始密码输入错误!");
            return "manager/editMPass";
        } else {
            Manager manager = new Manager();
            manager.setmId(id);
            manager.setmPass(nowpass);
            managerService.changeMPass(manager);
            model.addAttribute("manager", managerService.selectAdminById(id));
            return "manager/managerInfo";
        }
    }


    @RequestMapping("exit")
    public String exit(HttpServletRequest request, SessionStatus status) {
        status.setComplete();
        request.getSession().invalidate();
        return login;
    }

}
