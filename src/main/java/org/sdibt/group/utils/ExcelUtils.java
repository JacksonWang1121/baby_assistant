package org.sdibt.group.utils;

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFHeader;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;

public class ExcelUtils {
	/**
	 * 根据表头标题和表行数据集合创建sheet表格
	 * @param tableTitle  表格标题
	 * @param heads 表头
	 * @param datas 数据  list<map>类型
	 * @param out  输出流
	 */
	public static void createExcelSheeet(String tableTitle,String[] heads,List<Map<String,Object>> datas,OutputStream out)   
	{   
	    HSSFWorkbook demoWorkBook = new HSSFWorkbook();   
	    //创建表  
	    HSSFSheet demoSheet = demoWorkBook.createSheet(tableTitle);   
	    //设置表头，从sheet中得到
        HSSFHeader header = demoSheet.getHeader(); 
        //设置标题
        header.setCenter(tableTitle);   
        /*
         * 创建一行(第0行)
         * 并且设置表头数据
         */
        HSSFRow headerRow = demoSheet.createRow((short) 0);   
        for(int i = 0;i < heads.length;i++)   
        {   
        	//创建一个单元格(用行创建单元格)
            HSSFCell headerCell = headerRow.createCell((short) i);   
            // headerCell.setEncoding(HSSFCell.ENCODING_UTF_16); 
            //CellStyle cs = new CellStyle();
            //设置单元格cell的值
            headerCell.setCellValue(heads[i]);   
        }  
        int rowIndex=1;//设置数据行初始值
        /*
         * 设置数据集合
         */
	    for (Map<String,Object> map : datas) {
	    	//创建第rowIndex行  
	        HSSFRow row = demoSheet.createRow((short) rowIndex);  
	        for(String key:map.keySet())   
	        {   
	        	if(key.equals("orderNo")){
        			// 创建第i个单元格  
      	            HSSFCell cell = row.createCell((short) 0);   
      	            //cell.setEncoding(HSSFCell.ENCODING_UTF_16);   
      	            cell.setCellValue(map.get("orderNo")+"");   
        		 }else if(key.equals("orderDate")){
         			// 创建第i个单元格  
       	            HSSFCell cell = row.createCell((short) 1);   
       	            //cell.setEncoding(HSSFCell.ENCODING_UTF_16);   
       	            cell.setCellValue(map.get("orderDate")+"");   
         		 }else if(key.equals("orderStatus")){
         			// 创建第i个单元格  
       	            HSSFCell cell = row.createCell((short) 2);   
       	            //cell.setEncoding(HSSFCell.ENCODING_UTF_16);   
       	            cell.setCellValue(map.get("orderStatus")+"");   
         		 }else if(key.equals("username")){
         			// 创建第i个单元格  
       	            HSSFCell cell = row.createCell((short) 3);   
       	            //cell.setEncoding(HSSFCell.ENCODING_UTF_16);   
       	            cell.setCellValue(map.get("username")+"");   
         		 }else if(key.equals("phone")){
         			// 创建第i个单元格  
       	            HSSFCell cell = row.createCell((short) 4);   
       	            //cell.setEncoding(HSSFCell.ENCODING_UTF_16);   
       	            cell.setCellValue(map.get("phone")+"");   
         		 }else if(key.equals("address")){
         			// 创建第i个单元格  
       	            HSSFCell cell = row.createCell((short) 5);   
       	            //cell.setEncoding(HSSFCell.ENCODING_UTF_16);   
       	            cell.setCellValue(map.get("address")+"");   
         		 }else if(key.equals("totalMoney")){
         			// 创建第i个单元格  
       	            HSSFCell cell = row.createCell((short) 6);   
       	            //cell.setEncoding(HSSFCell.ENCODING_UTF_16);   
       	            cell.setCellValue(map.get("totalMoney")+"");   
         		 }
	        }   
	        rowIndex++;
		}
	    //导出excel到输出流
	    try {
			demoWorkBook.write(out);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}   
	}   
	
	public static void main(String[] args) throws FileNotFoundException {
		String tableTitle="用户信息表";
		String[] heads={"id","用户名","密码"};
		Map u1 = new HashMap();
		u1.put("id", 1);
		u1.put("username", "zhangsan");
		u1.put("password", "ok");
		 
		Map u2 = new HashMap();
		u2.put("id",2);
		u2.put("username", "zhangsan2");
		u2.put("password", "ok2");
		
		List<Map<String,Object>> datas=new ArrayList<Map<String,Object>>();
		datas.add(u2);
		datas.add(u1);
		System.out.println(datas);
		createExcelSheeet(tableTitle, heads, datas,new FileOutputStream("d:/aa.xls"));
	}
}
