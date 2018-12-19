package org.sdibt.group.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.sdibt.group.server.SchoolBusPositionServer;

public class ReceiveGPSListener implements ServletContextListener {

	//服务器对象
	private SchoolBusPositionServer server = null;

	/**
	 * 监听器销毁时
	 */
	@Override
	public void contextDestroyed(ServletContextEvent arg0) {
		//关闭服务器
		server.stopServer();
	}

	/**
	 * 监听器初始化时
	 */
	@Override
	public void contextInitialized(ServletContextEvent arg0) {
		//获取实例
		server = SchoolBusPositionServer.getInstance();
		//开启校车定位socket服务器
		server.initServer();
	}

}