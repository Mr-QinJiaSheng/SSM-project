package top.origin.model;

import java.util.List;

public class Course {
    private int classId;
    private String className;
    private int classNum;
    private int teaId;
    private String teaName;
    private int classChooseNum;
    private List<String> classLimitInsName;
    private int score;
    private int isChoose;

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public int getClassNum() {
        return classNum;
    }

    public void setClassNum(int classNum) {
        this.classNum = classNum;
    }

    public int getTeaId() {
        return teaId;
    }

    public void setTeaId(int teaId) {
        this.teaId = teaId;
    }

    public int getClassChooseNum() {
        return classChooseNum;
    }

    public void setClassChooseNum(int classChooseNum) {
        this.classChooseNum = classChooseNum;
    }

    public List<String> getClassLimitInsName() {
        return classLimitInsName;
    }

    public void setClassLimitInsName(List<String> classLimitInsName) {
        this.classLimitInsName = classLimitInsName;
    }

    public String getTeaName() {
        return teaName;
    }

    public void setTeaName(String teaName) {
        this.teaName = teaName;
    }

    public int getIsChoose() {
        return isChoose;
    }

    public void setIsChoose(int isChoose) {
        this.isChoose = isChoose;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }
}

