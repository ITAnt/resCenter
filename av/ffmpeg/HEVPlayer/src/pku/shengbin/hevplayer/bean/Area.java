package pku.shengbin.hevplayer.bean;

import java.util.List;

/**
 * ����
 * @author rpts
 */
public class Area{
	
	private int id;  //����
	private String name;  //����
	private List<Monitor> list; //��������ͷ
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public List<Monitor> getList() {
		return list;
	}
	public void setList(List<Monitor> list) {
		this.list = list;
	}
	@Override
	public String toString() {
		return "Area [id=" + id + ", name=" + name + ", list=" + list + "]";
	}
	
}
