package pku.shengbin.hevplayer.base.entity;

import java.util.ArrayList;
import java.util.List;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;
import android.widget.Toast;
import pku.shengbin.hevplayer.base.DBManager;
import pku.shengbin.hevplayer.base.DBUtils;
import pku.shengbin.hevplayer.base.DatabaseOpenHelper;
import pku.shengbin.hevplayer.bean.Area;
import pku.shengbin.utils.LogUtils;
import pku.shengbin.utils.StringUtils;

/**
 * Area���ݵĹ���
 * @author rpts
 *
 */
public class AreaManager {

	private static DatabaseOpenHelper helper;
	private static DBManager dbManager;
	private static AreaManager areaManager;
	private BuildingManger buildingManager;
	private SQLiteDatabase db;
	private Context context;
	private static String TAG="AreaManager";
	
	
	public static AreaManager getInstance(Context context){
		helper=DatabaseOpenHelper.getInstance(context);
		dbManager = DBManager.getInstance(context);
		if(areaManager==null){
			areaManager=new AreaManager(context);
		}
		return areaManager;
	}
	
	private AreaManager(Context context){
		this.context =context;
		db =helper.getWritableDatabase();  //�����ݿ�
	}
	
	private void initBuildingManager(){
		if(buildingManager==null){
			buildingManager =BuildingManger.getInstance(context);
		}
	}
	
	public boolean isOpen(){
		if(db!=null&&db.isOpen()){
			return true;
		}
		return false;
	}
	
	public void open(){
		db = helper.getWritableDatabase();
	}
	
	
	public void insert(String name){
		try{
			if(StringUtils.isEmpty(name)){
				Toast.makeText(context, "���Ʋ���Ϊ�գ�",Toast.LENGTH_SHORT).show();
				if(isOpen()){
					DBManager.close(db);
				}
				return;
			}
			
			if(!isOpen()){
				open();
			}
			
			ContentValues values=new ContentValues();
			values.put(DBUtils.AREA_NAME,name);
			long count =DBManager.insert(db, DBUtils.TABLE_NAME_1, null, values);
			if(count>0){
				Toast.makeText(context, "������ݳɹ���",Toast.LENGTH_SHORT).show();
			}else{
				Toast.makeText(context, "�������ʧ�ܣ�", Toast.LENGTH_SHORT).show();
			}
			DBManager.close(db);
		}catch(Exception e){
			if(isOpen()){
				DBManager.close(db);
			}
			LogUtils.e(TAG,"�������ʧ��!");
		}
	}
	
	public List<Area> query(){
		List<Area> list=new ArrayList<Area>();
		try{
			if(!isOpen()){
				open();
			}
			
			Cursor cursor =DBManager.query(db, DBUtils.TABLE_NAME_1, null,null, null, null, null,null);
			list=cursorToList(cursor);
			DBManager.close(db);
			return list;
		}catch(Exception e){
			if(isOpen()){
				DBManager.close(db);
			}
			LogUtils.e(TAG,"��ѯ����ʧ��!");
			return list;
		}
		
	}

	private List<Area> cursorToList(Cursor cursor) {
		List<Area> list=new ArrayList<Area>();
		while(cursor.moveToNext()){
			int indexId=cursor.getColumnIndex(DBUtils.AREA_ID);
			int id=cursor.getInt(indexId);
			String name =cursor.getString(cursor.getColumnIndex(DBUtils.AREA_NAME));
			Area area=new Area();
			area.setId(id);
			area.setName(name);
			list.add(area);
		}
		return list;
	}
	
	public void update(String name,int areaId){
		try{
			//���²���
			if(!isOpen()){
				open();
			}
			if(StringUtils.isEmpty(name)){
				Toast.makeText(context, "���Ʋ���Ϊ��!",Toast.LENGTH_SHORT).show();
				if(isOpen()){
					DBManager.close(db);
				}
				return;
			}
			//TODO ���²���
			ContentValues values=new ContentValues();
			values.put(DBUtils.AREA_NAME,name);
			String whereClause="_id=?";
			String[] whereArgs=new String[]{areaId+""};
			int count =DBManager.update(db, DBUtils.TABLE_NAME_1, values, whereClause, whereArgs);
		}catch(Exception e){
			LogUtils.e(TAG,"��������ʧ��!");
			if(isOpen()){
				DBManager.close(db);
			}
		}
		
	}
	
	public void delete(int areaId){
		try{
			initBuildingManager();
			buildingManager.delete(areaId);
			if(!isOpen()){
				open();
			}
			//TODO ɾ������
			String whereClause="_id=?";
			String value =areaId+"";
			String[] whereArgs=new String[]{value};
			int count = DBManager.delete(db, DBUtils.TABLE_NAME_1, whereClause, whereArgs);
		}catch(Exception e){
			LogUtils.e(TAG,"ɾ������ʧ��!");
			if(isOpen()){
				DBManager.close(db);
			}
		}
	}
}

