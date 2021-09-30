package top.origin.model;

//选课表
public class Course_choose {
    private int chooseId;
    private int stuId;
    private int classId;
    private int score;

    public int getStuId() {
        return stuId;
    }

    public void setStuId(int stuId) {
        this.stuId = stuId;
    }

    public int getClassId() {
        return classId;
    }

    public void setClassId(int classId) {
        this.classId = classId;
    }

    public int getChooseId() {
        return chooseId;
    }

    public void setChooseId(int chooseId) {
        this.chooseId = chooseId;
    }

    public int getScore() {
        return score;
    }

    public void setScore(int score) {
        this.score = score;
    }
}
