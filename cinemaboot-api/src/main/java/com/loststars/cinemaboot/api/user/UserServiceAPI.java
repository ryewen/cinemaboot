package com.loststars.cinemaboot.api.user;

import com.loststars.cinemaboot.api.user.model.UserModel;
import org.mengyun.tcctransaction.api.Compensable;

import java.math.BigDecimal;

public interface UserServiceAPI {

    UserModel getUserModelByUsername(String username);

    UserModel getUserModelByTelephone(String telephone);

    boolean createUser(UserModel userModel);

    BigDecimal getWalletByUserId(Integer userId);

    @Compensable
    void record(String orderId, Integer userId, BigDecimal cost);
}
