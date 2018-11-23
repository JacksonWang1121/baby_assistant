package org.sdibt.group.controller;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.sdibt.group.entity.Class;
import org.sdibt.group.entity.User;
import org.apache.http.HttpRequest;
import org.sdibt.group.entity.Class;
import org.sdibt.group.entity.Baby;
import org.sdibt.group.service.IBabyService;
import org.sdibt.group.service.IUserService;
import org.sdibt.group.utils.FileUtil;
import org.sdibt.group.utils.PaymentUtil;
import org.sdibt.group.utils.SMScode;
import org.sdibt.group.vo.PageVO;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.aliyuncs.dysmsapi.model.v20170525.SendSmsResponse;
import com.aliyuncs.exceptions.ClientException;

/**
 * 
 * Title:BabyController
 * @author hanfangfang
 * date:2018年8月29日 下午5:02:01
 * package:org.sdibt.group.controller
 * version 1.0
 */
@Controller
public class BabyController {

	@Resource
	private IBabyService babyService;
	@Resource
	private IUserService userService;

	public void setBabyService(IBabyService babyService) {
		this.babyService = babyService;
	}

	public void setUserService(IUserService userService) {
		this.userService = userService;
	}

	/**
	 * 宝宝分班：根据教师所在年级查询待分班的宝宝信息
	 * @param session
	 * @param map
	 * @return
	 */
	@RequestMapping("/listBabyEnrollInfo")
	public String listBabyEnrollInfo(HttpSession session,Map map){
		Long userId=(Long) session.getAttribute("userId");
		Class classInfo = (Class) session.getAttribute("class");
		int kindergartenId = classInfo.getKindergartenId();
		PageVO pageVO = new PageVO();
		int pageSize = pageVO.getPageSize();
		int curPage = pageVO.getCurPage();
		PageVO pv = this.babyService.listBabyEnrollInfo(curPage,pageSize,userId,kindergartenId);
		map.put("pv", pv);
		return "babyDivideclass";
	}
	/**
	 * 加入班级
	 * @param babyId
	 * @return
	 */
	@RequestMapping("/updateClassInfoToBaby")
	public String updateClassInfoToBaby(int babyId,int classId){
		this.babyService.updateClassInfoToBaby(babyId,classId);
		return "redirect:/listBabyEnrollInfo";
	}
	/**
	 * 宝宝分班：根据教师所在班级查询已分班的宝宝信息
	 * @param session
	 * @param map
	 * @return
	 */
	@RequestMapping("/listBabiesInClass")
	public String listBabiesInClass(HttpSession session,Map map){
		Long userId=(Long)session.getAttribute("userId");
		PageVO pageVO = new PageVO();
		int pageSize = pageVO.getPageSize();
		int curPage = pageVO.getCurPage();
		PageVO pv = this.babyService.listBabiesInClass(curPage,pageSize,userId);
		map.put("pv", pv);
		return "hasDivideClass";
	}
	/**
	 * 移出班级
	 * @param babyId
	 * @return
	 */
	@RequestMapping("/updateClassInfoOfBaby")
	public String updateClassInfoOfBaby(int babyId){
		this.babyService.updateClassInfoOfBaby(babyId);
		return "redirect:/listBabiesInClass";
	}
	/**
	 * 报名列表：查询全园未分班的宝宝信息
	 * @param map
	 * @return
	 */
	@RequestMapping("/listWaitDivideBabyInfo")
	public String listWaitDivideBabyInfo(HttpSession session,Map map){
		PageVO pageVO = new PageVO();
		int pageSize = pageVO.getPageSize();
		int curPage = pageVO.getCurPage();
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		PageVO pv = this.babyService.listWaitDivideBabyInfo(curPage,pageSize,kindergartenId);
		map.put("pv", pv);
		return "waitDivide";
	}
	/**
	 * 报名列表：查询全园待付款的宝宝信息
	 * @param map
	 * @return
	 */
	@RequestMapping("/listWaitPayBabyInfo")
	public String listWaitPayBabyInfo(HttpSession session,Map map){
		PageVO pageVO = new PageVO();
		int pageSize = pageVO.getPageSize();
		int curPage = pageVO.getCurPage();
		int kindergartenId = (int) session.getAttribute("kindergartenId");
		PageVO pv = this.babyService.listWaitPayBabyInfo(curPage,pageSize,kindergartenId);
		map.put("pv", pv);
		return "waitPay";
	}
	/**
	 * 报名列表：短信通知提醒缴费
	 * @param map
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/noticePayTuition")
	public String noticePayTuition(String mobile){
		SendSmsResponse response = null;
		try {
			response = SMScode.sendSms(1,mobile,"SMS_150182580");
		} catch (ClientException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		String code = response.getCode();
		return code;
	}
	/**
	 * 查看宝宝资料
	 */
	@RequestMapping("/getBabyDataByParentId")
	public String getBabyDataByParentId(HttpSession session,Map map){
		Long userId=(Long) session.getAttribute("userId");
		Map baby = this.babyService.getBabyDataByParentId(userId);
		map.put("baby", baby);
		return "babyData";
	}
	/**
	 * 修改宝宝头像
	 */
	@ResponseBody
	@RequestMapping("/updateBabyIcon")
	public String updateBabyIcon(HttpSession session,
		@RequestParam(value = "iconPath", required = false) MultipartFile iconPath
	){
		Long userId=(Long) session.getAttribute("userId");
		Map baby = this.babyService.getBabyDataByParentId(userId);
		int babyId = (int) baby.get("baby_id");
		boolean updateResult = this.babyService.updateBabyIcon(babyId,iconPath);
		if(updateResult==true){
			return "true";
		}else{
			return "false";
		}
	}
	/**
	 * 修改宝宝信息
	 */
	@ResponseBody
	@RequestMapping("/updateBabyData")
	public String updateBabyData(HttpSession session,Baby baby){
		Long userId=(Long) session.getAttribute("userId");
		Map baby1 = this.babyService.getBabyDataByParentId(userId);
		int babyId = (int) baby1.get("baby_id");
		baby.setBabyId(babyId);
		boolean updateResult = this.babyService.updateBabyData(baby);
		if(updateResult==true){
			return "true";
		}else{
			return "false";
		}
	}
	/**
	 * 检查宝宝是否已缴费
	 * @param session
	 * @return
	 */
	@ResponseBody
	@RequestMapping("/hasPayTuition")
	public boolean hasPayTuition(HttpSession session){
		Long userId=(Long) session.getAttribute("userId");
		boolean payStatus = this.babyService.hasPayTuition(userId);
		return payStatus;
	}
	/**
	 * 宝宝缴费
	 * @throws Exception 
	 */
	@RequestMapping("/payTuition")
	public void payTuition(HttpServletRequest request, HttpServletResponse response, String money) throws Exception{
		 //根据登录家长id修改宝宝学费支付状态
		  Long userId = (Long) request.getSession().getAttribute("userId");
		  this.babyService.updatePayStatus(userId); 
		  request.setCharacterEncoding("utf-8");
		  response.setContentType("text/html;charset=utf-8");
		  String p0_Cmd = "Buy";// 业务类型，固定值为buy，即“买”
		  String p1_MerId = "10001126856";// 在易宝注册的商号
		  String p2_Order = "";// 订单编号
		  String p3_Amt = money;// 支付的金额
		  String p4_Cur = "CNY";// 交易种币，固定值为CNY，表示人民币
		  String p5_Pid = "";// 商品名称
		  String p6_Pcat = "";// 商品各类
		  String p7_Pdesc = "";// 商品描述
		  String p8_Url = "http://localhost:8081/buy/BackController";// 电商的返回页面，当支付成功后，易宝会重定向到这个页面
		  String p9_SAF = "";// 送货地址
		  String pa_MP = "";// 商品扩展信息
		  String pd_FrpId = request.getParameter("pd_FrpId");// 支付通道，即选择银行
		  String pr_NeedResponse = "1";// 应答机制，固定值为1
		  // 密钥，由易宝提供，只有商户和易宝知道这个密钥。
		  String keyValue = "69cl522AV6q613Ii4W6u8K6XuW8vM1N6bFgyv769220IuYe9u37N4y7rI4Pl";
		  // 通过上面的参数、密钥、加密算法，生成hmac值
		  // 参数的顺序是必须的，如果没有值也不能给出null，而应该给出空字符串。
		  String hmac = PaymentUtil.buildHmac(p0_Cmd, p1_MerId, p2_Order, p3_Amt,
		    p4_Cur, p5_Pid, p6_Pcat, p7_Pdesc, p8_Url, p9_SAF, pa_MP,
		    pd_FrpId, pr_NeedResponse, keyValue);
		  // 把所有参数连接到网关地址后面
		  String url = "https://www.yeepay.com/app-merchant-proxy/node";
		  url += "?p0_Cmd=" + p0_Cmd +
		    "&p1_MerId=" + p1_MerId +
		    "&p2_Order=" + p2_Order +
		    "&p3_Amt=" + p3_Amt +
		    "&p4_Cur=" + p4_Cur +
		    "&p5_Pid=" + p5_Pid +
		    "&p6_Pcat=" + p6_Pcat +
		    "&p7_Pdesc=" + p7_Pdesc +
		    "&p8_Url=" + p8_Url +
		    "&p9_SAF=" + p9_SAF +
		    "&pa_MP=" + pa_MP +
		    "&pd_FrpId=" + pd_FrpId +
		    "&pr_NeedResponse=" + pr_NeedResponse +
		    "&hmac=" + hmac;
		  System.out.println(url);
		  // 重定向到网关
		  response.sendRedirect(url);
	}
	/**
	 * 支付成功返回
	 * @param request
	 * @param response
	 * @throws ServletException
	 * @throws IOException
	 */
	@RequestMapping("/BackController")
	public void BackController(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
				  response.setContentType("text/html;charset=utf-8");
				  /*
				   * 易宝会提供一系列的结果参数，我们获取其中需要的即可
				   * 获取支付结果：r1_Code，1表示支付成功。
				   * 获取支付金额：r3_Amt
				   * 获取电商的订单号：r6_Order
				   * 获取结果返回类型：r9_BType，1表示重定向返回，2表示点对点返回，
				   *  但点对点我们收不到，因为我们的ip都是局域网ip。
				   */
				  String r1_Code = request.getParameter("r1_Code");
				  String r3_Amt = request.getParameter("r3_Amt");
				  String r6_Order = request.getParameter("r6_Order");
				  String r9_BType = request.getParameter("r9_BType");
				 
				  if(r1_Code.equals("1")) {
					  if(r9_BType.equals("1")) {
						  response.getWriter().print("<h1>支付成功！</h1>");//其实支付不成功时根本易宝根本就不会返回到本Servlet
						  response.getWriter().print("支付金额为：" + r3_Amt + "<br/>");
						  //response.getWriter().print("订单号为：" + r6_Order + "<br/>");
					  }
				  }
			}
	/**
	 * 查询家长信息
	 * @param baby
	 */
	@RequestMapping("/listBabyInfoByClassId")
	public String listBabyInfoByClassId(HttpSession session,int  classId,Map map){
	List<Map> parentInfo=this.babyService.listBabyInfoByClassId(classId);
	map.put("parentInfo", parentInfo);
		return "addressBook";
	}

