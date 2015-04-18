package com.mpp.constants;

/**
 * Created by xiang.xu on 2015/4/16.
 */
public enum ScheduleStateEnum {
    /*
    error
     */
    ERROR(-1),
    /*
    未申请
     */
    EMPTY(0),
    /*
    已申请，待审批
     */
    APPLY(1),
    /*
    已审批
     */
    APPROVAL(2);

    private int code;

    private ScheduleStateEnum(final int code) {
        this.code = code;
    }

    public static ScheduleStateEnum getState(final int code) {
        for (ScheduleStateEnum scheduleStateEnum : ScheduleStateEnum.values()) {
            if (code == scheduleStateEnum.getCode()) {
                return scheduleStateEnum;
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
