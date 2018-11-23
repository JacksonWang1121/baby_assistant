package org.sdibt.group.utils;
/**
 * 上传图片的工具类
 * Title:ImageFileUtils
 * @author hanfangfang
 * date:2018年7月24日 下午7:28:50
 * package:org.sdibt.freebird.utils
 * version 1.0
 */
public class ImageFileUtils {
	/**
	 * 
	 * @param src 项目中随便一个类的class对象
	 * @param fileProjectPath
	 * @return
	 */
	public static String getPath(Class src,String fileProjectPath){
		String path = src.getClassLoader().getResource("").getPath();
		System.out.println(path);
		String substring = path.substring(1, path.indexOf("babyassistant"));
		substring+=fileProjectPath;
		return substring;
	}

}
