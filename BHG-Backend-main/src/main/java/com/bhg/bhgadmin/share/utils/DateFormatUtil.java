package com.bhg.bhgadmin.share.utils;

import cn.hutool.core.date.DatePattern;
import cn.hutool.core.date.DateUtil;
import cn.hutool.core.date.format.FastDateFormat;
import com.baomidou.mybatisplus.core.toolkit.ObjectUtils;

import java.time.Instant;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.ZoneId;
import java.time.format.DateTimeFormatter;
import java.time.temporal.ChronoUnit;
import java.time.temporal.TemporalAdjusters;
import java.util.Date;
import java.util.Locale;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-09 15:39
 **/
public class DateFormatUtil {

    private static DateTimeFormatter MMM_YYYY_FORMATTER =  DateTimeFormatter.ofPattern("MMM, yyyy", Locale.US).withZone(ZoneId.systemDefault());;

    public static String getMMMddyyyy(Date date) {
        if (ObjectUtils.isNull(date)){
            return null;
        }
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy";
        try {
            return DateUtil.format(date, FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public static String getMMMYyyy(LocalDate date) {
        if (ObjectUtils.isNull(date)){
            return null;
        }
        try {
            return date.format(MMM_YYYY_FORMATTER);
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public static String getDdMMMyyyy(Date date) {
        if (ObjectUtils.isNull(date)){
            return null;
        }
        String DATE_FORMAT_PATTERN = "dd MMM yyyy";
        try {
            return DateUtil.format(date, FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public static String getDdMmYyyy(Date date) {
        if (ObjectUtils.isNull(date)){
            return null;
        }
        String DATE_FORMAT_PATTERN = "dd-MM-yyyy";
        try {
            return DateUtil.format(date, FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    public static String getMHHmm(Date date) {
        if (ObjectUtils.isNull(date)){
            return null;
        }
        String DATE_FORMAT_PATTERN = "MMM dd, yyyy HH:mm";
        try {
            return DateUtil.format(date, FastDateFormat.getInstance(DATE_FORMAT_PATTERN, Locale.US));
        } catch (Exception e){
            e.printStackTrace();
            return null;
        }
    }

    /**
     * 自定义年月日
     * @param year 年
     * @param month 月
     * @param day 日
     * @return LocalDate
     */
    public static LocalDate getLocalDateByYearAndMonthAndDay(int year , int month , int day){
        LocalDate nowDate = LocalDate.now();
        //获取相差年份
        int differYear = year -  nowDate.getYear();
        int differMonth = differYear * 12 +  month - nowDate.getMonthValue();
        //设置成当前月的第一天
        LocalDate tempDate = nowDate.plusMonths(differMonth).with(TemporalAdjusters.firstDayOfMonth());
        //获取天数
        return tempDate.plusDays(day - 1);
    }


    /**
     * 自定义LocalDateTime
     * @param year 年
     * @param month 月
     * @param day 日
     * @param hour 时
     * @param minute 分
     * @param seconds 秒
     * @return LocalDateTime
     */
    public static LocalDateTime getCustomizeLocalDateTime(Integer year, Integer month, Integer day,
                                                          Integer hour, Integer minute, Integer seconds){
        //获取自定义天
        LocalDate localDate = getLocalDateByYearAndMonthAndDay(year, month, day);
        return localDate.atStartOfDay().plusHours(hour).plusMinutes(minute).plusSeconds(seconds);
    }

    public static Boolean checkTimesHasOverlap(Date dynaStartTime, Date dynaEndTime, Date fixedStartTime, Date fixedEndTime){
        if (dynaStartTime != null && dynaEndTime != null && fixedStartTime != null && fixedStartTime != null) {
            if (dynaStartTime.getTime() >= fixedStartTime.getTime() && dynaEndTime.getTime() <= fixedEndTime.getTime()){
                return true;
            } else if (dynaStartTime.getTime() <= fixedStartTime.getTime() && dynaEndTime.getTime() >= fixedStartTime.getTime() && dynaEndTime.getTime() <= fixedEndTime.getTime()) {
                return true;
            } else if (dynaStartTime.getTime() >= fixedStartTime.getTime() && dynaStartTime.getTime() <= fixedEndTime.getTime() && fixedEndTime.getTime() <= dynaEndTime.getTime()) {
                return true;
            } else if (dynaStartTime.getTime() <= fixedStartTime.getTime() && dynaEndTime.getTime() >= fixedEndTime.getTime()) {
                return true;
            }
        }
        return false;
    }

    public static Integer getRemainSecondsOneDay(Date currentDate) {
        //使用plusDays加传入的时间加1天，将时分秒设置成0
        LocalDateTime midnight = LocalDateTime.ofInstant(currentDate.toInstant(),
                        ZoneId.systemDefault()).plusDays(1).withHour(0).withMinute(0)
                .withSecond(0).withNano(0);
        LocalDateTime currentDateTime = LocalDateTime.ofInstant(currentDate.toInstant(),
                ZoneId.systemDefault());
        //使用ChronoUnit.SECONDS.between方法，传入两个LocalDateTime对象即可得到相差的秒数
        long seconds = ChronoUnit.SECONDS.between(currentDateTime, midnight);
        return (int) seconds;
    }

    public static long betweenDay(Date beginDate, Date endDate, boolean isReset) {
        Instant instant = beginDate.toInstant(); // 将Date转换为Instant
        Instant instant2 = endDate.toInstant(); // 将Date转换为Instant
        ZoneId zoneId = ZoneId.systemDefault(); // 获取系统默认时区
        LocalDate localDate = instant.atZone(zoneId).toLocalDate(); // 转换为LocalDat
        LocalDate localDate2 = instant2.atZone(zoneId).toLocalDate(); // 转换为LocalDat
        if (localDate2.isBefore(localDate)) {
            return ChronoUnit.DAYS.between(localDate2, localDate);
        }
        return ChronoUnit.DAYS.between(localDate, localDate2);
    }
}
