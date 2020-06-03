package com.loststars.cinemaboot.movie.service.impl;

import com.loststars.cinemaboot.api.field.model.SeatModel;
import com.loststars.cinemaboot.api.movie.MovieServiceAPI;
import com.loststars.cinemaboot.api.movie.model.MovieModel;
import com.loststars.cinemaboot.movie.dao.MovieDOMapper;
import com.loststars.cinemaboot.movie.dao.SalesLogDOMapper;
import com.loststars.cinemaboot.movie.dataobject.MovieDO;
import com.loststars.cinemaboot.movie.dataobject.SalesLogDO;
import com.loststars.cinemaboot.movie.dataobject.SalesLogDOExample;
import com.loststars.cinemaboot.movie.service.model.SalesLogModel;
import org.mengyun.tcctransaction.api.Compensable;
import org.mengyun.tcctransaction.dubbo.context.DubboTransactionContextEditor;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.stream.Collectors;

public class DefaultMovieServiceAPIImpl implements MovieServiceAPI {

    @Autowired
    private MovieDOMapper movieDOMapper;

    @Autowired
    private SalesLogDOMapper salesLogDOMapper;

    private static Logger logger = LoggerFactory.getLogger(DefaultMovieServiceAPIImpl.class);

    @Override
    public List<MovieModel> listMovieModels() {
        List<MovieDO> movieDOs = movieDOMapper.selectByExample(null);
        List<MovieModel> movieModels = movieDOs.stream().map((movieDO) -> {
            return convertFromMovieDO(movieDO);
        }).collect(Collectors.toList());
        return movieModels;
    }

    @Override
    public MovieModel getMovieModelById(Integer movieId) {
        MovieDO movieDO = movieDOMapper.selectByPrimaryKey(movieId);
        if (movieDO == null) return null;

        return convertFromMovieDO(movieDO);
    }

    @Override
    @Compensable(confirmMethod = "confirmRecord", cancelMethod = "cancelRecord", transactionContextEditor = DubboTransactionContextEditor.class)
    @Transactional
    public void record(String orderId, Integer movieId, Integer sale) {
        logger.info("DefaultMovieServiceAPIImpl record " + orderId);
        //插入一条销量增加流水
        SalesLogModel salesLogModel = new SalesLogModel();
        salesLogModel.setStatus(SalesLogModel.STATUS_DRAFT);
        salesLogModel.setSale(sale);
        salesLogModel.setOrderId(orderId);
        salesLogModel.setMovieId(movieId);

        SalesLogDO salesLogDO = new SalesLogDO();
        BeanUtils.copyProperties(salesLogModel, salesLogDO);

        int result = salesLogDOMapper.insertSelective(salesLogDO);
        //插入成功则增加电影销量
        if (result > 0) {
            movieDOMapper.addSales(movieId, sale);
        } else {
            throw new ArithmeticException("销量流水生成失败");
        }
    }

    @Transactional
    public void confirmRecord(String orderId, Integer movieId, Integer sale) {
        logger.info("DefaultMovieServiceAPIImpl confirmRecord " + orderId);
        //查询销量流水信息
        SalesLogDOExample example = new SalesLogDOExample();
        example.createCriteria().andOrderIdEqualTo(orderId);
        List<SalesLogDO> salesLogDOs = salesLogDOMapper.selectByExample(example);

        if (salesLogDOs.isEmpty()) return;
        SalesLogDO salesLogDO = salesLogDOs.get(0);

        //更新draft的流水状态为confirmed
        if (salesLogDO.getStatus().equals(SalesLogModel.STATUS_DRAFT)) {
            salesLogDOMapper.updateStatus(salesLogDO.getId(), SalesLogModel.STATUS_DRAFT, SalesLogModel.STATUS_CONFIRMED);
        }
    }

    @Transactional
    public void cancelRecord(String orderId, Integer movieId, Integer sale) {
        logger.info("DefaultMovieServiceAPIImpl cancelRecord " + orderId);
        //查询销量流水信息
        SalesLogDOExample example = new SalesLogDOExample();
        example.createCriteria().andOrderIdEqualTo(orderId);
        List<SalesLogDO> salesLogDOs = salesLogDOMapper.selectByExample(example);

        if (salesLogDOs.isEmpty()) return;
        SalesLogDO salesLogDO = salesLogDOs.get(0);

        //更新draft的流水状态为cancel，扣回销量
        if (salesLogDO.getStatus().equals(SalesLogModel.STATUS_DRAFT)) {
            salesLogDOMapper.updateStatus(salesLogDO.getId(), SalesLogModel.STATUS_DRAFT, SalesLogModel.STATUS_CANCEL);
            movieDOMapper.reduceSales(movieId, sale);
        }
    }

    private MovieModel convertFromMovieDO(MovieDO movieDO) {
        MovieModel movieModel = new MovieModel();
        BeanUtils.copyProperties(movieDO, movieModel);
        return movieModel;
    }
}
