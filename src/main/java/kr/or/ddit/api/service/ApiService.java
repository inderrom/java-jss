package kr.or.ddit.api.service;

import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Map;

public interface ApiService {
	public Map<String, Object> getJson(String url);
	
	public void sendSMS(Map<String, String> map);

	String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey)
			throws NoSuchAlgorithmException, InvalidKeyException;

	String sendCertificationNumber(String sender);

	void sendEmail(Map<String, String> map);

	public String sendCertificationNumberEmail(String recipient);

	public void sendForgotPassEmail(String recipient);

	void passEmail(Map<String, String> map);

	void failEmail(Map<String, String> map);
}
