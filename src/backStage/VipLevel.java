package backStage;

import java.util.ArrayList;
import java.util.Comparator;
import java.util.LinkedHashMap;

import db.DBExecute;

public class VipLevel {
	
	public static String judgeLevel(int consume) {
		ArrayList<LinkedHashMap<String, String>> levels = DBExecute.extractInfo("", "", "vipLevel");
		Comparator<LinkedHashMap<String, String>> comparator = new Comparator<LinkedHashMap<String, String>>() {

			@Override
			public int compare(LinkedHashMap<String, String> arg0, LinkedHashMap<String, String> arg1) {
				if(Integer.parseInt(arg0.get("leastConsume")) < Integer.parseInt(arg1.get("leastConsume"))) {
					return 1;
				}
				return -1;
			}
			
		};
		levels.sort(comparator);
		for(LinkedHashMap<String, String> level : levels) {
			if(consume >= Integer.parseInt(level.get("leastConsume"))) {
				return level.get("name");
			}
		}
		return "";
	}
	
}
