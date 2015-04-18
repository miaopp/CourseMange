package com.mpp.constants;

/**
 * Created by xiang.xu on 2015/4/18.
 */
public enum OrdersClassEnum {
    ERROR(0,"ERROR"),
    ONE(1, "第一节"),
    TWO(2, "第二节"),
    THREE(3, "第三节"),
    FOUR(4, "第四节"),
    FIVE(5, "第五节"),
    SIX(6, "第六节"),
    SEVEN(7, "第七节"),
    EIGHT(8, "第八节"),
    NINE(9, "第九节"),
    TEN(10, "第十节"),
    ELEVEN(11, "第十一节"),
    TWELVE(12, "第十二节");

    private int code;
    private String desc;

    private OrdersClassEnum(final int code, final String desc) {
        this.code = code;
        this.desc = desc;
    }

    public static OrdersClassEnum getByCode(int code) {
        for (OrdersClassEnum ordersClassEnum : OrdersClassEnum.values()) {
            if (ordersClassEnum.code == code) {
                return ordersClassEnum;
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
