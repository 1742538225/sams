package com.id0304.ssy.converter;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;

import org.springframework.core.convert.converter.Converter;

public class DateConverter implements Converter<String, Date> {
	/**
	 * 将jsp页面传来的String类型参数转换为Date规格化参数，再保存进数据库
	 */
	@Override
	public Date convert(String source) {
		try {
			if (source != null) {
				DateFormat df = new SimpleDateFormat("YYYYMMDDHHMMSS");
				df.parse(source);
			}
		} catch (Exception e) {
			// TODO: handle exception
		}
		return null;
	}

}
