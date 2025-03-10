package com.ic.icadmin.service;

import com.ic.icadmin.dto.request.DictionaryQueryRequest;
import com.ic.icadmin.dto.response.DictionaryResponse;

import java.util.List;

public interface IDictionaryService {

    List<DictionaryResponse> queryDictionaryByType(DictionaryQueryRequest request);
}
