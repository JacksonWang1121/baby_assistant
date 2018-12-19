package org.sdibt.group.server;

import java.io.IOException;
import java.io.InputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import org.sdibt.group.entity.SchoolBus;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;

/**
 * 校车定位socket服务器
 * @title SchoolBusPositionServer.java
 * @author JacksonWang
 * @date 2018年12月18日 下午8:11:30
 * @package org.sdibt.group.server
 * @version 1.0
 *
 */
public class SchoolBusPositionServer {

	//单例模式-饿汉式
	private final static SchoolBusPositionServer SERVER = new SchoolBusPositionServer();
	//服务器端口号，用来监听传过来的数据
	private final int PORT = 3334;
	//存储终端的集合
	public static Map<Socket, SchoolBus> clients = new HashMap<>();
	//服务器对象
	private ServerSocket socket = null;

	/**
	 * 单例模式下，构造方法必须私有化
	 */
	private SchoolBusPositionServer() {}

	/**
	 * 此方法供外部调用
	 * @return
	 */
	public static SchoolBusPositionServer getInstance() {
		return SERVER;
	}

	public void initServer() {
		try {
			//创建一个服务器对象
			socket = new ServerSocket(PORT);
			//创建一个客户端对象
			Socket client = null;
			String data = null;
			//循环接收客户端传来的数据
			while(true) {
				System.err.println("----------服务器已启动，等待客户端请求------------");
				//阻塞状态
				client = socket.accept();
				data = receiveData(client);
				if (data == null) {
					System.err.println("终端（"+client.getInetAddress().getHostAddress()+"）连接中断...");
				} else {
					//记录每一个连接的终端
					clients.put(client,parseSchoolBus(data));
				}
			}
		} catch (IOException e) {
			e.printStackTrace();
			//关闭服务器
			stopServer();
			System.err.println("服务器运行异常，连接中断...");
		}
	}

	/**
	 * 关闭socket服务器
	 */
	public void stopServer() {
		try {
			Set<Socket> keySet = clients.keySet();
			//结束连接的所有终端线程
			for (Socket ks : keySet) {
				if (!ks.isClosed()) {
					ks.close();
				}
			}
			//关闭服务器
			if (!socket.isClosed()) {
				socket.close();
			}
		} catch (IOException e) {
			e.printStackTrace();
			System.err.println("服务器关闭失败，异常断开...");
		}
	}

	/**
	 * 接收终端传来的数据
	 * @param client
	 * @return
	 */
	private String receiveData(Socket client) {
		String data = null;
		InputStream in = null;
		try {
			//创建输入流,读取终端传来的数据
			in = client.getInputStream();
			/*
			 * 注意read方法在网络上会阻塞,直到管道中有数据传来
			 */
			byte[] b = new byte[1024];
			int len = 0;
			while((len = in.read(b)) != -1) {
				System.out.println("数据传输中,请稍候...");
				data = new String(b,0,len);
				System.out.println("ReceiveGPSListener::receiveData-data = "+data);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			try {
				//关闭输入流
				if(in != null) {
					in.close();
				}
			} catch (IOException ex) {
				ex.printStackTrace();
			}
		}
		return data;
	}

	private SchoolBus parseSchoolBus(String data) {
		SchoolBus bus = null;
		//将字符串转为json对象
		JSONObject obj = (JSONObject) JSON.parse(data);
		if (obj!=null || "".equals(obj)) {
			//将json对象的数据写入schoolbus对象
			 bus = new SchoolBus();
			 bus.setId(obj.getIntValue("id"));
			 bus.setSchoolId(obj.getIntValue("schoolId"));
			 bus.setBusName(obj.getString("busName"));
			 bus.setBusPlate(obj.getString("busPlate"));
			 bus.setDriver(obj.getString("driver"));
			 bus.setDriverTel(obj.getString("driverTel"));
			 bus.setBusStatus(obj.getString("busStatus"));
			 bus.setLongitude(obj.getString("longitude"));
			 bus.setLatitude(obj.getString("latitude"));
			 bus.setIpAddress(obj.getString("ipAddress"));
		}
		return bus;
	}

}
