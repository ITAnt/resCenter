package pku.shengbin.hevplayer.bean;

import java.util.List;

/**
 * ¥��ʵ����
 * @author rpts
 *
 */
public class Floor{

	private int id;
	private String name;
	private String areaId;  //����Id
	private String buildingId;  //¥Id
	
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public void setBuildingId(String buildingId) {
		this.buildingId = buildingId;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	
	public String getBuildingId() {
		return buildingId;
	}
	public String getAreaId() {
		return areaId;
	}
	public void setAreaId(String areaId) {
		this.areaId = areaId;
	}
	@Override
	public String toString() {
		return "Floor [id=" + id + ", name=" + name + ", areaId=" + areaId
				+ ", buildingId=" + buildingId + "]";
	}
	
	
	
	
	
}
