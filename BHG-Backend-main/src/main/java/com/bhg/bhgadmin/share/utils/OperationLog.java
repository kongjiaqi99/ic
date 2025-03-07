package com.bhg.bhgadmin.share.utils;

import java.lang.annotation.*;

@Target({ElementType.METHOD, ElementType.FIELD})
@Retention(RetentionPolicy.RUNTIME)
@Documented
public @interface OperationLog {
    String name() default "";
}
