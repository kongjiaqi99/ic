package com.ic.icadmin.entity;

import java.io.Serializable;
import java.util.Objects;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class FundTagId implements Serializable{

    private Long fundId;
    private Long tagId;
    
    @Override
    public boolean equals(Object o) {
        if(this == o) {
            return true;
        } else if(o == null || getClass() != o.getClass()) {
            return false;
        }
        FundTagId fundTagId = (FundTagId) o;
        return Objects.equals(fundId, fundTagId.fundId) && Objects.equals(tagId, fundTagId.tagId);
    }
    
    @Override
    public int hashCode() {
        return Objects.hash(fundId, tagId);
    }

}
