package com.bhg.bhgadmin.service;

import com.bhg.bhgadmin.dto.request.admin.AdminUserCreateRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserDelRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserDetailRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminUserEditRequest;
import com.bhg.bhgadmin.dto.request.admin.AdminLoginRequest;
import com.bhg.bhgadmin.dto.CommonResponse;
import com.bhg.bhgadmin.dto.request.admin.AdminUserQueryRequest;
import com.bhg.bhgadmin.dto.request.admin.ResetPwdFromEmailRequest;
import com.bhg.bhgadmin.dto.request.admin.SendResetAdminPasswordRequest;
import com.bhg.bhgadmin.dto.response.AdminLoginResponse;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersDetailResponse;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersEditDetailResponse;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersExportDTO;
import com.bhg.bhgadmin.dto.response.admin.AdminUsersResponse;
import com.bhg.bhgadmin.dto.response.admin.RoleResponse;
import com.github.pagehelper.PageInfo;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public interface IAdminUserService {

    /**
     * Admin user login
     * @param request
     * @return
     */
    CommonResponse<AdminLoginResponse> adminLogin(AdminLoginRequest request, HttpServletRequest servletRequest);

    /**
     * Admin user logout
     * @return
     */
    CommonResponse<String> adminLogout();

    /**
     * send reset password email
     * @param request
     * @return
     */
    CommonResponse<Boolean> sendPasswordResetEmail(SendResetAdminPasswordRequest request);

    /**
     * reset Pwd from Email
     * @param request
     * @return
     */
    CommonResponse<Integer> resetPwdFromEmail(ResetPwdFromEmailRequest request);

    CommonResponse<PageInfo<AdminUsersResponse>> queryAdminUsers(AdminUserQueryRequest request, int pageNum, int pageSize);

    CommonResponse<Long> createAdminUser(AdminUserCreateRequest request);

    CommonResponse<AdminUsersDetailResponse> queryAdminById(AdminUserDetailRequest request);

    CommonResponse<AdminUsersEditDetailResponse> queryAdminByIdWhenEdit(AdminUserDetailRequest request);

    CommonResponse<Long> editAdmin(AdminUserEditRequest request);

    CommonResponse<Integer> delAdmin(AdminUserDelRequest request);

    void exportAdminUsersCsv(AdminUserQueryRequest request, HttpServletResponse response) throws IOException;

    List<AdminUsersExportDTO> exportAdminUsersXml(AdminUserQueryRequest request);

    CommonResponse<List<RoleResponse>> queryRoles();
}
