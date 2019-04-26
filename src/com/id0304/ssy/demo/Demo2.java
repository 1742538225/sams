package com.id0304.ssy.demo;

import org.junit.Test;

public class Demo2 {
	@Test
	public void demo() {
		for (int i = 1; i <= 7; ++i) {
			for (int j = 1; j <= 10; j += 2)
				System.out.println("if (this.getC_"+i+"_"+j+""+(j+1)+"()!=null) {list.add(Integer.parseInt(this.getC_"+i+"_"+j+""+(j+1)+"().substring(0,this.getC_"+i+"_"+j+""+(j+1)+"().indexOf(' '))));}");
		}
	}
	
	@Test
	public void demo2() {
		String s = "123 456";
		System.out.println(Integer.parseInt(s.substring(0, s.indexOf(" "))));
	}
}
