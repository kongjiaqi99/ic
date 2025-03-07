package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.request.DictionaryQueryRequest;
import com.bhg.bhgadmin.dto.response.DictionaryResponse;

import java.util.List;

public interface IDictionaryService {

    List<DictionaryResponse> queryDictionaryByType(DictionaryQueryRequest request);
}
