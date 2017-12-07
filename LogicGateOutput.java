/*
Developed by: Samuel Harper 
Developed for: ECE287:Digital Design final project
Purpose: To take input coordinates for rectangles to be implemented on a VGA Display
	and output the coordinates in combinational logic for VGA display and
	player collision, in VHDL syntax.

*/

package edu.miamioh.harpers6;

import java.util.ArrayList;

public class LogicGateOutput {
	static ArrayList<String> upArrayList = new ArrayList<String>();
	static ArrayList<String> downArrayList = new ArrayList<String>();
	static ArrayList<String> leftArrayList = new ArrayList<String>();
	static ArrayList<String> rightArrayList = new ArrayList<String>();
	
	
	// Maze walls
	public static int[] tLX = {0, 570, 1125,135,1020, 135, 245, 135, 135, 245, 1125, 640, 910, 910, 135, 135, 250, 405, 310, 40 };
	public static int[] tLY = {915, 915, 695, 800, 695, 695, 585, 375,375, 485, 250, 375, 250, 250, 250, 0, 130, 130, 840, 485 };
	public static int[] bRX = {487, 1170, 1170,1060,1060,1060, 1250,180, 560, 1170, 1170, 1065,950, 1170,815, 175, 1170, 445, 355, 135};
	public static int[] bRY = {950, 950, 950,840,840, 740, 630, 630, 415, 525, 525, 415, 415, 295, 295, 295, 175, 295, 910, 525};
	
	// WINNER Letters to be displayed when game ends
	public static int[] tLXLetters = {1054,1028, 1058,948, 766, 948, 767, 766, 948, 767, 589,699, 589,409, 519, 409, 341, 176, 274, 236, 176};
	public static int[] tLYLetters = {558,494,422, 422, 422, 1098, 486, 558, 422, 422, 422, 422, 422,422, 422, 422, 422, 558, 422, 422, 422};
	public static int[] bRXLetters = {1094, 1068, 1094, 988, 806, 486, 916, 916, 1098, 916, 739, 739, 629, 559, 559, 449, 381, 314, 314, 254, 216};
	public static int[] bRYLetters = {598,534, 526, 598, 598, 526, 526, 598, 462, 462, 462, 598, 598, 462, 598, 598,598, 598, 598, 598, 598};
	
	//Goal
	public static int[] tLXGoal = {340};
	public static int[] tLYGoal = {195};
	public static int[] bRXGoal = {380};
	public static int[] bRYGoal = {230};
	
	
	public static void main(String [ ] args){
		System.out.println(">>>MAZE<<<");
		mazeBarCreator(tLX,tLY,bRX,bRY, true);
		
		System.out.println(">>>WINNER LETTERS<<<");
		mazeBarCreator(tLXLetters,tLYLetters,bRXLetters,bRYLetters, false);
		
		System.out.println(">>>Goal<<<");
		mazeBarCreator(tLXGoal,tLYGoal,bRXGoal,bRYGoal, true);
		
		
	}
	
	
	public static void upBarCollision(int topLeftX, int topLeftY, int bottomRightX, int bottomRightY) {
		String up = "NOT(((centerY + 1 >" + topLeftY + "-20 AND centerY + 1 < " + bottomRightY + "+ 20) AND (centerX > " + topLeftX + " - 20 AND centerX < " + bottomRightX + " + 20)))";
		upArrayList.add(up);
	}
	
	public static void downBarCollision(int topLeftX, int topLeftY, int bottomRightX, int bottomRightY) {
		String down = "NOT(((centerY - 1 >" + topLeftY + "-20 AND centerY - 1 < " + bottomRightY + "+ 20) AND (centerX > " + topLeftX + " - 20 AND centerX < " + bottomRightX + " + 20)))";
		downArrayList.add(down);
	}
	
