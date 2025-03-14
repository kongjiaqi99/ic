package com.ic.icadmin.api.client;

import com.ic.icadmin.api.dto.request.activities.RecentActivitiesQueryRequest;
import com.ic.icadmin.api.dto.response.activities.RecentActivitiesQueryResponse;
import com.ic.icadmin.dto.CommonResponse;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

@RequestMapping(path = "api/v1/activities")
@Api(tags = "API-infos-Recent-activities")
public interface IActivitiesClient {

    @PostMapping("/recent-activities")
    @ApiOperation(value = "recent-activities", notes = "查询Recent Activities")
    CommonResponse<List<RecentActivitiesQueryResponse>> queryRecentActivities(@RequestBody
                                                                                  RecentActivitiesQueryRequest request);

}
