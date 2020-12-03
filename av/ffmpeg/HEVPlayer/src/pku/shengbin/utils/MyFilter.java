package pku.shengbin.utils;

import java.io.File;
import java.io.FileFilter;

import android.content.Context;
import android.content.SharedPreferences;
import android.preference.PreferenceManager;

public class MyFilter implements FileFilter{
	
	 private Context context;
	 private SharedPreferences settings;
	 private boolean showHidden;
	 private boolean showMediaOnly;

	 public MyFilter(Context context){
	     this.context=context;
	     settings = PreferenceManager.getDefaultSharedPreferences(context);
	     showHidden = settings.getBoolean("show_hidden_switch", false);  //�����ļ����Ƿ�ɲ鿴
	     showMediaOnly = settings.getBoolean("only_media_switch", false);  //�Ƿ�ֻ�鿴media�����ļ�
	 }
	 @Override
	 public boolean accept(File pathname) {
	     if (!showHidden && pathname.getName().startsWith("."))
	         return false;
	     else if (pathname.isDirectory())
	         return true;
	     else if (showMediaOnly && !FileUtils.isMedia(pathname.getName()))
	         return false;
	     else
	         return true;
	 }
	
}