	/**
	 * 查询宝宝记录
	 * @param session
	 * @return
	 */
	@RequestMapping("/findBaby")
	@ResponseBody
	public Map findBaby(HttpSession session) {
		User user = (User) session.getAttribute("user");
		return this.babyService.getBabyDataByParentId(user.getId());
	}

	/**
	 * 完善宝宝信息
	 * @param request
	 * @param baby
	 * @param headPortrait
	 * @return
	 */
	@RequestMapping("/saveBaby")
	@ResponseBody
	public String saveBaby(HttpServletRequest request, Baby baby, MultipartFile headPortrait) {
		//获取session
		HttpSession session = request.getSession();
		if (headPortrait != null) {
			String fileName = FileUtil.uploadFile(request, headPortrait, "images/babyIcons");
			baby.setBabyIcon(fileName);
		}
		//从session作用域中获取babyId
		int babyId = (int) session.getAttribute("babyId");
		baby.setBabyId(babyId);
		//dml语句中，为了不将该宝宝记录中的幼儿园id、年级id、班级id篡改
		baby.setClassId(-1);
		this.babyService.updateBaby(baby);
		User user = new User();
		//从sessio作用域中获取user
		User userInfo = (User) session.getAttribute("user");
		user.setId(userInfo.getId());
		user.setFirstLoginStatus(1);
		this.userService.updateUser(user);
		return "true";
	}

}
