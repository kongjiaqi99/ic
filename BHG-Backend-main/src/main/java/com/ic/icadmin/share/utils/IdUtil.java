package com.ic.icadmin.share.utils;
/*
package com.ic.bghadmin.share.utils;

import java.net.InetAddress;
import java.net.UnknownHostException;
// ******弃用！！！*******
public class IdUtil {

    public static final long WORKER_ID = ipKeyGenerator();
    private static long sequence;
    private static long lastTimestamp = -1L;

    public static synchronized Long generateId() {
        long currentMillis = currentMillis();
        if (lastTimestamp == currentMillis) {
            sequence = sequence + 1L & 4095L;
            if (sequence == 0L) {
                currentMillis = waitUntilNextTime(currentMillis);
            }
        } else {
            sequence = 0L;
        }

        lastTimestamp = currentMillis;
        long nextId = currentMillis - 1295884800000L << 22 | WORKER_ID << 12 | sequence;
        return nextId;
    }

    private static long waitUntilNextTime(long lastTime) {
        long timestamp;
        for (timestamp = currentMillis(); timestamp <= lastTime; timestamp = currentMillis()) {
        }
        return timestamp;
    }

    private static long ipKeyGenerator() {
        InetAddress address;
        try {
            address = InetAddress.getLocalHost();
        } catch (final UnknownHostException e) {
            throw new IllegalStateException("cannot get localhost address, please check your network!");
        }
        byte[] ipAddressByteArray = address.getAddress();
        return ((long) (((ipAddressByteArray[ipAddressByteArray.length - 2] & 0B11) << Byte.SIZE) + (ipAddressByteArray[ipAddressByteArray.length - 1] & 0xFF)));
    }

    private static long currentMillis() {
        return System.currentTimeMillis();
    }
}*/
