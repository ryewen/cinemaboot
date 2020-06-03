package com.loststars.cinemaboot.api.movie;

import com.loststars.cinemaboot.api.movie.model.MovieModel;
import org.mengyun.tcctransaction.api.Compensable;

import java.util.List;

public interface MovieServiceAPI {

    List<MovieModel> listMovieModels();

    MovieModel getMovieModelById(Integer movieId);

    @Compensable
    void record(String orderId, Integer movieId, Integer sale);
}
