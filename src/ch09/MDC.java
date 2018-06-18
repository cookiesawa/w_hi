package ch09;

import java.security.MessageDigest;
import java.security.NoSuchAlgorithmException;
import java.security.SecureRandom;
import java.util.Base64;
import java.util.Base64.Encoder;
// 메시지 다이제스트
public class MDC {
	
	public MDC() {
		
	}

	public static void main(String[] args) throws NoSuchAlgorithmException {
		

		// salt 생성
		SecureRandom random = new SecureRandom();
		byte[] salt = new byte[16];
		random.nextBytes(salt);

		// hash할 메시지
		String password = "1234";

		// MessageDigest 생성
		MessageDigest md = MessageDigest.getInstance("SHA-256");
		md.update(password.getBytes());
		md.update(salt);

		byte[] digest = md.digest();

		// 저장을 위해 ASCII Code로 인코딩
		Encoder encoder = Base64.getEncoder();

		System.out.println("DIGEST : " + encoder.encodeToString(digest));
		System.out.println("SALT : " + encoder.encodeToString(salt));

	}

}
