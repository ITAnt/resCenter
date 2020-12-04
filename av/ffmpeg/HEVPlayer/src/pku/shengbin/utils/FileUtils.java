package pku.shengbin.utils;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Comparator;
import java.util.List;

import android.content.Context;
import android.content.SharedPreferences;
import android.os.Environment;
import android.preference.PreferenceManager;
import android.util.Log;

public class FileUtils {

	/**
     * �ļ������ļ��д����ļ�
     * @param files
     */
    public static void sortFiles(File[] files) {
        Arrays.sort(files, new Comparator<File>() {
            public int compare(File f1, File f2) {
                if (f1.isDirectory() && f2.isFile())
                    return -1;
                else if (f2.isDirectory() && f1.isFile())
                    return 1;
                else return f1.getName().compareToIgnoreCase(f2.getName());
            }
        });
    }

    /**
     * �����չ��
     * @param file
     * @return
     */
    public static boolean checkExtension(File file) {
        for (int i = 0; i < ConstantConfig.exts.length; i++) {
            if (file.getName().indexOf(ConstantConfig.exts[i]) > 0) {
                return true;
            }
        }
        return false;
    }


    /**
     *  ��ȡ������Ҫ���ļ��м��ļ�����
     * @param dirPath
     */
    public static  File[] getDirectory(final Context context,String dirPath) {
        String mCurrentDir=null;
        try {
            mCurrentDir = dirPath;
            SharedPreferences prefs = PreferenceManager.getDefaultSharedPreferences(context);
            prefs.edit().putString("current_dir", mCurrentDir).commit();
            //�ļ�����
            File f = new File(dirPath);
            File[] temp = f.listFiles(new MyFilter(context));  //����֮��õ����ļ����ļ���
            //�Ի�ȡ�����ļ��н�������
            sortFiles(temp);
            File[] files = null;
            //�ж��Ƿ�Ϊ��Ŀ¼������û�� Parent file,�����Ҫ��parent file
            if (!dirPath.equals(ConstantConfig.mRootDir)) {
                files = new File[temp.length + 1];
                System.arraycopy(temp, 0, files, 1, temp.length);
                files[0] = new File(f.getParent());
            } else {
                files = temp;
            }
            return files;

        } catch (Exception ex) {
            MessageBox.show(context, "Sorry", "Get directory failed! Please check your SD card state.");
            return null;
        }
    }

//    /**
//     * �ļ����˲���
//     */
//    static class MyFilter implements FileFilter {
//        private Context context;
//
//        public MyFilter(Context context){
//            this.context=context;
//        }
//        // android maintains the preferences for us, so use directly
//        SharedPreferences settings = PreferenceManager.getDefaultSharedPreferences(context);
//        boolean showHidden = settings.getBoolean("show_hidden_switch", false);  //�����ļ����Ƿ�ɲ鿴
//        boolean showMediaOnly = settings.getBoolean("only_media_switch", false);  //�Ƿ�ֻ�鿴media�����ļ�
//        //�ж��Ƿ���media
//        //�ļ����˵ķ���
//        public boolean accept(File file) {
//            if (!showHidden && file.getName().startsWith("."))
//                return false;
//            else if (file.isDirectory())
//                return true;
//            else if (showMediaOnly && !isMedia(file.getName()))
//                return false;
//            else
//                return true;
//        }
//    }

    /**
     * �ж��Ƿ�Ϊmedia
     * @param name
     * @return
     */
    public static boolean isMedia(String name) {
        for (int i = 0; i < ConstantConfig.exts.length; i++) {
            if (name.endsWith(ConstantConfig.exts[i]))
                return true;
        }
        return false;
    }

    public static String getCurrentDir(Context context,String currentDir){

        if (currentDir.isEmpty()) {
            currentDir = ConstantConfig.mRootDir;
            try {
                String state = Environment.getExternalStorageState();
                //ֻ�������Ǵ�����
                if (state.equals(Environment.MEDIA_MOUNTED) || state.equals(Environment.MEDIA_MOUNTED_READ_ONLY)) {
                    currentDir = Environment.getExternalStorageDirectory().getPath();
                }
            } catch (Exception ex) {
                MessageBox.show(context, "Sorry", "Get sdcard directory failed! Please check your SD card state.");
            }
        }
        return currentDir;
    }

    /**
     *
     * @return
     */
    public static List<String> getHistory(){

        List<String> history = new ArrayList<String>();
        try {
            File file = new File(ConstantConfig.DEFAULT_DIR + "/.hevplayer/history.txt");
            if (file.exists()) {
                BufferedReader reader = new BufferedReader(new FileReader(file));
                String temp = null;
                while((temp = reader.readLine()) != null)
                    history.add(temp);
                reader.close();
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        history.add(ConstantConfig.CLEAR);
        return history;
    }
	
}
