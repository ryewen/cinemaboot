package com.loststars.cinemaboot.gateway.gateway;

import com.loststars.cinemaboot.api.field.FieldServiceAPI;
import com.loststars.cinemaboot.api.movie.MovieServiceAPI;
import com.loststars.cinemaboot.api.order.OrderServiceAPI;
import com.loststars.cinemaboot.api.user.UserServiceAPI;
import com.loststars.cinemaboot.gateway.controller.OrderController;
import org.mengyun.tcctransaction.api.Compensable;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import java.math.BigDecimal;

@Component
public class OrderGateway {

    @Autowired
    private OrderServiceAPI orderServiceAPI;

    @Autowired
    private FieldServiceAPI fieldServiceAPI;

    @Autowired
    private UserServiceAPI userServiceAPI;

    @Autowired
    private MovieServiceAPI movieServiceAPI;

    private static Logger logger = LoggerFactory.getLogger(OrderGateway.class);

    @Compensable(confirmMethod = "confirmRecord", cancelMethod = "cancelRecord", asyncConfirm = true)
    public boolean record(String orderId, Integer movieId, Integer sale, Integer userId, BigDecimal cost, Integer fieldId, String seatName, Integer seatId) {
        logger.info("OrderGateway record " + orderId);

        orderServiceAPI.record(orderId);

        fieldServiceAPI.record(orderId, fieldId, seatName, seatId);

        userServiceAPI.record(orderId, userId, cost);

        movieServiceAPI.record(orderId, movieId, sale);

        return true;
    }

    public boolean confirmRecord(String orderId, Integer movieId, Integer sale, Integer userId, BigDecimal cost, Integer fieldId, String seatName, Integer seatId) {
        logger.info("OrderGateway confirmRecord " + orderId);
        return true;
    }

    public boolean cancelRecord(String orderId, Integer movieId, Integer sale, Integer userId, BigDecimal cost, Integer fieldId, String seatName, Integer seatId) {
        logger.info("OrderGateway cancelRecord " + orderId);
        return false;
    }
}
