package org.sdibt.group.listener;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;

import org.quartz.Scheduler;
import org.springframework.web.context.WebApplicationContext;

/**
 * 定时器监听器
 * @title QuartzContextListener.java
 * @author JacksonWang
 * @date 2018年11月24日 下午5:58:42
 * @package org.sdibt.group.listener
 * @version 1.0
 *
 */
public class QuartzContextListener implements ServletContextListener {

	@Override
	public void contextDestroyed(ServletContextEvent event) {
		try {
			WebApplicationContext webApplicationContext = (WebApplicationContext) event
					.getServletContext()
					.getAttribute(WebApplicationContext.ROOT_WEB_APPLICATION_CONTEXT_ATTRIBUTE);
			Scheduler startQuartz = (Scheduler) webApplicationContext
					.getBean("DefaultQuartzScheduler");

//			Scheduler startQuartz = (Scheduler) WebApplicationContextUtils
//					.getWebApplicationContext(event.getServletContext())
//					.getBean("DefaultQuartzScheduler");

			if(startQuartz.isStarted()){
				startQuartz.shutdown();
			}
			Thread.sleep(3000);//主线程睡眠3s
			event.getServletContext().log("baby_assistant:QuartzContextListener销毁成功！");
			//System.out.println("QuartzContextListener销毁成功！");
		} catch(Exception e) {
			e.printStackTrace();
		}
	}

	@Override
	public void contextInitialized(ServletContextEvent event) {
		//System.out.println("QuartzContextListener启动成功！");
		event.getServletContext().log("baby_assistant:QuartzContextListener启动成功！");
	}

}
