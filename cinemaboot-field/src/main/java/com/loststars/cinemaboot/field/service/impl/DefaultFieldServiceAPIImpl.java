package com.loststars.cinemaboot.field.service.impl;

import com.loststars.cinemaboot.api.field.FieldServiceAPI;
import com.loststars.cinemaboot.api.field.model.FieldModel;
import com.loststars.cinemaboot.api.field.model.SeatModel;
import com.loststars.cinemaboot.api.movie.MovieServiceAPI;
import com.loststars.cinemaboot.api.movie.model.MovieModel;
import com.loststars.cinemaboot.field.dao.FieldDOMapper;
import com.loststars.cinemaboot.field.dao.SeatDOMapper;
import com.loststars.cinemaboot.field.dao.SeatLogDOMapper;
import com.loststars.cinemaboot.field.dataobject.*;
import com.loststars.cinemaboot.field.service.model.SeatLogModel;
import org.mengyun.tcctransaction.api.Compensable;
import org.mengyun.tcctransaction.dubbo.context.DubboTransactionContextEditor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

public class DefaultFieldServiceAPIImpl implements FieldServiceAPI {

    @Autowired
    private FieldDOMapper fieldDOMapper;

    @Autowired
    private SeatDOMapper seatDOMapper;

    @Autowired
    private MovieServiceAPI movieServiceAPI;

    @Autowired
    private SeatLogDOMapper seatLogDOMapper;

    private static Logger logger = LoggerFactory.getLogger(DefaultFieldServiceAPIImpl.class);

    @Override
    public List<FieldModel> listFieldModelsByMovieId(Integer movieId) {
        //根据movieId查询对应的field
        FieldDOExample example = new FieldDOExample();
        example.createCriteria().andMovieIdEqualTo(movieId);

        List<FieldDO> fieldDOs = fieldDOMapper.selectByExample(example);

        //根据fieldId查询对应的seat
        return fieldDOs.stream().map((fieldDO) -> {
            FieldModel fieldModel = new FieldModel();
            BeanUtils.copyProperties(fieldDO, fieldModel);

            SeatDOExample seatDOExample = new SeatDOExample();
            seatDOExample.createCriteria().andFieldIdEqualTo(fieldDO.getId());
            List<SeatDO> seatDOs = seatDOMapper.selectByExample(seatDOExample);

            List<SeatModel> seatModels = seatDOs.stream().map((seatDO) -> {
                SeatModel seatModel = new SeatModel();
                BeanUtils.copyProperties(seatDO, seatModel);
                return seatModel;
            }).collect(Collectors.toList());
            fieldModel.setSeatModels(seatModels);
            return fieldModel;
        }).collect(Collectors.toList());
    }

    @Override
    public FieldModel getFieldModelById(Integer fieldId) {
        //根据fieldId查询对应场次信息
        FieldDO fieldDO = fieldDOMapper.selectByPrimaryKey(fieldId);
        if (fieldDO == null) return null;

        FieldModel fieldModel = new FieldModel();
        BeanUtils.copyProperties(fieldDO, fieldModel);

        //根据fieldId查询对应座位信息
        SeatDOExample seatDOExample = new SeatDOExample();
        seatDOExample.createCriteria().andFieldIdEqualTo(fieldId);
        List<SeatDO> seatDOs = seatDOMapper.selectByExample(seatDOExample);

        List<SeatModel> seatModels = seatDOs.stream().map((seatDO) -> {
            SeatModel seatModel = new SeatModel();
            BeanUtils.copyProperties(seatDO, seatModel);
            return seatModel;
        }).collect(Collectors.toList());
        fieldModel.setSeatModels(seatModels);

        //查询影片信息
        MovieModel movieModel = movieServiceAPI.getMovieModelById(fieldDO.getMovieId());
        fieldModel.setMovieModel(movieModel);

        return fieldModel;
    }

    @Override
    @Compensable(confirmMethod = "confirmRecord", cancelMethod = "cancelRecord", transactionContextEditor = DubboTransactionContextEditor.class)
    @Transactional
    public void record(String orderId, Integer fieldId, String seatName, Integer seatId) {
        logger.info("DefaultFieldServiceAPIImpl record " + orderId);
        //插入座位流水
        SeatLogModel seatLogModel = new SeatLogModel();
        seatLogModel.setFieldId(fieldId);
        seatLogModel.setStatus(SeatLogModel.STATUS_DRAFT);
        seatLogModel.setSeatName(seatName);
        seatLogModel.setOrderId(orderId);

        SeatLogDO seatLogDO = new SeatLogDO();
        BeanUtils.copyProperties(seatLogModel, seatLogDO);

        int result = seatLogDOMapper.insertSelective(seatLogDO);

        if (result == 0) throw new ArithmeticException("座位流水插入失败");

        //将座位状态更新为已售出
        SeatDOExample example = new SeatDOExample();
        example.createCriteria().andIdEqualTo(seatId);
        List<SeatDO> seatDOs = seatDOMapper.selectByExample(example);
        if (seatDOs.isEmpty()) throw new ArithmeticException("座位不存在");
        SeatDO seatDO = seatDOs.get(0);

        if (seatDO.getStatus() == SeatModel.STATUS_SALED) throw new ArithmeticException("座位已售出");

        result = seatDOMapper.sellSeat(seatDO);

        if (result == 0) throw new ArithmeticException("座位状态更新失败");
    }

    @Transactional
    public void confirmRecord(String orderId, Integer fieldId, String seatName, Integer seatId) {
        logger.info("DefaultFieldServiceAPIImpl confirmRecowrd " + orderId);
        //根据orderid获取座位流水
        SeatLogDOExample example = new SeatLogDOExample();
        example.createCriteria().andOrderIdEqualTo(orderId);
        List<SeatLogDO> seatLogDOs = seatLogDOMapper.selectByExample(example);
        if (seatLogDOs.isEmpty()) return;
        SeatLogDO seatLogDO = seatLogDOs.get(0);

        //将状态为draft的流水状态更新为confirmed
        if (seatLogDO.getStatus().equals(SeatLogModel.STATUS_DRAFT)) {
            seatLogDOMapper.updateStatus(seatLogDO.getId(), SeatLogModel.STATUS_DRAFT, SeatLogModel.STATUS_CONFIRMED);
        }
    }

    @Transactional
    public void cancelRecord(String orderId, Integer fieldId, String seatName, Integer seatId) {
        logger.info("DefaultFieldServiceAPIImpl cancelRecord " + orderId);
        //根据orderid获取座位流水
        SeatLogDOExample example = new SeatLogDOExample();
        example.createCriteria().andOrderIdEqualTo(orderId);
        List<SeatLogDO> seatLogDOs = seatLogDOMapper.selectByExample(example);
        if (seatLogDOs.isEmpty()) return;
        SeatLogDO seatLogDO = seatLogDOs.get(0);

        //将状态为draft的流水状态更新为cancel，并回补座位状态
        if (seatLogDO.getStatus().equals(SeatLogModel.STATUS_DRAFT)) {
            int result = seatLogDOMapper.updateStatus(seatLogDO.getId(), SeatLogModel.STATUS_DRAFT, SeatLogModel.STATUS_CANCEL);
            if (result == 0) return;
            SeatDOExample seatDOExample = new SeatDOExample();
            seatDOExample.createCriteria().andIdEqualTo(seatId);
            List<SeatDO> seatDOs = seatDOMapper.selectByExample(seatDOExample);
            SeatDO seatDO = seatDOs.get(0);
            seatDOMapper.saveSeat(seatDO);
        }
    }
}
