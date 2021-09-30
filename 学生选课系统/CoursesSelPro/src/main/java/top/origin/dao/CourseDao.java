package top.origin.dao;

import top.origin.model.Course;
import top.origin.model.Course_choose;
import top.origin.model.Course_limit;
import top.origin.model.Institution;

import java.util.List;

public interface CourseDao {
    List<Course> queryCourseById(int id);

    List<Integer> queryInsIdByCourseId(int id);

    String selectNameByInsId(int id);

    List<Institution> queryAllIns();

    void insertCourse(Course course);

    void insertInsLimit(Course_limit course_limit);

    Course queryCourseInfoById(int id);

    List<Integer> selectCourseLimit(int classId);

    void updateCourse(Course course);

    int selectMaxCourseId();

    void updateInsLimit(Course_limit course_limit);

    void deleteInsLimit(int id);

    void deleteCourseById(int id);

    void deleteStuByClassId(int id);

    void deleteLimitByClassId(int id);

    List<Course_choose> queryStuIdByCourseId(int id);

    void updateScore(Course_choose course_choose);

    List<Course> queryAllCourse();

    List<Integer> selectInsIdByClassId(int classId);

    String selectTeaNameByTeaId(int id);

    Course selectCourseByClassId(int id);

    void addChooseNum(int id);

    void addCourseChoose(Course_choose course_choose);

    List<Integer> queryCourseIdByStuId(int id);

    void downChooseNum(int id);

    void deleteCourseChoose(Course_choose course_choose);

    int selectScore(Course_choose course_choose);
}
