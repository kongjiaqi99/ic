package com.bhg.bhgadmin.share.utils;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.text.DecimalFormat;
import java.text.DecimalFormatSymbols;
import java.text.NumberFormat;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-19 12:38
 **/
public class AmountFormatUtil {

    public static String formatThousandsSeparator(BigDecimal amount) {
        if (amount != null) {
            amount = amount.setScale(2, RoundingMode.HALF_UP);
            DecimalFormat formatter = (DecimalFormat) NumberFormat.getInstance();
            DecimalFormatSymbols symbols = formatter.getDecimalFormatSymbols();
            symbols.setGroupingSeparator(',');
            formatter.setDecimalFormatSymbols(symbols);
            formatter.setMaximumFractionDigits(4);
            return formatter.format(amount);
        }
        return "";
    }
}
