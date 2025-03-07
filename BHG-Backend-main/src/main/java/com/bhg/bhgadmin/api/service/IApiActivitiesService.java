package com.bhg.bhgadmin.api.service;

import com.bhg.bhgadmin.api.dto.request.activities.RecentActivitiesQueryRequest;
import com.bhg.bhgadmin.api.dto.response.activities.RecentActivitiesQueryResponse;
import com.bhg.bhgadmin.dto.CommonResponse;

import java.util.List;

public interface IApiActivitiesService {
    CommonResponse<List<RecentActivitiesQueryResponse>> queryRecentActivities(RecentActivitiesQueryRequest request);
}
