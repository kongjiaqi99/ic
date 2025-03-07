package com.ic.icadmin.api.dto.request;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

import java.util.List;

/**
 * @program: ic-admin
 * @description:
 * @author: Jason.Wu1
 * @create: 2022-11-21 11:21
 **/
@Data
@ApiModel(value = "ApplicationFormRequest", description = "ApplicationFormRequest")
public class ApplicationFormRequest {

    @ApiModelProperty(value = "entityId")
    Long entityId;

    @ApiModelProperty(value = "iCheck")
    boolean iCheck;

    @ApiModelProperty(value = "jhCheck")
    boolean jhCheck;
    @ApiModelProperty(value = "cCheck")
    boolean cCheck;
    @ApiModelProperty(value = "ftiCheck")
    boolean ftiCheck;
    @ApiModelProperty(value = "ftcCheck")
    boolean ftcCheck;
    @ApiModelProperty(value = "sfiCheck")
    boolean sfiCheck;
    @ApiModelProperty(value = "sfcCheck")
    boolean sfcCheck;
    @ApiModelProperty(value = "tiCheck")
    boolean tiCheck;
    @ApiModelProperty(value = "tcCheck")
    boolean tcCheck;
    @ApiModelProperty(value = "caCheck")
    boolean caCheck;
    @ApiModelProperty(value = "cbCheck")
    boolean cbCheck;
    @ApiModelProperty(value = "taCheck")
    boolean taCheck;
    @ApiModelProperty(value = "acn")
    String acn;
    @ApiModelProperty(value = "abn")
    String abn;
    @ApiModelProperty(value = "trustAbn")
    String trustAbn;
    @ApiModelProperty(value = "address")
    String address;
    @ApiModelProperty(value = "fullName")
    String fullName;
    @ApiModelProperty(value = "contactName")
    String contactName;
    @ApiModelProperty(value = "workTel")
    String workTel;
    @ApiModelProperty(value = "homeTel")
    String homeTel;
    @ApiModelProperty(value = "faNo")
    String faNo;
    @ApiModelProperty(value = "mobile")
    String mobile;
    @ApiModelProperty(value = "email")
    String email;
    @ApiModelProperty(value = "birthday")
    String birthday;
    @ApiModelProperty(value = "TFN")
    String TFN;
    @ApiModelProperty(value = "amount")
    String amount;
    @ApiModelProperty(value = "units")
    String units;
    @ApiModelProperty(value = "geCheck")
    boolean geCheck;
    @ApiModelProperty(value = "igCheck")
    boolean igCheck;
    @ApiModelProperty(value = "baCheck")
    boolean baCheck;
    @ApiModelProperty(value = "ssCheck")
    boolean ssCheck;
    @ApiModelProperty(value = "fiCheck")
    boolean fiCheck;
    @ApiModelProperty(value = "otherCheck")
    boolean otherCheck;
    @ApiModelProperty(value = "otherDesc")
    String otherDesc;
    @ApiModelProperty(value = "faName")
    String faName;
    @ApiModelProperty(value = "bAddress")
    String bAddress;
    @ApiModelProperty(value = "accountName")
    String accountName;
    @ApiModelProperty(value = "bsb")
    String bsb;
    @ApiModelProperty(value = "account")
    String account;
    @ApiModelProperty(value = "taxResidency")
    String taxResidency;
    @ApiModelProperty(value = "iSignature")
    String iSignature;
    @ApiModelProperty(value = "iSignatureTwo")
    String iSignatureTwo;
    @ApiModelProperty(value = "cSignature")
    String cSignature;
    @ApiModelProperty(value = "cSignatureTwo")
    String cSignatureTwo;
    @ApiModelProperty(value = "executed")
    String executed;
    @ApiModelProperty(value = "tName")
    String tName;
    @ApiModelProperty(value = "tSignature")
    String tSignature;
    @ApiModelProperty(value = "tSignatureTwo")
    String tSignatureTwo;
    @ApiModelProperty(value = "tSignatureThree")
    String tSignatureThree;
    @ApiModelProperty(value = "attorney")
    String attorney;
    @ApiModelProperty(value = "iSignatureThree")
    String iSignatureThree;
    @ApiModelProperty(value = "tNameThree")
    String tNameThree;
    @ApiModelProperty(value = "tSignatureFour")
    String tSignatureFour;
}
