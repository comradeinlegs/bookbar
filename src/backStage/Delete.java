package backStage;

import java.util.LinkedHashMap;

public interface Delete {
	public static final String UPLOAD_DIR = "upload";
	public boolean deleteData(String key, String value, String table);
	public boolean deleteData(LinkedHashMap<String, String> info, String table);
	
}