	public static void leftBarCollision(int topLeftX, int topLeftY, int bottomRightX, int bottomRightY) {
		String left = "NOT(((centerX + 1 >" + topLeftX + "-20 AND centerX + 1 < " + bottomRightX + "+ 20) AND (centerY > " + topLeftY + " - 20 AND centerY < " + bottomRightY + " + 20)))";
		leftArrayList.add(left);
	}
	
	public static void rightBarCollision(int topLeftX, int topLeftY, int bottomRightX, int bottomRightY) {
		String right = "NOT(((centerX - 1 >" + topLeftX + "-20 AND centerX - 1 < " + bottomRightX + "+ 20) AND (centerY > " + topLeftY + " - 20 AND centerY < " + bottomRightY + " + 20)))";
		rightArrayList.add(right);
	}
	
	public static void mazeBarCreator(int[] topLeftX, int[] topLeftY, int[] bottomRightX, int[] bottomRightY, boolean isMaze){
		
		if (isMaze == true ) {
			for (int i=0; i < topLeftX.length; i++) {
				upBarCollision(topLeftX[i],topLeftY[i],bottomRightX[i], bottomRightY[i]);
				downBarCollision(topLeftX[i],topLeftY[i],bottomRightX[i], bottomRightY[i]);
				leftBarCollision(topLeftX[i],topLeftY[i],bottomRightX[i], bottomRightY[i]);
				rightBarCollision(topLeftX[i],topLeftY[i],bottomRightX[i], bottomRightY[i]);
			}
			System.out.println("Up:");
			System.out.println(returnUp());
			System.out.println();
			System.out.println("Down:");
			System.out.println(returnDown());
			System.out.println();
			System.out.println("Left:");
			System.out.println(returnLeft());
			System.out.println();
			System.out.println("Right:");
			System.out.println(returnRight());
			System.out.println();
			System.out.println("Elsif:");
			System.out.println(returnElsif(topLeftX,topLeftY,bottomRightX, bottomRightY));	
			System.out.println();
			System.out.println("_______________________________________________________");
			System.out.println();
			System.out.println();
		} else {
			System.out.println("Elsif:");
			System.out.println(returnElsif(topLeftX,topLeftY,bottomRightX, bottomRightY));
			System.out.println();
			System.out.println("_______________________________________________________");
		}
		
	}
	
	public static String returnElsif(int[] topLeftX, int[] topLeftY, int[] bottomRightX, int[] bottomRightY){
		String returnValue = "ELSIF(";
		for (int j=0; j < topLeftX.length; j++) {
			returnValue = returnValue + "((row > " + topLeftX[j] + " AND row < " + bottomRightX[j] + ") AND (column > " + topLeftY[j] + " AND column < " + bottomRightY[j] + ")) OR ";
		}
		returnValue = returnValue.substring(0, returnValue.length() - 4) + ") THEN";
		return returnValue;
	}
	
	public static String returnUp(){
		String returnValue = "AND ";
		for (String s: upArrayList) {
			returnValue = returnValue + s + " AND ";
		}
		returnValue = returnValue.substring(0, returnValue.length() - 5) + " THEN";
		return returnValue;
	}
	
	public static String returnDown(){
		String returnValue = "AND ";
		for (String s: downArrayList) {
			returnValue = returnValue + s + " AND ";
		}
		returnValue = returnValue.substring(0, returnValue.length() - 5) + " THEN";
		return returnValue;
	}
	
	public static String returnLeft(){
		String returnValue = "AND ";
		for (String s: leftArrayList) {
			returnValue = returnValue + s + " AND ";
		}
		returnValue = returnValue.substring(0, returnValue.length() - 5) + " THEN";
		return returnValue;
	}
	
	public static String returnRight(){
		String returnValue = "AND ";
		for (String s: rightArrayList) {
			returnValue = returnValue + s + " AND ";
		}
		returnValue = returnValue.substring(0, returnValue.length() - 5) + " THEN";
		return returnValue;
	}
	
	
}
