package top.origin.model;

public class Student {
    private int stuId;
    private String stuPass;
    private String stuName;
    private int insId;
    private String InsName;
    private int tempScore;
    private String className;


    public String getClassName() {
        return className;
    }

    public void setClassName(String className) {
        this.className = className;
    }

    public int getStuId() {
        return stuId;
    }

    public void setStuId(int stuId) {
        this.stuId = stuId;
    }

    public String getStuPass() {
        return stuPass;
    }

    public void setStuPass(String stuPass) {
        this.stuPass = stuPass;
    }

    public String getStuName() {
        return stuName;
    }

    public void setStuName(String stuName) {
        this.stuName = stuName;
    }

    public String getInsName() {
        return InsName;
    }

    public void setInsName(String insName) {
        InsName = insName;
    }

    public int getInsId() {
        return insId;
    }

    public void setInsId(int insId) {
        this.insId = insId;
    }

    public int getTempScore() {
        return tempScore;
    }

    public void setTempScore(int tempScore) {
        this.tempScore = tempScore;
    }
}
