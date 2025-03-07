package com.bhg.bhgadmin.controller;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.DictionaryQueryRequest;
import com.bhg.bhgadmin.dto.response.DictionaryResponse;
import com.bhg.bhgadmin.service.IDictionaryService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-19 15:28
 **/
@RestController
@RequestMapping(path = "beaver-admin/dictionary")
@Api(tags = "Dictionary")
public class DictionaryController {

    @Autowired
    private IDictionaryService dictionaryService;

    @PostMapping("/queryDictionary")
    @ApiOperation(value = "queryDictionary", notes = "queryDictionary")
    CommonResponse<List<DictionaryResponse>> queryDictionary(@RequestBody @Validated DictionaryQueryRequest request){
        return CommonResponse.success(dictionaryService.queryDictionaryByType(request));
    };
}
