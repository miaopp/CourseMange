package com.mpp.constants;

/**
 * Created by xiang.xu on 2015/4/6.
 */
public interface CodeMessage {
    public static final int OK = 0;
    public static final int SYSTEM_ERROR = -1;

    int getStatus();

    String getMessage();

    Object getData();
}
