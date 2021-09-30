package top.origin.controller.common;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.bind.support.SessionStatus;
import top.origin.service.UserService;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * DONE: 登录页面控制器
 */
@Controller
@SessionAttributes({"username", "teaid", "stuid"}) // 将username, teaid, stuid保存在会话中, 达到
public class LoginController {
    /**
     * user服务
     */
    @Resource
    private UserService userService;

    @Value("login")
    private String loginPage; // 登录页面名称

    // 跳转至login页面
    @GetMapping("login")
    public String login() {
        return loginPage;
    }

    /**
     * 检查登录账户
     *
     * @param id    学号
     * @param pass  密码
     * @param model model
     * @return 根据登录用户进行跳转
     */
    @PostMapping(value = "check")
    public String checkAccount(@RequestParam("userid") int id, @RequestParam("userpass") String pass, Model model) {
        // 校验用户信息, 并将正确的用户信息存入会话model
        if (userService.checkAccount(id, pass) == 2) { // 教师角色的处理, 并跳转到教师页面
            model.addAttribute("username", userService.getTeaNameById(id));
            model.addAttribute("teaid", id);
            return "redirect:teacher/teacherIndex";
        } else if (userService.checkAccount(id, pass) == 1) { // 学生角色的处理, 并跳转到学生页面
            model.addAttribute("username", userService.getStuNameById(id));
            model.addAttribute("stuid", id);
            return "redirect:student/studentIndex";
        } else { // 校验不通过, 跳转到登录页面
            model.addAttribute("msg", "密码错误");
            //这里不加redirect，否则前端el取不到值
            return loginPage;
        }
    }

    // 退出登录
    @GetMapping("exit")
    public String exit(HttpServletRequest request, SessionStatus status) {
        status.setComplete(); // 会话结束, 清除当前会话的属性
        request.getSession().invalidate(); // 解除会话绑定
        return loginPage; // 重新跳转到登录页面
    }
}
