package com.mpp.constants;

/**
 * Created by xiang.xu on 2015/4/14.
 */
public enum AcademyEnum {
    /*
    error
     */
    ERROR(-1),

    /*
    计算机学院
     */
    CS(1),

    /*
    软件学院
     */
    SE(2);

    private int code;

    private AcademyEnum(final int code) {
        this.code = code;
    }

    public static AcademyEnum getAcademy(final int code) {
        for (AcademyEnum academyEnum : AcademyEnum.values()) {
            if (code == academyEnum.code) {
                return academyEnum;
            }
        }
        return ERROR;
    }

    public int getCode() {
        return code;
    }

    public void setCode(final int code) {
        this.code = code;
    }
}
