package org.sdibt.group.exception;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.servlet.HandlerExceptionResolver;
import org.springframework.web.servlet.ModelAndView;
/**
 * 
 * Title:MyExceptionResolver
 * @author hanfangfang
 * date:2018年8月28日 上午11:16:16
 * package:org.sdibt.group.exception
 * version 1.0
 */
	public class MyExceptionResolver implements HandlerExceptionResolver {
		public ModelAndView resolveException(HttpServletRequest request,
				HttpServletResponse response, Object handler, Exception ex) {
			//任何一个controller方法发生异常都会进入此方法，处理完毕后跳转到exception.jsp
			ModelAndView mv = new ModelAndView();
			mv.addObject("msg", ex.getMessage());
			mv.setViewName("exception");
			return mv;
		}


}
