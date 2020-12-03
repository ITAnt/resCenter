package pku.shengbin.hevplayer.base;

import android.content.ContentValues;
import android.content.Context;
import android.database.Cursor;
import android.database.sqlite.SQLiteDatabase;

/**
 * area���ݿ����
 * @author rpts
 */
public class DBManager {
	
	private static DBManager dbManager;
	
	public static DBManager getInstance(Context context){
		if(dbManager==null){
			dbManager=new DBManager();
		}
		return dbManager;
	}
	
	//TODO  ���ݿ����ɾ�Ĳ鹦��
	/**
	 * ִ��SQL�����в�ѯ
	 * @param db
	 * @param sql
	 */
	public static void execSql(SQLiteDatabase db,String sql){
		if(db!=null){
			if(!"".equals(sql)&&sql!=null){
				db.execSQL(sql);
			}
		}
	}
	/**
	 * ����api���ṩ�ķ�����������
	 * @param db
	 * @param table
	 * @param nullColumnHack
	 * @param values
	 * @return
	 */
	public static long insert(SQLiteDatabase db,String table,String nullColumnHack,ContentValues values){
		long count=0;
		if(db!=null){
			count = db.insert(table, nullColumnHack, values);
		}
		return count;
	}
	/**
	 * ����api�ṩ�ķ����޸�����
	 * @param db
	 * @param table
	 * @param values
	 * @param whereClause
	 * @param whereArgs
	 * @return
	 */
	public static int update(SQLiteDatabase db,String table,ContentValues values,String whereClause,String[] whereArgs){
		int count=0;
		if(db!=null){
			count=db.update(table,values,whereClause,whereArgs);
		}
		return count;
	}
	/**
	 * ����api��ʽɾ������
	 * @param db
	 * @param table
	 * @param whereClause
	 * @param whereArgs
	 * @return
	 */
	public static int delete(SQLiteDatabase db,String table,String whereClause,String[] whereArgs){
		int count=0;
		if(db!=null){
			count=db.delete(table, whereClause, whereArgs);
		}
		return count;
	}
	/**
	 * ͨ��sql����ѯ���ݱ�
	 * @param db
	 * @param sql
	 * @param selectionArgs
	 * @return
	 */
	public static Cursor query(SQLiteDatabase db,String sql,String[] selectionArgs){
		Cursor cursor=null;
		if(db!=null){
			cursor =db.rawQuery(sql, selectionArgs);
		}
		return cursor;
	}
	/**
	 * ͨ��api��ʽ��ѯ���ݱ�
	 * @param db
	 * @param table
	 * @param columns
	 * @param selection
	 * @param selectionArgs
	 * @param groupBy
	 * @param having
	 * @param orderBy
	 * @return
	 */
	public static Cursor query(SQLiteDatabase db,String table,String[] columns,String selection,String[] selectionArgs,String groupBy,String having,String orderBy){
		Cursor cursor=null;
		if(db!=null){
			cursor = db.query(table, columns, selection, selectionArgs, groupBy, having, orderBy);
		}
		return cursor;
	}
	/**
	 * �ر����ݿ�
	 * @param db
	 */
	public static void close(SQLiteDatabase db){
		if(db!=null){
			db.close();
		}
	}
}
