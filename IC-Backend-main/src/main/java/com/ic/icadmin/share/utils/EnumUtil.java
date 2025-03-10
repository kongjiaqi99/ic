package com.ic.icadmin.share.utils;

import cn.hutool.core.util.ObjectUtil;
import com.ic.icadmin.share.enums.CodeEnum;

public class EnumUtil {

    //返回的对象实现CodeEnum接口    
    public static <T extends CodeEnum> T getByCode(Class<T> enumClass, Integer code) {
        for (T each : enumClass.getEnumConstants()) {
            if(each.getCode()==code){
                return each;
            }
        }
        return null;
    }

    public static <T extends CodeEnum> String getEnumMessageByCode(Class<T> enumClass, Integer code) {
        for (T each : enumClass.getEnumConstants()){
            if (ObjectUtil.equals(each.getCode(), code)) {
                return each.getMessage();
            }
        }
        return "";
    }
}
