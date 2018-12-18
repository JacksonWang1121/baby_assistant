package org.sdibt.group.utils;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.MalformedURLException;
import java.net.URL;

/**
 * 网络连接工具类
 * @title HttpUtil.java
 * @author JacksonWang
 * @date 2018年12月15日 下午10:03:51
 * @package sdibt.group.util
 * @version 1.0
 *
 */
public class HttpUtil {

	/**
	 * http访问，并将返回的结果转化为json格式字符串
	 * @param url
	 * @return
	 */
	public static String loadJSON(String url) {
		//字符串处理类
		StringBuilder json = new StringBuilder();
		HttpURLConnection con = null;
		BufferedReader in = null;
		try {
			URL uri = new URL(url);
			//创建url连接实例
			con = (HttpURLConnection) uri.openConnection();
			in = new BufferedReader(new InputStreamReader(con.getInputStream(), "UTF-8"));
			String inputLine = null;
			//读取数据
			while ((inputLine = in.readLine()) != null) {
				json.append(inputLine);
			}
		} catch (MalformedURLException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			//关闭输入流
			try {
				if (in != null) {
					in.close();
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
			//关闭连接
			if (con != null) {
				con.disconnect();
			}
		}
		return json.toString();
	}

	/**
	 * @param urlStr
	 *            请求的地址
	 * @param content
	 *            请求的参数 格式为：name=xxx&pwd=xxx
	 * @param encoding
	 *            服务器端请求编码。如GBK,UTF-8等
	 * @return
	 */
	public static String getResult(String urlStr, String params, String encodingType) {
		HttpURLConnection con = null;
		try {
			URL url = new URL(urlStr);
			// 新建连接实例
			con = (HttpURLConnection) url.openConnection();
			// 设置连接超时时间，单位毫秒
			con.setConnectTimeout(2000);
			// 设置读取数据超时时间，单位毫秒
			con.setReadTimeout(2000);
			// 是否打开输出流 true|false
			con.setDoOutput(true);
			// 是否打开输入流true|false
			con.setDoInput(true);
			// 提交方法POST|GET
			con.setRequestMethod("POST");
			// 是否缓存true|false
			con.setUseCaches(false);
			// 打开连接端口
			con.connect();
			if (params != null) {
				// 打开输出流往对端服务器写数据
				DataOutputStream out = new DataOutputStream(con.getOutputStream());
				// 写数据,也就是提交你的表单 name=xxx&pwd=xxx
				out.writeBytes(params);
				// 刷新
				out.flush();
				// 关闭输出流
				out.close();
			}
			// 往对端写完数据对端服务器返回数据
			BufferedReader reader = new BufferedReader(
					new InputStreamReader(con.getInputStream(), encodingType));
			// ,以BufferedReader流来读取
			StringBuffer buffer = new StringBuffer();
			String line = "";
			while ((line = reader.readLine()) != null) {
				buffer.append(line);
			}
			reader.close();
			return buffer.toString();
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			// 关闭连接
			if (con != null) {
				con.disconnect();
			}
		}
		return null;
	}

}
