package com.ic.icadmin.share.constants;


public class RedisConstants {

    public static final String ADMIN_USER_LOGIN_INFO = "login:admin:";

    public static final String ADMIN_PASSWORD_RESET_TOKEN = "passwordReset:admin:token:";

    public static final String CLIENT_LOGIN_INFO = "login:client:";

    public static final String CLIENT_PASSWORD_RESET_TOKEN = "passwordReset:client:token:";
    public static final String CLIENT_PIN_RESET_TOKEN = "pinReset:client:token:";
    public static final String CLIENT_REGISTER_TOKEN = "clientRegister:client:token:";
    public static final String CLIENT_VISITOR_TOKEN = "visitor:client:token:";

    public static final String DAILY_COUNTER_PURCHASED_FUND = "counter:daily_purchased";

    public static final String PRODUCT_LIST = ":productList";

    public static final String PRODUCT_DETAIL = ":productDetail:";

    public static final String DAILY_INVESTMENT_GLOBAL = ":daily_investment_global";

    public static final String DAILY_UNIT_CERTIFICATE_POOL_NUM = ":daily_unit_certificate_pool_num";

    public static final String DASHBOARD_INVESTMENT = ":%s-%s-dashboard_investment";

    public static final String MSG_FROM_IP_LIMIT = ":msg_from_ip_limit:";
    public static final String MSG_TO_NUM_LIMIT = ":msg_to_num_limit:";

    public static final String UPLOAD_FROM_IP_LIMIT = ":upload_from_ip_limit:";
}
