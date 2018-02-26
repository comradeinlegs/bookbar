package tool;
import java.util.UUID;

public class UUCode {
	
	public static String generateCode() {
		return UUID.randomUUID().toString().replaceAll("-", "");
	}
}
