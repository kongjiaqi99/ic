package com.ic.icadmin.api.controller;

import com.ic.icadmin.api.client.IActivitiesClient;
import com.ic.icadmin.api.dto.request.activities.RecentActivitiesQueryRequest;
import com.ic.icadmin.api.dto.response.activities.RecentActivitiesQueryResponse;
import com.ic.icadmin.api.service.IApiActivitiesService;
import com.ic.icadmin.controller.BaseController;
import com.ic.icadmin.dto.CommonResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @program: ic-admin
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
