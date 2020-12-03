package pku.shengbin.hevplayer;

import pku.shengbin.hevplayer.R;
import pku.shengbin.utils.MessageBox;
import android.os.Bundle;
import android.preference.Preference;
import android.preference.PreferenceActivity;
import android.preference.Preference.OnPreferenceChangeListener;
import android.preference.Preference.OnPreferenceClickListener;

/**
 * Used for application settings. Some of its methods are deprecated, and needs update.
 * PreferenceActivity ϵͳ�Դ������ý��棬���б�������������
 *  	OnPreferenceChangeListener  Ҫ�Լ��洢��Ӧ��ƫ������
 *  	OnPreferenceClickListener   ���Լ����д洢ƫ������
 * ����xml���֣�
 * 		1��addPreferencesFromResource(R.xml.settings);
 * 		2����mainfest����Ӧ��activity������<mete-data />��ǩ�е�������Դ
 */
public class SettingsActivity extends PreferenceActivity implements OnPreferenceChangeListener,
		OnPreferenceClickListener {
	@Override
    public void onCreate(Bundle savedInstanceState) {
        super.onCreate(savedInstanceState);
		//���xml
        addPreferencesFromResource(R.xml.settings);
        
        Preference pref1 = findPreference("about_this_app");
        pref1.setOnPreferenceClickListener(this);
    }

	public boolean onPreferenceChange(Preference arg0, Object arg1) {
		// return true so the preference can be changed, false otherwise
		return true; 
	}

	public boolean onPreferenceClick(Preference arg0) {
		// TODO Auto-generated method stub
		if (arg0.getKey().equals("about_this_app")) {
			MessageBox.show(this, getResources().getString(R.string.about),getResources().getString(R.string.about_message));
		};
		return false;
	}
}