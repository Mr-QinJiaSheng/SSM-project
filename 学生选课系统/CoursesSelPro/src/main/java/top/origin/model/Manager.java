package top.origin.model;

public class Manager {
    private int mId;
    private String mName;
    private String mPass;

    public int getmId() {
        return mId;
    }

    public void setmId(int mId) {
        this.mId = mId;
    }

    public String getmName() {
        return mName;
    }

    public void setmName(String mName) {
        this.mName = mName;
    }

    public String getmPass() {
        return mPass;
    }

    public void setmPass(String mPass) {
        this.mPass = mPass;
    }

    @Override
    public String toString() {
        return "Manager [mId=" + mId + ", mName=" + mName + ", mPass=" + mPass + "]";
    }

}
