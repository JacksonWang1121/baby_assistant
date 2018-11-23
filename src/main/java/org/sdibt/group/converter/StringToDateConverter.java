package org.sdibt.group.converter;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;
/**
 * 
 * Title:StringToDateConverter
 * @author hanfangfang
 * date:2018年8月28日 上午11:15:14
 * package:org.sdibt.group.converter
 * version 1.0
 */

public class StringToDateConverter implements Converter<String,Date>{

	@Override
	public Date convert(String source) {
		Date date=null;
		// TODO Auto-generated method stub
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd");
		try {
			date= df.parse(source);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return date;
	}
}
