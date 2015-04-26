package com.mpp.constants;

/**
 * Created by xiang.xu on 2015/4/26.
 */
public enum MajorEnum {
    /*
    error
     */
    ERROR(0),

    /*
    计算机科学与技术
     */
    CS(101),

    /*
    数字媒体
     */
    DMT(102),

    /*
    软件工程
     */
    SE(201);

    int code;

    private MajorEnum(final int code) {
        this.code = code;
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

    public void setCode(final int code) {
        this.code = code;
    }
}
