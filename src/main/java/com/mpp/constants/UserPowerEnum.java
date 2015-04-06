package com.mpp.constants;

/**
 * Created by xiang.xu on 2015/4/6.
 */
public enum UserPowerEnum {
    /*
    error
     */
    ERROR(-1, "error"),
    /*
    student
     */
    STUDENT(0, "./index.jsp"),
    /*
    teacher
     */
    TEACHER(1, "./teacher.jsp"),
    /*
    manager
     */
    MANAGER(2, "./manager.jsp");

    private int code;
    private String dispather;

    UserPowerEnum(final int code, final String dispather) {
        this.code = code;
        this.dispather = dispather;
    }

    public static UserPowerEnum getType(int code) {
        for (UserPowerEnum userPowerEnum : UserPowerEnum.values()) {
            if (userPowerEnum.code == code) {
                return userPowerEnum;
            }
        }
        return ERROR;
    }

    public String getDispather() {
        return dispather;
    }
}
