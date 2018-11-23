package org.sdibt.group.vo;


import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;



/**
 * 分页可视化
 * @author JacksonWang
 *
 */
public class PageVO implements Serializable{
	
	private int curPage=1;//当前页号
	private int pages;//总页数
	private int pageSize=10;//每页数据条数
	private List datas=new ArrayList<>();//每页显示的数据
	private int total;//信息总数
	public int getCurPage() {
		return curPage;
	}
	public void setCurPage(int curPage) {
		this.curPage = curPage;
	}
	public int getPages() {
		return pages;
	}
	public void setPages(int pages) {
		this.pages = pages;
	}
	public int getPageSize() {
		return pageSize;
	}
	public void setPageSize(int pageSize) {
		this.pageSize = pageSize;
	}
	
	public List getDatas() {
		return datas;
	}
	public void setDatas(List datas) {
		this.datas = datas;
	}
	public int getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
	}
	@Override
	public String toString() {
		return "PageVO [curPage=" + curPage + ", pages=" + pages
				+ ", pageSize=" + pageSize + ", datas=" + datas + ", total="
				+ total + "]";
	}
	
	
}