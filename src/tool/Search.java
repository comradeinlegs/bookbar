package tool;

public class Search {
	
	
	//判断关键词是否均在aim中
	public static boolean isMatch(String keyword, String aim) {
		char[] s1 = keyword.toCharArray();
		char[] s2 = aim.toCharArray();
		int cnt = 0;
		for(int i = 0; i < s2.length; i++) {
			if(s1[cnt] == s2[i]) {
				cnt++;
			}
			if(cnt == s1.length) {
				return true;
			}
		}
		
		return false;
	}

}
