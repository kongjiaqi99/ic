package com.bhg.bhgadmin.controller;

import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.admin.AdminUserCreateRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserDelRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserDetailRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserEditRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminLoginRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserQueryRequest;
import com.bhg.bhgadmin.dto.request.admin.ResetPwdFromEmailRequest;
import com.bhg.bhgadmin.dto.request.admin.SendResetAdminPasswordRequest;
import com.bhg.bhgadmin.dto.response.AdminLoginResponse;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersDetailResponse;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersEditDetailResponse;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersResponse;
import com.bhg.bhgadmin.dto.response.admin.ListAdminUsersExportDTO;
import com.bhg.bhgadmin.dto.response.admin.RoleResponse;
import com.bhg.bhgadmin.service.IAdminUserService;
import com.github.pagehelper.PageInfo;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiModelProperty;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

/**
 * @program: bhg-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-05 23:18
 **/
@RestController
@RequestMapping(path = "beaver-admin/admin-users")
@Api(tags = "Admin-User")
public class AdminUsersController {

    @Autowired
    private IAdminUserService adminUserService;

    @PostMapping("/login")
    @ApiOperation(value = "Admin-Login", notes = "Admin-Login")
    CommonResponse<AdminLoginResponse> adminLogin(@RequestBody @Validated
                                                      AdminLoginRequest request, HttpServletRequest servletRequest) {
        return adminUserService.adminLogin(request, servletRequest);
    }

    @PostMapping("/logout")
    @ApiOperation(value = "Admin-Logout", notes = "Admin-Logout")
    CommonResponse<String> adminLogout(){
        return adminUserService.adminLogout();
    }

    @PostMapping("/sendPasswordResetEmail")
    @ApiOperation(value = "SendResetAdminPassword", notes = "SendResetAdminPassword")
    CommonResponse<Boolean> sendPasswordResetEmail(@RequestBody @Validated SendResetAdminPasswordRequest request){
        return adminUserService.sendPasswordResetEmail(request);
    }

    @PostMapping("/resetPwdFromEmail")
    @ApiOperation(value = "resetPwdFromEmail", notes = "resetPwdFromEmail")
    CommonResponse<Integer> resetPwdFromEmail(@RequestBody ResetPwdFromEmailRequest request){
        return adminUserService.resetPwdFromEmail(request);
    }

    @PreAuthorize("hasAuthority('admin-users')")
    @PostMapping("/queryAdminUsers")
    @ApiOperation(value = "queryAdminUsers", notes = "query Admin Users")
    CommonResponse<PageInfo<AdminUsersResponse>> queryAdminUsers(@RequestBody AdminUserQueryRequest request,
                                                                 int pageNum, int pageSize){
        return adminUserService.queryAdminUsers(request, pageNum, pageSize);
    }

    @PreAuthorize("hasAuthority('admin-users')")
    @PostMapping("/createAdminUser")
    @ApiOperation(value = "createAdminUser", notes = "create Admin Users")
    CommonResponse<Long> createAdminUser(@RequestBody @Validated AdminUserCreateRequest request){
        return adminUserService.createAdminUser(request);
    }

    @PreAuthorize("hasAuthority('admin-users')")
    @PostMapping("/queryAdminById")
    @ApiOperation(value = "queryAdminById", notes = "query Admin Users by Id")
    CommonResponse<AdminUsersDetailResponse> queryAdminById(@RequestBody AdminUserDetailRequest request){
        return adminUserService.queryAdminById(request);
    }

    @PreAuthorize("hasAuthority('admin-users')")
    @PostMapping("/queryAdminByIdWhenEdit")
    @ApiOperation(value = "queryAdminByIdWhenEdit", notes = "query Admin Users by Id When edit")
    CommonResponse<AdminUsersEditDetailResponse> queryAdminByIdWhenEdit(@RequestBody AdminUserDetailRequest request){
        return adminUserService.queryAdminByIdWhenEdit(request);
    }

    @PreAuthorize("hasAuthority('admin-users')")
    @PostMapping("/editAdmin")
    @ApiOperation(value = "editAdmin", notes = "edit Admin Users")
    CommonResponse<Long> editAdmin(@RequestBody @Validated AdminUserEditRequest request){
        return adminUserService.editAdmin(request);
    }

    @PreAuthorize("hasAuthority('admin-users')")
    @PostMapping("/delAdmin")
    @ApiOperation(value = "delAdmin", notes = "delete Admin Users")
    CommonResponse<Integer> delAdmin(@RequestBody AdminUserDelRequest request){
        return adminUserService.delAdmin(request);
    }

    @PreAuthorize("hasAuthority('admin-users')")
    @GetMapping("/exportAdminUsersCsv")
    @ApiModelProperty(value = "exportAdminUsersCsv", notes = "export Admin Users Csv")
    void exportAdminUsersCsv(@RequestParam(required = false, value = "adminUserEmail") String adminUserEmail,
                             @RequestParam(required = false, value = "filterType") Integer filterType,
                             HttpServletResponse response) throws IOException {
        AdminUserQueryRequest request = new AdminUserQueryRequest();
        request.setAdminUserEmail(adminUserEmail);
        request.setFilterType(filterType);
        adminUserService.exportAdminUsersCsv(request, response);
    }

    @GetMapping(value = "/exportXml", produces = MediaType.APPLICATION_XML_VALUE)
    @ApiModelProperty(value = "exportAdminUsersXml", notes = "export Admin Users Xml")
    ListAdminUsersExportDTO exportAdminUsersXml(@RequestParam(required = false, value = "adminUserEmail") String adminUserEmail,
                                                @RequestParam(required = false, value = "filterType") Integer filterType){
        AdminUserQueryRequest request = new AdminUserQueryRequest();
        request.setAdminUserEmail(adminUserEmail);
        request.setFilterType(filterType);
        ListAdminUsersExportDTO response = new ListAdminUsersExportDTO(adminUserService.exportAdminUsersXml(request));
        return response;
    }

    @GetMapping(value = "/exportJson", produces = MediaType.APPLICATION_JSON_VALUE)
    @ApiModelProperty(value = "exportAdminUsersJson", notes = "export Admin Users Json")
    ListAdminUsersExportDTO exportAdminUsersJson(@RequestParam(required = false, value = "adminUserEmail") String adminUserEmail,
                                                @RequestParam(required = false, value = "filterType") Integer filterType){
        AdminUserQueryRequest request = new AdminUserQueryRequest();
        request.setAdminUserEmail(adminUserEmail);
        request.setFilterType(filterType);
        ListAdminUsersExportDTO response = new ListAdminUsersExportDTO(adminUserService.exportAdminUsersXml(request));
        return response;
    }

    @PreAuthorize("hasAuthority('admin-users')")
    @PostMapping("/queryRoles")
    @ApiOperation(value = "queryRoles", notes = "query Roles")
    CommonResponse<List<RoleResponse>> queryRoles(){
        return adminUserService.queryRoles();
    }
}
