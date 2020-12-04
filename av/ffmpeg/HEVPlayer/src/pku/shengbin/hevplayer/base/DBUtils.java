package pku.shengbin.hevplayer.base;

public class DBUtils {
	public static final String DATABASE_NAME="monitor";  //���ݿ�����
	public static final int DATABASE_VERSION=1;  //���ݿ�汾
	
	public static final String TABLE_NAME_1="area"; //area��
	public static final String AREA_ID="_id";  //����
	public static final String AREA_NAME="name";  //��������
	
	public static final String TABLE_NAME_2="building";  //building��
	public static final String BUILDING_ID="_id";
	public static final String BUILDING_NAME="name";
	public static final String BUILDING_AREA_ID="areaId";
	
	public static final String TABLE_NAME_3="floor";   	//¥��
	public static final String FLOOR_ID="_id";
	public static final String FLOOR_NAME="name";
	public static final String FLOOR_AREA_ID="areaId";
	public static final String FLOOR_BUILDING_ID="buildingId";
	
	public static final String TABLE_NAME_4="monitors";  //����ͷĿ¼
	public static final String MONITOR_ID="_id";
	public static final String MONITOR_NAME="name";
	public static final String MONITOR_URL="url";
	public static final String MONITOR_FLOOR_ID="floorId";
	public static final String MONITOR_FLOOR_AREA_ID="areaId";
	public static final String MONITOR_FLLOR_BUILDING_ID="buildingId";
	
	
}
