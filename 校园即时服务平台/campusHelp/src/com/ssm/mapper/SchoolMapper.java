package com.ssm.mapper;

import java.util.List;

import com.ssm.po.School;

public interface SchoolMapper {
    int deleteByPrimaryKey(Integer schoolid);//根据id删除

    int insert(School record);//新增学校

    int insertSelective(School record);//

    School selectByPrimaryKey(Integer schoolid);

    int updateByPrimaryKeySelective(School record);

    int updateByPrimaryKey(School record);
    
    /**
	 * 读取全部
	 * @return
	 */
	public List<School> selectAllSchools();
	
	/**
	 * 读取全部,不含限制的,state=0
	 * @return
	 */
	public List<School> selectAllSchoolsNoState();
}