package com.phonemarket.entity;
/**
 * ζζΊεε­
 */
import java.io.Serializable;

public class Memory  implements Serializable{
	private Integer memoryId;
	private String memoryName;
	public Integer getMemoryId() {
		return memoryId;
	}
	public void setMemoryId(Integer memoryId) {
		this.memoryId = memoryId;
	}
	public String getMemoryName() {
		return memoryName;
	}
	public void setMemoryName(String memoryName) {
		this.memoryName = memoryName;
	}
}
