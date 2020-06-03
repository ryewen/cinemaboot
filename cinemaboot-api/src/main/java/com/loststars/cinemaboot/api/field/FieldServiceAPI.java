package com.loststars.cinemaboot.api.field;

import com.loststars.cinemaboot.api.field.model.FieldModel;
import org.mengyun.tcctransaction.api.Compensable;

import java.util.List;

public interface FieldServiceAPI {

    List<FieldModel> listFieldModelsByMovieId(Integer movieId);

    FieldModel getFieldModelById(Integer fieldId);

    @Compensable
    void record(String orderId, Integer fieldId, String seatName, Integer seatId);
}
