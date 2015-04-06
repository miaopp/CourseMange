package com.mpp.constants;

/**
 * Created by xiang.xu on 2015/4/6.
 */
public class JsonReturn {
    public static CodeMessage getSuccess(final Object obj) {
        return new CodeMessage() {
            @Override
            public int getStatus() {
                return 200;
            }

            @Override
            public String getMessage() {
                return "success";
            }

            @Override
            public Object getData() {
                return obj;
            }
        };
    }

    public static CodeMessage getError(final int code, final String msg){
        return new CodeMessage() {
            @Override
            public int getStatus() {
                return code;
            }

            @Override
            public String getMessage() {
                return msg;
            }

            @Override
            public Object getData() {
                return null;
            }
        };
    }

    public static CodeMessage getError(final String msg){
        return new CodeMessage() {
            @Override
            public int getStatus() {
                return -1;
            }

            @Override
            public String getMessage() {
                return msg;
            }

            @Override
            public Object getData() {
                return null;
            }
        };
    }
}
