package com.loststars.cinemaboot.api.order;

import org.mengyun.tcctransaction.api.Compensable;

import java.math.BigDecimal;
import java.util.Date;

public interface OrderServiceAPI {

    boolean createOrder(String orderId, Integer userId, Integer movieId, Integer fieldId, String seatName, BigDecimal cost, Date createTime);

    @Compensable
    void record(String orderId);
}
