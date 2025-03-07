package com.bhg.bhgadmin.share.constants;


public interface CommonConstants {
    /**
     * http返回码 成功
     */
    String HTTP_RESPONSE_CODE_SUCCESS = "0";

    String HTTP_PREFIX = "http://";
    String HTTPS_PREFIX = "https://";
    String URL_PREFIX = "://";
    String ERRORMESSAGE_PREFIX="error.message.code.";

    interface System{
        Integer HASH_MAP_INIT_SIZE = 16;

        String CHANNEL_ID = "CHANNEL_ID";
        String HTTP_REQUEST_HEADER = "x-forwarded-for";

    }

    interface ExtApi {

        String EXTAPIHEAD = "head";

        String EXTAPIFROM = "from";

    }

    interface Version {

        public static final String STAGED = "staged";

        public static final String ONLINE = "online";

    }

    interface Export{
        String EXPORT_CSV_CLIENTS="clients-";
        String EXPORT_CSV_ADMINS="admin-users-";
        String EXPORT_CSV_ENQUIRIES="enquiries-";
        String EXPORT_CSV_EVENTS="events-";
        String EXPORT_CSV_FUNDS="funds-";
        String EXPORT_CSV_FINANCINGS="financings-";
        String EXPORT_CSV_LOANS="loan-items-";
        String EXPORT_CSV_NEWS="news-";
        String EXPORT_CSV_NEWS_IMGS="news-imgs-";
        String EXPORT_CSV_PURCHASED_FUNDS="purchased-funds";
    }

    interface TokenPrefix{
        String CLIENT_TOKEN_PREFIX = "Beaver-client:";
        String VISITOR_TOKEN_PREFIX = "Beaver-visitor:";
    }
}
