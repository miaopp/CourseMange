package com.mpp.constants;

/**
 * Created by xiang.xu on 2015/4/26.
 */
public enum MajorEnum {
    /*
    error
     */
    ERROR(0, "error"),

    /*
    计算机科学与技术
     */
    CS(101, "计算机科学与技术"),

    /*
    数字媒体
     */
    DMT(102, "数字媒体"),

    /*
    软件工程
     */
    SE(201, "软件工程");

    private int code;
    private String desc;

    MajorEnum(final int code, final String desc) {
        this.code = code;
        this.desc = desc;
    }

    public static MajorEnum getMajor(final int code) {
        for (MajorEnum majorEnum : MajorEnum.values()) {
            if (majorEnum.getCode() == code) {
                return majorEnum;
            }
        }
        return ERROR;
    }

    public int getCode() {
        return code;
    }

    public String getDesc() {
        return desc;
    }
}
