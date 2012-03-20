package com.sang.test;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;

public class BitMapTest {

	/**
	 * @param args
	 * @throws FileNotFoundException 
	 */
	public static void main(String[] args) throws FileNotFoundException {
		InputStream in = new FileInputStream("/sdcard/cameratake.jpg");
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		byte[] b = new byte[1024];
		try {
			while(in.read(b)!=-1){
				baos.write(b);
			}
		} catch (IOException e) {
		}
		
	}

}
