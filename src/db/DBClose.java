package db;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class DBClose {
	
	//插入、更新后
	public static void close(Connection connection, PreparedStatement pStatement) {
		try {
			if(connection != null) {
				connection.close();
			}
			if(pStatement != null) {
				pStatement.close();
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}
	
	//查询后
	public static void close(Connection connection, PreparedStatement pStatement, ResultSet rSet) {
		try {
			if(connection != null) {
				connection.close();
			}
			if(pStatement != null) {
				pStatement.close();
			}
			if(rSet != null) {
				rSet.close();
			}
		}
		catch(SQLException e) {
			e.printStackTrace();
		}
	}
}
