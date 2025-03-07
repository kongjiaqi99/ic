package com.bhg.bhgadmin.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestBody;

import com.bhg.bhgadmin.dto.request.FundTagRequest;
import com.bhg.bhgadmin.dto.response.FundTagResponse;
import com.bhg.bhgadmin.service.FundTagService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
// import io.swagger.annotations.ApiResponse;
// import io.swagger.v3.oas.annotations.Operation;
// import io.swagger.v3.oas.annotations.responses.ApiResponse;
import lombok.AllArgsConstructor;
import lombok.Data;

@RestController
@Data
@AllArgsConstructor
@RequestMapping("beaver-admin/fundtags")
@PreAuthorize("hasAuthority('admin-users')")
@Api(tags = "funds-tag")
@ApiImplicitParams({
    @ApiImplicitParam(name = "token", value = "<token>", required = true, paramType = "header", dataType = "string")
})
public class FundTagController {
    
    private FundTagService fundTagService;
    
    // @Operation(summary = "Get all funds associated with selected tag")
    // @ApiResponse(responseCode = "200")
    @GetMapping("/")
    @ApiOperation(value = "Get all funds associated with selected tags")
    // @ApiResponse(code = 200, message = "OK")
    public ResponseEntity<FundTagResponse> getFundsByTagId(@RequestParam List<Long> ids) {
        
        FundTagResponse response = fundTagService.getFundsByTagIds(ids);
        
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
    
    // @Operation(summary = "Add new funds into selected tag")
    // @ApiResponse(responseCode = "202")
    @PostMapping("/add")
    @ApiOperation(value = "Add new funds into selected tag")
    // @ApiResponse(code = 202, message = "Funds are added")
    public ResponseEntity<Void> addFundsToTag(@RequestBody FundTagRequest entity) {
        
        fundTagService.addFundsToTag(entity);
        
        return new ResponseEntity<>(HttpStatus.ACCEPTED);
    }
    
    @ExceptionHandler(IllegalArgumentException.class)
    public ResponseEntity<String> handleIllegalArgumentException(IllegalArgumentException ex) {
        return ResponseEntity.status(HttpStatus.BAD_REQUEST).body(ex.getMessage());
    }
    
    // @Operation(summary = "Delete selected funds in selected tag")
    // @ApiResponse(responseCode = "202")
    @PostMapping("/delete")
    @ApiOperation(value = "Remove new funds from selected tag")
    // @ApiResponse(code = 202, message = "Funds are removed")
    public ResponseEntity<Void> deleteFund(@RequestBody FundTagRequest entity) {
        
        fundTagService.deleteFunds(entity);
        
        return new ResponseEntity<>(HttpStatus.ACCEPTED);
    }
    
    @GetMapping("/nonTagged")
    @ApiOperation(value = "Get all non tagged funds")
    public ResponseEntity<FundTagResponse> getNonTaggedFunds() {
        
        FundTagResponse response = fundTagService.getAllAvailableFunds();
    
        return new ResponseEntity<>(response, HttpStatus.OK);
    }
    
}
