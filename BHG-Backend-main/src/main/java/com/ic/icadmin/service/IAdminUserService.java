package com.ic.icadmin.service;

import com.ic.icadmin.dto.request.admin.AdminUserCreateRequest;
import com.ic.icadmin.dto.request.admin.AdminUserDelRequest;
import com.ic.icadmin.dto.request.admin.AdminUserDetailRequest;
import com.ic.icadmin.dto.request.admin.AdminUserEditRequest;
import com.ic.icadmin.dto.request.admin.AdminLoginRequest;
import com.ic.icadmin.dto.CommonResponse;
import com.ic.icadmin.dto.request.admin.AdminUserQueryRequest;
import com.ic.icadmin.dto.request.admin.ResetPwdFromEmailRequest;
import com.ic.icadmin.dto.request.admin.SendResetAdminPasswordRequest;
import com.ic.icadmin.dto.response.AdminLoginResponse;
import com.ic.icadmin.dto.response.admin.AdminUsersDetailResponse;
import com.ic.icadmin.dto.response.admin.AdminUsersEditDetailResponse;
import com.ic.icadmin.dto.response.admin.AdminUsersExportDTO;
import com.ic.icadmin.dto.response.admin.AdminUsersResponse;
import com.ic.icadmin.dto.response.admin.RoleResponse;
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
