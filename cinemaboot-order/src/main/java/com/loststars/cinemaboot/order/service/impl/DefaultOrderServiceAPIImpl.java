package com.loststars.cinemaboot.order.service.impl;

import com.loststars.cinemaboot.api.order.OrderServiceAPI;
import com.loststars.cinemaboot.api.order.model.OrderModel;
import com.loststars.cinemaboot.order.dao.OrderDOMapper;
import com.loststars.cinemaboot.order.dataobject.OrderDO;
import com.loststars.cinemaboot.order.dataobject.OrderDOExample;
import org.joda.time.DateTime;
import org.mengyun.tcctransaction.api.Compensable;
import org.mengyun.tcctransaction.dubbo.context.DubboTransactionContextEditor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Random;

public class DefaultOrderServiceAPIImpl implements OrderServiceAPI {

    @Autowired
    private OrderDOMapper orderDOMapper;

    private static Logger logger = LoggerFactory.getLogger(DefaultOrderServiceAPIImpl.class);

    @Override
    @Transactional
    public boolean createOrder(String orderId, Integer userId, Integer movieId, Integer fieldId, String seatName, BigDecimal cost, Date createTime) {
        OrderModel orderModel = new OrderModel();
        orderModel.setUserId(userId);
        orderModel.setStatus(OrderModel.STATUS_DRAFT);
        orderModel.setSeatName(seatName);
        orderModel.setMovieId(movieId);
        orderModel.setId(orderId);
        orderModel.setCost(cost);

        orderModel.setFieldId(fieldId);
        orderModel.setCreateTime(createTime);

        OrderDO orderDO = new OrderDO();
        BeanUtils.copyProperties(orderModel, orderDO);

        int result = orderDOMapper.insertSelective(orderDO);

        if (result > 0) {
            return true;
        } else {
            return false;
        }
    }

    @Override
    @Compensable(confirmMethod = "confirmRecord", cancelMethod = "cancelRecord", transactionContextEditor = DubboTransactionContextEditor.class)
    @Transactional
    public void record(String orderId) {
        logger.info("DefaultOrderServiceAPIImpl record " + orderId);
        //将draft的订单状态更新为paying
        int result = orderDOMapper.updateStatus(orderId, OrderModel.STATUS_DRAFT, OrderModel.STATUS_PAYING);

        //若失败则抛出异常
        if (result == 0) {
            throw new ArithmeticException("订单状态更新失败");
        }
    }

    @Transactional
    public void confirmRecord(String orderId) {
        logger.info("DefaultOrderServiceAPIImpl confirmRecord " + orderId);
        OrderDOExample example = new OrderDOExample();
        example.createCriteria().andIdEqualTo(orderId);
        List<OrderDO> orderDOs = orderDOMapper.selectByExample(example);

        if (orderDOs.isEmpty()) return;
        OrderDO orderDO = orderDOs.get(0);

        //将paying的订单状态更新为confirmed
        if (orderDO.getStatus().equals(OrderModel.STATUS_PAYING)) {
            orderDOMapper.updateStatus(orderId, OrderModel.STATUS_PAYING, OrderModel.STATUS_CONFIRMED);
        }
    }

    @Transactional
    public void cancelRecord(String orderId) {
        logger.info("DefaultOrderServiceAPIImpl cancelRecord " + orderId);
        //将paying或draft的订单状态更新为cancel
        OrderDOExample example = new OrderDOExample();
        example.createCriteria().andIdEqualTo(orderId);
        List<OrderDO> orderDOs = orderDOMapper.selectByExample(example);

        if (orderDOs.isEmpty()) return;
        OrderDO orderDO = orderDOs.get(0);

        if (orderDO.getStatus().equals(OrderModel.STATUS_DRAFT) || orderDO.getStatus().equals(OrderModel.STATUS_PAYING)) {
            orderDOMapper.updateStatus(orderId, orderDO.getStatus(), OrderModel.STATUS_CANCEL);
        }
    }
}
