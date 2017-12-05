package edu.miamioh.harpers6;

import java.awt.image.BufferedImage;
import java.awt.image.DataBufferByte;
import java.awt.image.WritableRaster;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.IOException;
import java.util.ArrayList;

import javax.imageio.ImageIO;



public class ImageToBytes {
	
	
	public static void main(String [ ] args) throws IOException{
		File file = new File("maze1.jpg");
		BufferedImage image=ImageIO.read(file);
		image.getRGB(2, 2);
		int width = image.getWidth();
	    int height = image.getHeight();
	    
	    int[][] binaryPixels = new int[1080][1280];
		
	    System.out.print("(");
		for (int i = 0; i < height; i++) {
			System.out.print("(");
			for (int j = 0; j < width; j++) {
				int pixelValue = image.getRGB(j, i);
			    int redPixel = (pixelValue >> 16) & 0xff;
			    
			    if (redPixel > 0) {
			    	binaryPixels[i][j] = 1;
			    } else {
			    	binaryPixels[i][j] = 0;
			    }
			    
			    System.out.print(binaryPixels[i][j]);

			    if (j != 1279) {
			    	System.out.print(",");
			    }
		    }
			System.out.print("),");
		    
		}
	}
	
}
