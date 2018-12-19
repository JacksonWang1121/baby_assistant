package org.sdibt.group.service.impl;

import java.util.Collection;
import java.util.List;

import javax.annotation.Resource;

import org.sdibt.group.dao.SchoolBusDao;
import org.sdibt.group.entity.SchoolBus;
import org.sdibt.group.server.SchoolBusPositionServer;
import org.sdibt.group.service.ISchoolBusService;
import org.springframework.stereotype.Service;

import org.sdibt.group.utils.BaiduMapUtil;

@Service
public class SchoolBusService implements ISchoolBusService {

	@Resource
	private SchoolBusDao schoolBusDao;

	public void setSchoolBusDao(SchoolBusDao schoolBusDao) {
		this.schoolBusDao = schoolBusDao;
	}

	/**
	 * 根据幼儿园编号查询所有校车的记录
	 * @param schoolId
	 * @return
	 */
	@Override
	public List<SchoolBus> listSchoolBus(int schoolId) {
		return this.schoolBusDao.listSchoolBus(schoolId);
	}

	/**
	 * 获取校车gps定位器的ip地址及其所在地理位置的经纬度
	 * @param buses
	 * @return
	 */
	@Override
	public List<SchoolBus> schoolBusPosition(List<SchoolBus> buses) {
		//得到接入校车定位socket服务器的校车集合
		Collection<SchoolBus> busList = SchoolBusPositionServer.clients.values();
		//遍历校车
		for (SchoolBus bus : buses) {
			for (SchoolBus bl : busList) {
				if (bus.getId() == bl.getId()) {
					//若匹配到接入校车定位socket服务器中的终端，则通过第三方定位系统api获取校车所在地理位置的经纬度
					String[] coordinate = getInetCoordinate(bl.getIpAddress());
					bus.setLongitude(coordinate[0]);
					bus.setLatitude(coordinate[1]);
					bus.setIpAddress(bl.getIpAddress());
				}
			}
		}
		return buses;
	}

	/**
	 * 通过第三方定位系统api获取校车所在地理位置的经纬度
	 * 第0个坐标表示经度
	 * 第1个坐标表示纬度
	 * @param ipAddress
	 * @return
	 */
	private String[] getInetCoordinate(String ipAddr) {
		String[] coordinate = null;
		if (ipAddr!=null || !"".equals(ipAddr)) {
			//根据ip获取地理位置
			String address = BaiduMapUtil.getAddresses("ip="+ipAddr, "utf-8");
			if (address!=null || !"".equals(address)) {
				coordinate = BaiduMapUtil.getCoordinate(address);
				if (coordinate == null) {
					System.err.println("######同步坐标已达到日配额限制，请明天再试！#####");
				}
			}
		}
		System.out.println("SchoolBusService::getInetCoordinate-coordinate = {'ip':'" + ipAddr
				+ "','lng':'" + coordinate[0] + "','lat':'" + coordinate[1] + "'}");
		return coordinate;
	}

}
