package org.sdibt.group.utils;

import java.io.UnsupportedEncodingException;
import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.text.DecimalFormat;

import com.alibaba.fastjson.JSONObject;

/**
 * 百度地图经纬度和地址相互转换的工具类
 * @title BaiduMapUtil.java
 * @author JacksonWang
 * @date 2018年12月15日 下午9:52:49
 * @package sdibt.group.util
 * @version 1.0
 *
 */
public class BaiduMapUtil {
	
	//百度地图api开发密钥
	private static String BAIDU_APP_KEY = "h1ftaAWtybFRa6L1ifGy6SRdayuvb5oW";

	/* *************************************************
	 * 根据地理位置获取准确的经纬度坐标
	 **************************************************/
	
	/**
	 * 调用百度地图API根据地址，获取坐标
	 * @param address
	 * @return
	 */
	public static String[] getCoordinate(String address) {
		//存储坐标，第0个元素表示经度，第一个元素表示维度
		String[] coordinate = null;
		//address不能为空
		if (address!=null && !"".equals(address)) {
			//替换字符
			address = address.replaceAll("\\s*", "").replace("#", "栋");
			//调用百度地图API的url
			String url = "http://api.map.baidu.com/geocoder/v2/?address=" + address + "&output=json&ak=" + BAIDU_APP_KEY;
			//获取经纬度坐标数据
			String json = HttpUtil.loadJSON(url);
			System.out.println("BaiduMapUtil::getCoordinate-json = "+json);
			if (json != null && !"".equals(json)) {
				//字符串转为json对象
				JSONObject obj = JSONObject.parseObject(json);
				if ("0".equals(obj.getString("status"))) {
					//获取坐标位置
					JSONObject location = obj.getJSONObject("result").getJSONObject("location");
					//设置十进制格式
					DecimalFormat df = new DecimalFormat("#.######");
					//创建并赋值经纬度坐标存储数组
					coordinate = new String[2];
					//获取、赋值、并格式化经度
					coordinate[0] = df.format(location.getDouble("lng"));
					//获取、赋值、并格式化维度
					coordinate[1] = df.format(location.getDouble("lat"));
				}
			}
		}
		System.out.println("BaiduMapUtil::getCoordinate-coordinate = "+coordinate);
		return coordinate;
	}

	/**
	 * 来自stackoverflow的MD5计算方法，调用了MessageDigest库函数，并把byte数组结果转换成16进制
	 * @param md5
	 * @return
	 */
	public String MD5(String md5) {
		try {
			MessageDigest md = MessageDigest.getInstance("MD5");
			byte[] array = md.digest(md5.getBytes());
			StringBuffer sb = new StringBuffer();
			for (int i = 0; i < array.length; ++i) {
				sb.append(Integer.toHexString((array[i] & 0xFF) | 0x100).substring(1, 3));
			}
			return sb.toString();
		} catch (NoSuchAlgorithmException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/* ******************************************************
	 * 根据IP获取当前所在的地理位置
	 *******************************************************/

	/**
	 * 获取地理位置
	 * @param content
	 *            请求的参数 格式为：name=xxx&pwd=xxx
	 * @param encoding
	 *            服务器端请求编码。如GBK,UTF-8等
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public static String getAddresses(String content, String encodingType) {
		/*
		 * 淘宝API：http://ip.taobao.com/service/getIpInfo.php?ip=218.192.3.42
		 * 新浪API：http://int.dpool.sina.com.cn/iplookup/iplookup.php?format=json&ip=218.192.3.42
		 * pconline API：http://whois.pconline.com.cn/
		 * 百度API：http://api.map.baidu.com/location/ip?ip=218.192.3.42
		 */
		//调用百度地图API
		String urlStr = "http://api.map.baidu.com/location/ip?ak="+BAIDU_APP_KEY;
		// 从http://whois.pconline.com.cn取得IP所在的省市区信息
		String response = HttpUtil.getResult(urlStr, content, encodingType);
//		String response = HttpUtil.loadJSON("http://api.map.baidu.com/location/ip?"+content);
		if (response != null) {
			// 处理返回的省市区信息
			System.out.println("(1) unicode转换成中文前的returnStr : " + response);
			response = decodeUnicode(response);
			System.out.println("(2) unicode转换成中文后的returnStr : " + response);
			String[] temp = response.split(",");
			if (temp.length < 3) {
				return "0";// 无效IP，局域网测试
			}
			return response;
		}
		return null;
	}

	/**
	 * unicode 转换成 中文
	 * @param content
	 * @return
	 */
	public static String decodeUnicode(String content) {
		char aChar;
		int len = content.length();
		StringBuffer outBuffer = new StringBuffer(len);
		for (int x = 0; x < len;) {
			aChar = content.charAt(x++);
			if (aChar == '\\') {
				aChar = content.charAt(x++);
				if (aChar == 'u') {
					int value = 0;
					for (int i = 0; i < 4; i++) {
						aChar = content.charAt(x++);
						switch (aChar) {
						case '0':
						case '1':
						case '2':
						case '3':
						case '4':
						case '5':
						case '6':
						case '7':
						case '8':
						case '9':
							value = (value << 4) + aChar - '0';
							break;
						case 'a':
						case 'b':
						case 'c':
						case 'd':
						case 'e':
						case 'f':
							value = (value << 4) + 10 + aChar - 'a';
							break;
						case 'A':
						case 'B':
						case 'C':
						case 'D':
						case 'E':
						case 'F':
							value = (value << 4) + 10 + aChar - 'A';
							break;
						default:
							throw new IllegalArgumentException("Malformed encoding.");
						}
					}
					outBuffer.append((char) value);
				} else {
					if (aChar == 't') {
						aChar = '\t';
					} else if (aChar == 'r') {
						aChar = '\r';
					} else if (aChar == 'n') {
						aChar = '\n';
					} else if (aChar == 'f') {
						aChar = '\f';
					}
					outBuffer.append(aChar);
				}
			} else {
				outBuffer.append(aChar);
			}
		}
		return outBuffer.toString();
	}

}
