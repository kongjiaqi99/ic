package com.ic.icadmin.api.service;

import com.ic.icadmin.api.dto.request.activities.RecentActivitiesQueryRequest;
import com.ic.icadmin.api.dto.response.activities.RecentActivitiesQueryResponse;
import com.ic.icadmin.dto.CommonResponse;

import java.util.List;

public interface IApiActivitiesService {
    CommonResponse<List<RecentActivitiesQueryResponse>> queryRecentActivities(RecentActivitiesQueryRequest request);
}
