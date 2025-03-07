package com.bhg.bhgadmin.entity;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.IdClass;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.Table;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Entity
@AllArgsConstructor
@NoArgsConstructor
@Table(name = "fund_tag")
@IdClass(FundTagId.class)
public class FundTag {

    @Id
    @Column(name = "tag_id")
    private Long tagId;
    @Id
    @Column(name = "fund_id")
    private Long fundId;
    
    @ManyToOne
    @JoinColumn(name = "fund_id", insertable = false, updatable = false)
    private FundEntity fund;
    
    @ManyToOne
    @JoinColumn(name = "tag_id", insertable = false, updatable = false)
    private Tags tag;

}
