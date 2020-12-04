package pku.shengbin.utils;   

import java.security.MessageDigest;

/**
 * Utility class which computes MD5 value of a String.
 */
public class MD5 {   
//	public final static String compute(String s) {   
//		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',   
//				'a', 'b', 'c', 'd', 'e', 'f' };   
//		try {   
//			byte[] strTemp = s.getBytes();   
//			MessageDigest mdTemp = MessageDigest.getInstance("MD5");   
//			mdTemp.update(strTemp);   
//			byte[] md = mdTemp.digest();   
//			int j = md.length;   
//			char str[] = new char[j * 2];   
//			int k = 0;   
//			for (int i = 0; i < j; i++) {   
//				byte byte0 = md[i];   
//				str[k++] = hexDigits[byte0 >>> 4 & 0xf];   
//				str[k++] = hexDigits[byte0 & 0xf];   
//			}   
//			return new String(str);   
//		} catch (Exception e) {   
//			return null;   
//		}   
//	}  
	
	/**
	 * ���ַ���ʹ��MD5���м��ܺ󷵻��ַ���
	 * @param s
	 * @return
	 */
	public final static String compute(String s) {

		try {   
			byte[] strTemp = s.getBytes();   
			MessageDigest mdTemp = MessageDigest.getInstance("MD5");   
			mdTemp.update(strTemp);   
			byte[] md = mdTemp.digest();
			return byteToHex(md);
		} catch (Exception e) {   
			return null;   
		}   
	}

	/**
	 * ���ֽ�����ת�����ַ���
	 * @param byteArray
	 * @return
	 */
	public static String byteToHex(byte[] byteArray){
		char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
				'a', 'b', 'c', 'd', 'e', 'f' };
		//һ��byte�ǰ�λ�����ƣ���λ16�����ַ�
		char[] md=new char[byteArray.length*2];
		int k=0;
		for(int i=0;i<byteArray.length;i++){
			byte byte0 = byteArray[i];
			md[k++]= hexDigits[byte0 >>> 4 & 0xf]; //����λ
			md[k++] = hexDigits[byte0 & 0xf];   //����λ
		}
		return new String(md);
	}
}  