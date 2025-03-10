package com.ic.icadmin.share.utils;

import cn.hutool.core.date.DateUtil;
import cn.hutool.core.util.StrUtil;
import cn.hutool.json.JSONUtil;
import com.google.common.collect.Maps;

import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.apache.commons.lang3.tuple.Pair;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.util.*;

@Slf4j
public class OperationLogUtil {
    public static Map<String, Pair<Object, Object>> operationLog(Object newObject, Object oldObject) {
        Class<?> clazz = newObject.getClass();
        log.info("操作日志--->需要记录的类：" + clazz.getName());

        List<Field> fields = new ArrayList<>();
        Class<?> tempClass = clazz;
        while (tempClass != null && !Objects.equals("Object", tempClass.getName())){
            fields.addAll(Arrays.asList(tempClass.getDeclaredFields()));
            tempClass = tempClass.getSuperclass();
        }

        log.info("操作日志--->需要记录的属性：" + fields.toString());

        StringBuilder str = new StringBuilder();
        Map<String, Pair<Object, Object>> result = Maps.newHashMap();
        Set<String> uniqueField = new HashSet<>();
        fields.forEach(field -> {
            if(field.isAnnotationPresent(OperationLog.class)){
                if(!uniqueField.add(field.getName())){
                    return;
                }
                OperationLog operationLogChinese = field.getAnnotation(OperationLog.class);
                String name = operationLogChinese.name();

                try {
                    Method getMethod = getGetMethod(field.getName(), clazz);
                    Object newValue = getMethod.invoke(newObject);
                    Object oldValue = getMethod.invoke(oldObject);

                    if (null == oldValue || StrUtil.isBlank(oldValue.toString())){
                        oldValue = "";
                    }

                    if (null == newValue || StrUtil.isBlank(newValue.toString())){
                        newValue = "";
                    }
                    if(newValue instanceof Date || oldValue instanceof Date) {
                        newValue = newValue instanceof Date ? DateUtil.formatDate((Date) newValue) : newValue;
                        oldValue = oldValue instanceof Date ? DateUtil.formatDate((Date) oldValue) : oldValue;
                    }
                    if(!Objects.equals(newValue.toString(), oldValue.toString())){
                        result.put(name, Pair.of(oldValue, newValue));
                    }
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        });

        log.info("日志结果：" + JSONUtil.toJsonStr(result));

        return result;
    }


    /**
     * 根据属性，获取get方法
     * @param name 属性名
     * @param beanClass 对象
     * @return Method
     */
    public static Method getGetMethod(String name, Class<?> beanClass){
        Method[] m = beanClass.getMethods();
        for (Method method : m) {
            if (("get"+ name.toLowerCase()).equals(method.getName().toLowerCase())) {
                return method;
            }
        }
        return null;
    }
}
