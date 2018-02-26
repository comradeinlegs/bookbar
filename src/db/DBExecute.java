package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Iterator;
import java.util.LinkedHashMap;

public class DBExecute {
	
	//向table中插入数据
	public static boolean insert(LinkedHashMap<String, String> info, String table) {
		Connection connection = DBConn.getConn();
		PreparedStatement pStatement = null;
		String sql = "INSERT INTO " + table + "(";
		Iterator<String> keyIter = info.keySet().iterator();
		while(keyIter.hasNext()) {
			sql += keyIter.next();
			if(keyIter.hasNext()) {
				sql += ",";
			}
			else {
				break;
			}
		}
		sql += ") VALUES(";
		Iterator<String> valueIter = info.values().iterator();
		while(valueIter.hasNext()) {
			sql += ("'" + valueIter.next() + "'");
			if(valueIter.hasNext()) {
				sql += ",";
			}
			else {
				sql += ")";
				break;
			}
		}
		try {
			pStatement = connection.prepareStatement(sql);
			if(pStatement.executeUpdate() > 0) {
				return true;
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			DBClose.close(connection, pStatement);
		}
		return false;
	}
	
	//判断数据是否在table中
	public static boolean hasExist(LinkedHashMap<String, String> info, String table) {
		Connection connection = DBConn.getConn();
		PreparedStatement pStatement = null;
		ResultSet rSet = null;
		String sql = "SELECT * FROM " + table + " where ";
		Iterator<String> keyIter = info.keySet().iterator();
		while(keyIter.hasNext()) {
			String key = keyIter.next();
			sql += (key + "='" + info.get(key) + "'");
			if(keyIter.hasNext()) {
				sql += " and ";
			}
			else {
				break;
			}
		}
		try {
			pStatement = connection.prepareStatement(sql);
			rSet = pStatement.executeQuery();
			if(rSet.next()) {
				return true;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DBClose.close(connection, pStatement, rSet);
		}
		return false;
	}
	
	public static boolean hasExist(String key, String value, String table) {
		Connection connection = DBConn.getConn();
		PreparedStatement pStatement = null;
		ResultSet rSet = null;
		String sql = "SELECT * FROM " + table + " where " + key + "='" + value + "'";
		try {
			pStatement = connection.prepareStatement(sql);
			rSet = pStatement.executeQuery();
			if(rSet.next()) {
				return true;
			}
		}
		catch (SQLException e) {
			e.printStackTrace();
		}
		finally {
			DBClose.close(connection, pStatement, rSet);
		}
		return false;
	}
	
	//将数据从table提取出来
	public static ArrayList<LinkedHashMap<String, String>> extractInfo(String mainKey, String mainValue, String table){
		Connection connection = DBConn.getConn();
		PreparedStatement pStatement = null;
		ResultSet rSet = null;
		String sql = "";
		if(mainKey.equals("") && mainValue.equals("")) {
			sql = "SELECT * FROM " + table;
		}
		else {
			sql = "SELECT * FROM " + table + " where " + mainKey + "='" + mainValue + "'";
		}
		try {
			pStatement = connection.prepareStatement(sql);
			rSet = pStatement.executeQuery();
			ResultSetMetaData data = rSet.getMetaData();
			ArrayList<LinkedHashMap<String, String>> infos = new ArrayList<LinkedHashMap<String, String>>();
			while(rSet.next()) {
				LinkedHashMap<String, String> info = new LinkedHashMap<String, String>();
				for(int i = 1; i <= data.getColumnCount(); i++) {
					info.put(data.getColumnName(i), rSet.getString(i));
				}
				infos.add(info);
			}
			return infos;
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			DBClose.close(connection, pStatement, rSet);
		}
		return null;
	}
	
	//更新table中的数据
	public static boolean update(LinkedHashMap<String, String> info, String posKey, String posValue, String table) {
		Connection connection = DBConn.getConn();
		PreparedStatement pStatement = null;
		String sql = "UPDATE " + table + " SET ";
		Iterator<String> keyIter = info.keySet().iterator();
		while(keyIter.hasNext()) {
			String key = keyIter.next();
			sql += (key + "='" + info.get(key) + "'");
			if(keyIter.hasNext()) {
				sql += ",";
			}
			else {
				break;
			}
		}
		sql += (" WHERE " + posKey + "='" + posValue + "'");
		try {
			pStatement = connection.prepareStatement(sql);
			if(pStatement.executeUpdate() > 0) {
				return true;
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			DBClose.close(connection, pStatement);
		}
		return false;
	}
	
	public static boolean update(String key, String newValue, String posKey, String posValue, String table) {
		Connection connection = DBConn.getConn();
		PreparedStatement pStatement = null;
		String sql = "UPDATE " + table + " SET " + key + "='" + newValue + "' WHERE " + posKey + "='" + posValue + "'";
		try {
			pStatement = connection.prepareStatement(sql);
			if(pStatement.executeUpdate() > 0) {
				return true;
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			DBClose.close(connection, pStatement);
		}
		return false;
	}
	
	//从table中删除数据
	public static boolean delete(String posKey, String posValue, String table) {
		Connection connection = DBConn.getConn();
		PreparedStatement pStatement = null;
		String sql = "DELETE FROM " + table + " WHERE " + posKey + "='" + posValue + "'";
		try {
			pStatement = connection.prepareStatement(sql);
			if(pStatement.executeUpdate() > 0) {
				return true;
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			DBClose.close(connection, pStatement);
		}
		return false;
	}
	
	public static boolean delete(LinkedHashMap<String, String> info, String table) {
		Connection connection = DBConn.getConn();
		PreparedStatement pStatement = null;
		String sql = "DELETE FROM " + table + " WHERE ";
		Iterator<String> keyIter = info.keySet().iterator();
		while(keyIter.hasNext()) {
			String key = keyIter.next();
			sql += (key + "='" + info.get(key) + "'");
			if(keyIter.hasNext()) {
				sql += " and ";
			}
			else {
				break;
			}
		}
		System.out.println(sql);
		try {
			pStatement = connection.prepareStatement(sql);
			if(pStatement.executeUpdate() > 0) {
				return true;
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			DBClose.close(connection, pStatement);
		}
		return false;
	}
	
	//table中有多少条mainKey=mainValue的数据
	public static int totalNum(String mainKey, String mainValue, String table){
		Connection connection = DBConn.getConn();
		PreparedStatement pStatement = null;
		ResultSet rSet = null;
		String sql = "";
		if(mainKey.equals("") && mainValue.equals("")) {
			sql = "SELECT * FROM " + table;
		}
		else {
			sql = "SELECT * FROM " + table + " where " + mainKey + "='" + mainValue + "'";
		}
		int cnt = 0;
		try {
			pStatement = connection.prepareStatement(sql);
			rSet = pStatement.executeQuery();
			while(rSet.next()) {
				cnt++;
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			DBClose.close(connection, pStatement, rSet);
		}
		return cnt;
	}
	
	public static int extractID(String mainKey, String mainValue, String table) {
		Connection connection = DBConn.getConn();
		PreparedStatement pStatement = null;
		ResultSet rSet = null;
		String sql = "SELECT * FROM " + table + " where " + mainKey + "='" + mainValue + "'";
		try {
			pStatement = connection.prepareStatement(sql);
			rSet = pStatement.executeQuery();
			if(rSet.next()) {
				return rSet.getInt(1);
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
		finally {
			DBClose.close(connection, pStatement, rSet);
		}
		return 0;
	}

}
