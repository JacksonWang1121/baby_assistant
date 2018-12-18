package org.sdibt.group.listener;

import java.io.IOException;
import java.io.InputStream;
import java.net.ServerSocket;
import java.net.Socket;
import java.util.HashMap;
import java.util.Map;
import java.util.Set;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpServlet;

import org.sdibt.group.controller.SchoolBusController;
import org.sdibt.group.thread.SchoolBusLBSThread;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;

public class ReceiveGPSListener extends HttpServlet implements ServletContextListener {

	//服务器端口号，用来监听传过来的数据
	private final int PORT = 3334;
	//存储终端的集合
	public static Map<Socket, String> clients = new HashMap<>();
	//服务器对象
	private ServerSocket socket = null;

	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		//关闭服务器
		stopServerSocket();
	}

	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		//启动服务器
		initServerSocket();
	}

	public void initServerSocket() {
		try {
			//实例化spring容器
//			ApplicationContext ctx = new ClassPathXmlApplicationContext("spring-mvc.xml");
//			SchoolBusController schoolBusController = 
//					(SchoolBusController) ctx.getBean("schoolBusController");
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
				if (data != null) {
					//记录每一个连接的终端
					clients.put(client,data);
				}
				//创建一个线程，每一个客户端对应一个线程
				//new SchoolBusLBSThread(client, schoolBusController).start();
			}
		} catch (IOException e) {
			e.printStackTrace();
			//关闭服务器
			stopServerSocket();
			System.err.println("服务器运行异常，连接中断...");
		}
	}

	public void stopServerSocket() {
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
		}
	}

	public String receiveData(Socket client) {
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

}