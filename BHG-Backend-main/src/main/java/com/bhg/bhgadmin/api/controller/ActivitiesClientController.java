package com.bhg.bhgadmin.api.controller;

import com.bhg.bhgadmin.api.client.IActivitiesClient;
import com.bhg.bhgadmin.api.dto.request.activities.RecentActivitiesQueryRequest;
import com.bhg.bhgadmin.api.dto.response.activities.RecentActivitiesQueryResponse;
import com.bhg.bhgadmin.api.service.IApiActivitiesService;
import com.bhg.bhgadmin.controller.BaseController;
import com.bhg.bhgadmin.dto.CommonResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu
 * @create: 2023-02-23 13:35
 **/
@RestController
public class ActivitiesClientController extends BaseController implements IActivitiesClient {

    @Autowired
    private IApiActivitiesService activitiesService;

    @Override
    public CommonResponse<List<RecentActivitiesQueryResponse>> queryRecentActivities(RecentActivitiesQueryRequest request) {
        return activitiesService.queryRecentActivities(request);
    }
}
