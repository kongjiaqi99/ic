package com.bhg.bhgadmin.controller;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.bind.annotation.RequestBody;

import com.bhg.bhgadmin.dto.request.TagCreateRequestDTO;
import com.bhg.bhgadmin.dto.request.TagRequestDTO;
import com.bhg.bhgadmin.entity.Tags;
import com.bhg.bhgadmin.service.TagService;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import io.swagger.annotations.ApiResponses;
import io.swagger.annotations.ApiResponse;
// import io.swagger.v3.oas.annotations.Operation;
// import io.swagger.v3.oas.annotations.responses.ApiResponse;
// import io.swagger.v3.oas.annotations.responses.ApiResponses;
import lombok.AllArgsConstructor;
import lombok.Data;

@RestController
@Data
@AllArgsConstructor
@RequestMapping("beaver-admin/tags")
@Api(tags = "tags")
@ApiImplicitParams({
    @ApiImplicitParam(name = "token", value = "<token>", required = true, paramType = "header", dataType = "string")
})
public class TagController {
    private TagService tagService;
    
    // @Operation(summary = "Get all tags")
    // @ApiResponses(value = {
    //     @ApiResponse(responseCode = "200", description = "All tags retrieved"),
    // })
    @GetMapping("/")
    @PreAuthorize("hasAuthority('admin-users')")
    @ApiOperation(value = "Get all tags", notes = "Retrieve all tags with an authorization token")
    // @ApiResponses(value = {
    //     @ApiResponse(code = 200, message = "All tags retrieved"),
    //     @ApiResponse(code = 401, message = "Unauthorized - Token is missing or invalid")
    // })
    public ResponseEntity<List<Tags>> getAllTags() {
        List<Tags> tags = tagService.findAll();
        return new ResponseEntity<>(tags, HttpStatus.OK);
    }
    
    // @Operation(summary = "Get selected tag details")
    // @ApiResponses(value = {
    //     @ApiResponse(responseCode = "200"),
    // })
    @GetMapping("/detail")
    @PreAuthorize("hasAuthority('admin-users')")
    @ApiOperation(value = "Get selected tag details", notes = "Retrieve selected tag's info with an authorization token")
    public ResponseEntity<Tags> getTagById(@RequestParam Long id) {
        Tags tag = tagService.getTagById(id);
        return new ResponseEntity<>(tag, HttpStatus.OK);
    }
    
    // @Operation(summary = "Create a new tag")
    // @ApiResponses(value = {
    //     @ApiResponse(responseCode = "201"),
    // })
    @PostMapping("/create")
    @PreAuthorize("hasAuthority('admin-users')")
    @ApiOperation(value = "Create a new tag")
    // @ApiResponse(code = 201, message = "Tag is created")
    public ResponseEntity<Void> createTag(@RequestBody TagCreateRequestDTO tag) {
        tagService.saveTag(tag);
        return new ResponseEntity<>(HttpStatus.CREATED);
    }
    
    // @Operation(summary = "Update a tag")
    // @ApiResponses(value = {
    //     @ApiResponse(responseCode = "202"),
    // })
    @PostMapping("/update")
    @PreAuthorize("hasAuthority('admin-users')")
    @ApiOperation(value = "Update selected tag")
    // @ApiResponse(code = 202, message = "Tag is updated")
    public ResponseEntity<Void> updateTag(@RequestBody TagRequestDTO tag) {
        tagService.updateTag(tag);
        return new ResponseEntity<>(HttpStatus.ACCEPTED);
    }
    
    // @Operation(summary = "Delete a tag")
    // @ApiResponse(responseCode = "202")
    @PostMapping("/delete")
    @PreAuthorize("hasAuthority('admin-users')")
    @ApiOperation(value = "Delete a new tag")
    // @ApiResponse(code = 202, message = "Tag is deleted")
    public ResponseEntity<Void> deleteTag(@RequestParam Long id) {
        tagService.deleteTagById(id);
        return new ResponseEntity<>(HttpStatus.ACCEPTED);
    }
}
