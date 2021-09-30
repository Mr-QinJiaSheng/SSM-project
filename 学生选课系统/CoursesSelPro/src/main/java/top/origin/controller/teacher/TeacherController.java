package top.origin.controller.teacher;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import top.origin.model.Teacher;
import top.origin.service.CourseService;
import top.origin.service.PageService;
import top.origin.service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

/**
 * 教师页面控制器
 */
@Controller
@RequestMapping("teacher")
public class TeacherController {
    @Resource
    private UserService userService;
    @Resource
    private CourseService courseService;
    @Resource
    private PageService pageService;

    @Value("teacher/teacherInfo")
    private String teacherInfo; // 教师信息页面

    @Value("teacher/editTeaPass")
    private String editTeaPass; // 教师信息编辑页面

    @Value("teacher/courseList")
    private String courseList; // 教师课程列表页面
    @Value("teaid")
    private String teaId;
    @Value("paging")
    private String padding;
    @Value("teacher/editCourse")
    private String editCourse; // 课程编辑页面
    @Value("utf-8")
    private String encode; // URL编码
    @Value("teacher/courseDetail")
    private String courseDetail; // 课程详情页面

    // 跳转至教师首页
    @RequestMapping("/teacherIndex")
    public String studentIndex() {
        return "teacher/teacherIndex";
    }

    // 跳转至教师信息页面
    @RequestMapping("/teacherInfo")
    public String studentInfo(@RequestParam("teaid") int id, Model model) {
        // 查询教师信息
        model.addAttribute("teacher", userService.getTeaInfoById(id));
        return teacherInfo;
    }

    // 跳转至教师信息修改页面
    @RequestMapping("/editTeaPass")
    public String editTeaPass() {
        return editTeaPass;
    }

    // 教师密码修改
    @RequestMapping("/changeTeaPass")
    public String changPass(@RequestParam("prepass") String prepass, @RequestParam("nowpass") String nowpass, Model model, HttpServletRequest request) {
        int id = (int) request.getSession().getAttribute(teaId); // 获取teaid
        if (userService.checkAccount(id, prepass) == 0) { // 检查原始密码
            model.addAttribute("msg", "原始密码输入错误!");
            return editTeaPass;
        } else { // 原始密码正确, 进入密码修改
            Teacher teacher = new Teacher();
            teacher.setTeaId(id);
            teacher.setTeaPass(nowpass);
            userService.changeTeaPass(teacher);
            // 更新密码后, 获取新的教师用户信息
            model.addAttribute("teacher", userService.getTeaInfoById(id));
            return teacherInfo;
        }
    }

    // 教师课程列表页面
    @RequestMapping("/courseList")
    public String courseList(@Param("page") int page, Model model, HttpServletRequest request) {
        // 使用分页服务查询课程列表
        model.addAttribute(padding, pageService.subList(page, courseService.queryAllByTId((int) request.getSession().getAttribute(teaId))));
        return courseList;
    }

    // 跳转至添加教师课程页面
    @RequestMapping("/insertCourse")
    public String insertCourse(Model model) {
        model.addAttribute("insList", courseService.queryAllIns());
        return "teacher/insertCourse";
    }

    // 课程信息编辑
    @RequestMapping("/editCourse")
    public String editCourse(@Param("courseid") int courseid, Model model) {
        model.addAttribute("courseInfo", courseService.queryInfoById(courseid));
        model.addAttribute("checkIns", courseService.selectCourseLimit(courseid));
        model.addAttribute("insList", courseService.queryAllIns());
        // 跳转至课程信息编辑页面
        return editCourse;
    }

    // 添加课程页面
    @RequestMapping("/insertCourseSuccess")
    public String insertCourseSuccess(@Param("content") String content, @Param("page") int page, Model model, HttpServletRequest request) throws UnsupportedEncodingException {
        String[] det = URLDecoder.decode(URLDecoder.decode(content, encode), encode).split("\\|");
        //获取插入后的课程编号
        int courseId = courseService.insertCourse(det[0], det[1], (int) request.getSession().getAttribute(teaId));
        courseService.insertInsLimit(det[2], courseId);
        model.addAttribute(padding, pageService.subList(page, courseService.queryAllByTId((int) request.getSession().getAttribute(teaId))));
        return courseList;
    }

    // 修改课程信息
    @RequestMapping("/updateCourseSuccess")
    public String updateCourseSuccess(@Param("content") String content, @Param("page") int page, Model model, HttpServletRequest request) throws UnsupportedEncodingException {
        String[] det = URLDecoder.decode(URLDecoder.decode(content, encode), encode).split("\\|");
        int courseId = courseService.updateCourse(det[0], det[1], (int) request.getSession().getAttribute(teaId), det[3]);
        courseService.updateInsLimit(det[2], courseId);
        model.addAttribute(padding, pageService.subList(page, courseService.queryAllByTId((int) request.getSession().getAttribute(teaId))));
        return courseList;
    }

    // 删除课程信息
    @RequestMapping("/deleteCourse")
    public String deleteCourse(@Param("courseid") int courseid, Model model, HttpServletRequest request) {
        courseService.deleteCourse(courseid);
        model.addAttribute(padding, pageService.subList(1, courseService.queryAllByTId((int) request.getSession().getAttribute(teaId))));
        return courseList;
    }

    // 跳转到课程详情页面
    @RequestMapping("/detailCourse")
    public String detailCourse(@Param("courseid") int courseid, @Param("page") int page, Model model) {
        model.addAttribute(padding, pageService.subList(page, courseService.queryStuByCourseId(courseid)));
        return courseDetail;
    }

    // 修改成绩
    @RequestMapping("/updateScore")
    public String updateScore(@Param("courseid") int courseid, @Param("stuId") int stuId, @Param("score") int score, @Param("page") Integer page, Model model) {
        courseService.updateScore(courseid, stuId, score);
        model.addAttribute(padding, pageService.subList(page, courseService.queryStuByCourseId(courseid)));
        return courseDetail;
    }
    // 搜索学生
    @RequestMapping("/searchStu")
    public String searchStu(@Param("stuid") int stuid, @Param("courseid") int courseid, Model model) {
        int page = 1;
        model.addAttribute(padding, pageService.subList(page, courseService.queryStuByStuId(courseid, stuid)));
        return courseDetail;
    }

    // 将学生踢出课程
    @RequestMapping("/deleteStuCourse")
    public String deleteStuCourse(@Param("stuid") int stuid, @Param("courseid") int courseid, Model model) {
        courseService.deleteCourseChoose(stuid, courseid);
        model.addAttribute(padding, pageService.subList(1, courseService.queryStuByCourseId(courseid)));
        return courseDetail;
    }
}
