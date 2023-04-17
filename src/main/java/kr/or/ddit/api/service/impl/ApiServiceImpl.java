package kr.or.ddit.api.service.impl;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.UnsupportedEncodingException;
import java.net.HttpURLConnection;
import java.net.URL;
import java.security.InvalidKeyException;
import java.security.NoSuchAlgorithmException;
import java.util.Base64;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

import javax.crypto.Mac;
import javax.crypto.spec.SecretKeySpec;
import javax.mail.internet.MimeMessage;
import javax.swing.text.html.HTML;

import org.apache.commons.lang.math.RandomUtils;
import org.json.JSONArray;
import org.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.mail.javamail.MimeMessagePreparator;
import org.springframework.stereotype.Service;

import com.fasterxml.jackson.databind.ObjectMapper;

import kr.or.ddit.api.service.ApiService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@Service
public class ApiServiceImpl implements ApiService {
	private final JavaMailSender mailSender;
	
	@Autowired
	public ApiServiceImpl(JavaMailSender mailSender) {
		this.mailSender = mailSender;
	}
	
	@Override
	public Map<String, Object> getJson(String url) {
		try {
            URL rurl = new URL(url);
            HttpURLConnection con = (HttpURLConnection) rurl.openConnection();
            con.setConnectTimeout(5000); //서버에 연결되는 Timeout 시간 설정
            con.setReadTimeout(5000); // InputStream 읽어 오는 Timeout 시간 설정
            con.setRequestMethod("GET");

            StringBuilder sb = new StringBuilder();
            if (con.getResponseCode() == HttpURLConnection.HTTP_OK) {
                BufferedReader br = new BufferedReader(
                        new InputStreamReader(con.getInputStream(), "utf-8"));
                String line;
                while ((line = br.readLine()) != null) {
                    sb.append(line).append("\n");
                }
                br.close();
                
                ObjectMapper ob = new ObjectMapper();
                Map<String, Object> map = ob.readValue(sb.toString(), Map.class);
                
                log.debug("string : {}" , sb);
                log.debug("map : {}", map);
                return map;
            } else {
                log.debug(con.getResponseMessage());
            }

        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
		
		return null;
	}
	
	public Map<String, Object> getAvgSalary(String url){
		  return null;
	}
	
	// https://api.ncloud-docs.com/docs/common-ncpapi
	@Override
	public String makeSignature(String url, String timestamp, String method, String accessKey, String secretKey) throws NoSuchAlgorithmException, InvalidKeyException {
	    String space = " ";                    // one space
	    String newLine = "\n";                 // new line
	    

	    String message = new StringBuilder()
	        .append(method)
	        .append(space)
	        .append(url)
	        .append(newLine)
	        .append(timestamp)
	        .append(newLine)
	        .append(accessKey)
	        .toString();

	    SecretKeySpec signingKey;
	    String encodeBase64String;
		try {
			
			signingKey = new SecretKeySpec(secretKey.getBytes("UTF-8"), "HmacSHA256");
			Mac mac = Mac.getInstance("HmacSHA256");
			mac.init(signingKey);
			byte[] rawHmac = mac.doFinal(message.getBytes("UTF-8"));
		    encodeBase64String = Base64.getEncoder().encodeToString(rawHmac);
		} catch (UnsupportedEncodingException e) {
			encodeBase64String = e.toString();
		}
	    

	  return encodeBase64String;
	}
		
	@Override
	public void sendSMS(Map<String, String> map) {
		String hostNameUrl = "https://sens.apigw.ntruss.com";   // 호스트 URL
		String requestUrl= "/sms/v2/services/";                 // 요청 URL
		String requestUrlType = "/messages";                    // 요청 URL
		String accessKey = "개인 인증키";                     	// 네이버 클라우드 플랫폼 회원에게 발급되는 개인 인증키			// Access Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID
		String secretKey = "secret key";  						// 2차 인증을 위해 서비스마다 할당되는 service secret key	// Service Key : https://www.ncloud.com/mypage/manage/info > 인증키 관리 > Access Key ID	
		String serviceId = "SMS 서비스 ID";       				// 프로젝트에 할당된 SMS 서비스 ID							// service ID : https://console.ncloud.com/sens/project > Simple & ... > Project > 서비스 ID
		String method = "POST";											// 요청 method
		String timestamp = Long.toString(System.currentTimeMillis()); 	// current timestamp (epoch)
		requestUrl += serviceId + requestUrlType;
		String apiUrl = hostNameUrl + requestUrl;
		
		// JSON 을 활용한 body data 생성
		JSONObject bodyJson = new JSONObject();
		JSONObject toJson = new JSONObject();
	    JSONArray  toArr = new JSONArray();

	    //toJson.put("subject","");							// Optional, messages.subject	개별 메시지 제목, LMS, MMS에서만 사용 가능
	    //toJson.put("content","sms test in spring 111");	// Optional, messages.content	개별 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
	    toJson.put("to", map.get("sender"));						// Mandatory(필수), messages.to	수신번호, -를 제외한 숫자만 입력 가능
	    toArr.put(toJson);
	    
	    bodyJson.put("type","SMS");							// Madantory, 메시지 Type (SMS | LMS | MMS), (소문자 가능)
	    //bodyJson.put("contentType","");					// Optional, 메시지 내용 Type (AD | COMM) * AD: 광고용, COMM: 일반용 (default: COMM) * 광고용 메시지 발송 시 불법 스팸 방지를 위한 정보통신망법 (제 50조)가 적용됩니다.
	    //bodyJson.put("countryCode","82");					// Optional, 국가 전화번호, (default: 82)
	    bodyJson.put("from","보내는 전화번호");					// Mandatory, 발신번호, 사전 등록된 발신번호만 사용 가능		
	    //bodyJson.put("subject","");						// Optional, 기본 메시지 제목, LMS, MMS에서만 사용 가능
	    bodyJson.put("content", map.get("content"));	// Mandatory(필수), 기본 메시지 내용, SMS: 최대 80byte, LMS, MMS: 최대 2000byte
	    bodyJson.put("messages", toArr);					// Mandatory(필수), 아래 항목들 참조 (messages.XXX), 최대 1,000개
	    
	    //String body = bodyJson.toJSONString();
	    String body = bodyJson.toString();
	    
	    log.debug(body);
	    
        try {
            URL url = new URL(apiUrl);

            HttpURLConnection con = (HttpURLConnection)url.openConnection();
            con.setUseCaches(false);
            con.setDoOutput(true);
            con.setDoInput(true);
            con.setRequestProperty("content-type", "application/json");
            con.setRequestProperty("x-ncp-apigw-timestamp", timestamp);
            con.setRequestProperty("x-ncp-iam-access-key", accessKey);
            con.setRequestProperty("x-ncp-apigw-signature-v2", makeSignature(requestUrl, timestamp, method, accessKey, secretKey));
            con.setRequestMethod(method);
            con.setDoOutput(true);
            DataOutputStream wr = new DataOutputStream(con.getOutputStream());
            
            wr.write(body.getBytes());
            wr.flush();
            wr.close();

            int responseCode = con.getResponseCode();
            BufferedReader br;
            log.debug("responseCode" +" " + responseCode);
            if(responseCode == 202) { // 정상 호출
                br = new BufferedReader(new InputStreamReader(con.getInputStream()));
            } else { // 에러 발생
                br = new BufferedReader(new InputStreamReader(con.getErrorStream()));
            }

            String inputLine;
            StringBuilder response = new StringBuilder();
            while ((inputLine = br.readLine()) != null) {
                response.append(inputLine);
            }
            br.close();
            
            log.debug("response : {}", response);

        } catch (Exception e) {
            log.error(e.getMessage(), e);
        }
	}
	
	@Override
	public String sendCertificationNumber(String sender) {
		Map<String, String> map = new HashMap<>();
		
		StringBuilder bld =  new StringBuilder();
		for(int i = 0; i < 6; i++) {
			bld.append(RandomUtils.nextInt(10));
		}
		String certificationNumber = bld.toString();
		
		map.put("sender", sender);
		map.put("content", String.format("[잡아줄게] 인증번호 [ %s ]를 입력해주세요.", certificationNumber));
		
		this.sendSMS(map);
		
		return certificationNumber;
	}
	
	
    @Override
    public void sendEmail(Map<String, String> map) {
 
        final MimeMessagePreparator preparator = new MimeMessagePreparator() {
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");
                
                helper.setFrom("보내는 이메일"); // sender
                helper.setTo(map.get("recipient")); // recipient
                helper.setSubject(map.get("mailTitle")); // mail title
                helper.setText(map.get("mailContent"), true); // mail content
            }
        };
 
        mailSender.send(preparator);
    }

	@Override
	public String sendCertificationNumberEmail(String recipient) {
		
		StringBuilder bld = new StringBuilder();
		for(int i = 0; i < 6; i++) {
			bld.append(RandomUtils.nextInt(10));
		}
		String certificationNumber = bld.toString();
		
		String content = 
				"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n" + 
				"<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n" + 
				"<head><!--[if gte mso 9]><xml><o:OfficeDocumentSettings><o:AllowPNG/><o:PixelsPerInch>96</o:PixelsPerInch>\r\n" + 
				"  </o:OfficeDocumentSettings>\r\n" + 
				"</xml>\r\n" + 
				"<![endif]-->\r\n" + 
				"  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n" + 
				"  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n" + 
				"  <meta name=\"x-apple-disable-message-reformatting\">\r\n" + 
				"  <!--[if !mso]><!--><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><!--<![endif]-->\r\n" + 
				"  <title></title>\r\n" + 
				"  \r\n" + 
				"    <style type=\"text/css\">\r\n" + 
				"      @media only screen and (min-width: 620px) {\r\n" + 
				"  .u-row {\r\n" + 
				"    width: 600px !important;\r\n" + 
				"  }\r\n" + 
				"  .u-row .u-col {\r\n" + 
				"    vertical-align: top;\r\n" + 
				"  }\r\n" + 
				"\r\n" + 
				"  .u-row .u-col-50 {\r\n" + 
				"    width: 300px !important;\r\n" + 
				"  }\r\n" + 
				"\r\n" + 
				"  .u-row .u-col-100 {\r\n" + 
				"    width: 600px !important;\r\n" + 
				"  }\r\n" + 
				"\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"@media (max-width: 620px) {\r\n" + 
				"  .u-row-container {\r\n" + 
				"    max-width: 100% !important;\r\n" + 
				"    padding-left: 0px !important;\r\n" + 
				"    padding-right: 0px !important;\r\n" + 
				"  }\r\n" + 
				"  .u-row .u-col {\r\n" + 
				"    min-width: 320px !important;\r\n" + 
				"    max-width: 100% !important;\r\n" + 
				"    display: block !important;\r\n" + 
				"  }\r\n" + 
				"  .u-row {\r\n" + 
				"    width: 100% !important;\r\n" + 
				"  }\r\n" + 
				"  .u-col {\r\n" + 
				"    width: 100% !important;\r\n" + 
				"  }\r\n" + 
				"  .u-col > div {\r\n" + 
				"    margin: 0 auto;\r\n" + 
				"}\r\n" + 
				"body {\r\n" + 
				"  margin: 0;\r\n" + 
				"  padding: 0;\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"table,\r\n" + 
				"tr,\r\n" + 
				"td {\r\n" + 
				"  vertical-align: top;\r\n" + 
				"  border-collapse: collapse;\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"p {\r\n" + 
				"  margin: 0;\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				".ie-container table,\r\n" + 
				".mso-container table {\r\n" + 
				"  table-layout: fixed;\r\n" + 
				"}\r\n" + 
				"* {\r\n" + 
				"  line-height: inherit;\r\n" + 
				"}\r\n" + 
				"a[x-apple-data-detectors='true'] {\r\n" + 
				"  color: inherit !important;\r\n" + 
				"  text-decoration: none !important;\r\n" + 
				"}\r\n" + 
				"table, td { color: #000000; } #u_body a { color: #161a39; text-decoration: underline; }\r\n" + 
				"    </style>\r\n" + 
				"<!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Lato:400,700&display=swap\" rel=\"stylesheet\" type=\"text/css\"><!--<![endif]-->\r\n" + 
				"</head>\r\n" + 
				"<body class=\"clean-body u_body\" style=\"margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #f9f9f9;color: #000000\">\r\n" + 
				"  <!--[if IE]><div class=\"ie-container\"><![endif]-->\r\n" + 
				"  <!--[if mso]><div class=\"mso-container\"><![endif]-->\r\n" + 
				"  <table id=\"u_body\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #f9f9f9;width:100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"  <tr style=\"vertical-align: top\">\r\n" + 
				"    <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\r\n" + 
				"    <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" style=\"background-color: #f9f9f9;\"><![endif]-->\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: #f9f9f9\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #f9f9f9;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: #f9f9f9;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #f9f9f9;\"><![endif]-->\r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:15px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"  <table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 1px solid #f9f9f9;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\r\n" + 
				"    <tbody>\r\n" + 
				"      <tr style=\"vertical-align: top\">\r\n" + 
				"        <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\r\n" + 
				"          <span>&#160;</span>\r\n" + 
				"        </td>\r\n" + 
				"      </tr>\r\n" + 
				"    </tbody>\r\n" + 
				"  </table>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ffffff;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #ffffff;\"><![endif]-->\r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:20px 10px 10px 15px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n" + 
				"  <tr>\r\n" + 
				"    <td style=\"padding-right: 0px;padding-left: 0px;\" align=\"center\">\r\n" + 
				"    </td>\r\n" + 
				"  </tr>\r\n" + 
				"</table>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 10px 30px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"<img align=\"center\" border=\"0\" src=\"https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2FbGfDGx%2Fbtr72Y74XUJ%2FjIeCCz0anBlmr5ULP2FCYk%2Fimg.png\" alt=\"image\" title=\"image\" style=\"outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;clear: both;display: inline-block !important;border: none;height: auto;float: none;width: 74%;max-width: 444px;\" width=\"444\" class=\"v-src-width v-src-max-width\"/>\r\n" + 
				"    <p style=\"line-height: 140%;\"><span style=\"font-size: 24px; line-height: 28px;\"><strong>JOB LUV</strong></span></p>\r\n" + 
				"  </div>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #344767;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #344767;\"><![endif]-->\r\n" + 
				"      \r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"  \r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:35px 10px 10px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n" + 
				"  <tr>\r\n" + 
				"    <td style=\"padding-right: 0px;padding-left: 0px;\" align=\"center\">\r\n" + 
				"    </td>\r\n" + 
				"  </tr>\r\n" + 
				"</table>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 10px 30px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"font-size: 14px; line-height: 140%; text-align: center;\"><strong><span style=\"color: #ecf0f1; line-height: 42px; font-size: 30px;\">인증 메일</span></strong></p>\r\n" + 
				"  </div>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ffffff;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #ffffff;\"><![endif]-->\r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:40px 40px 50px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"line-height: 140%;\"><br />안녕하세요. 잡아줄게입니다.<br />" + recipient +" 계정으로 회원가입 하시려면</p>\r\n" + 
				"<p style=\"line-height: 140%;\">아래의 인증번호를 정확히 입력해주세요.</p>\r\n" + 
				"<p style=\"line-height: 140%;\"> </p>\r\n" + 
				"<p style=\"line-height: 140%;\">문의 사항은 ddit@ddit.or.kr로 연락 주시기 바랍니다 :)</p>\r\n" + 
				"  </div>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 40px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"  <!--[if mso]><style>.v-button {background: transparent !important;}</style><![endif]-->\r\n" + 
				"<div align=\"left\">\r\n" + 
				"  <!--[if mso]><v:roundrect xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"urn:schemas-microsoft-com:office:word\" href=\"\" style=\"height:47px; v-text-anchor:middle; width:181px;\" arcsize=\"2%\"  stroke=\"f\" fillcolor=\"#344767\"><w:anchorlock/><center style=\"color:#FFFFFF;font-family:'Lato',sans-serif;\"><![endif]-->  \r\n" + 
				"    <p class=\"v-button\" style=\"box-sizing: border-box;display: inline-block;font-family:'Lato',sans-serif;text-decoration: none;-webkit-text-size-adjust: none;text-align: center;color: #FFFFFF; background-color: #344767; border-radius: 1px;-webkit-border-radius: 1px; -moz-border-radius: 1px; width:auto; max-width:100%; overflow-wrap: break-word; word-break: break-word; word-wrap:break-word; mso-border-alt: none;font-size: 14px;\">\r\n" + 
				"      <span style=\"display:block;padding:15px 40px;line-height:120%;\">" + certificationNumber + "</span>\r\n" + 
				"    </p>\r\n" + 
				"  <!--[if mso]></center></v:roundrect><![endif]-->\r\n" + 
				"</div>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:30px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"font-size: 14px; line-height: 140%;\"><br /><span style=\"color: #888888; font-size: 14px; line-height: 19.6px;\"><em><span style=\"font-size: 16px; line-height: 22.4px;\"> </span></em></span></p>\r\n" + 
				"  </div>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #344767;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #344767;\"><![endif]-->\r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"300\" style=\"width: 300px;padding: 20px 20px 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-50\" style=\"max-width: 320px;min-width: 300px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 20px 20px 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"font-size: 14px; line-height: 140%;\"><span style=\"font-size: 16px; line-height: 22.4px; color: #ecf0f1;\">Contact</span></p>\r\n" + 
				"<p style=\"font-size: 14px; line-height: 140%;\"><span style=\"font-size: 14px; line-height: 19.6px; color: #ecf0f1;\">대전광역시 중구 계룡로 846, 3-4층</span></p>\r\n" + 
				"<p style=\"font-size: 14px; line-height: 140%;\"><span style=\"font-size: 14px; line-height: 19.6px; color: #ecf0f1;\">+82 42-222-8202 | ddit@ddit.or.kr</span></p>\r\n" + 
				"  </div>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"300\" style=\"width: 300px;padding: 0px 0px 0px 20px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-50\" style=\"max-width: 320px;min-width: 300px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px 0px 0px 20px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:25px 10px 10px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"<div align=\"left\">\r\n" + 
				"  <div style=\"display: table; max-width:187px;\">\r\n" + 
				"  <!--[if (mso)|(IE)]><table width=\"187\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"border-collapse:collapse;\" align=\"left\"><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"border-collapse:collapse; mso-table-lspace: 0pt;mso-table-rspace: 0pt; width:187px;\"><tr><![endif]-->\r\n" + 
				"    <!--[if (mso)|(IE)]><td width=\"32\" style=\"width:32px; padding-right: 15px;\" valign=\"top\"><![endif]-->\r\n" + 
				"    <table align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"32\" height=\"32\" style=\"width: 32px !important;height: 32px !important;display: inline-block;border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;margin-right: 15px\">\r\n" + 
				"      <tbody><tr style=\"vertical-align: top\"><td align=\"left\" valign=\"middle\" style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\r\n" + 
				"      </td></tr>\r\n" + 
				"    </tbody></table>\r\n" + 
				"    <!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"    <!--[if (mso)|(IE)]><td width=\"32\" style=\"width:32px; padding-right: 15px;\" valign=\"top\"><![endif]-->\r\n" + 
				"    <table align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"32\" height=\"32\" style=\"width: 32px !important;height: 32px !important;display: inline-block;border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;margin-right: 15px\">\r\n" + 
				"      <tbody><tr style=\"vertical-align: top\"><td align=\"left\" valign=\"middle\" style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\r\n" + 
				"      </td></tr>\r\n" + 
				"    </tbody></table>\r\n" + 
				"    <!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"    <!--[if (mso)|(IE)]><td width=\"32\" style=\"width:32px; padding-right: 15px;\" valign=\"top\"><![endif]-->\r\n" + 
				"    <table align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"32\" height=\"32\" style=\"width: 32px !important;height: 32px !important;display: inline-block;border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;margin-right: 15px\">\r\n" + 
				"      <tbody><tr style=\"vertical-align: top\"><td align=\"left\" valign=\"middle\" style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\r\n" + 
				"      </td></tr>\r\n" + 
				"    </tbody></table>\r\n" + 
				"    <!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"    <!--[if (mso)|(IE)]><td width=\"32\" style=\"width:32px; padding-right: 0px;\" valign=\"top\"><![endif]-->\r\n" + 
				"    <table align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"32\" height=\"32\" style=\"width: 32px !important;height: 32px !important;display: inline-block;border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;margin-right: 0px\">\r\n" + 
				"      <tbody><tr style=\"vertical-align: top\"><td align=\"left\" valign=\"middle\" style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\r\n" + 
				"      </td></tr>\r\n" + 
				"    </tbody></table>\r\n" + 
				"    <!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"    <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:5px 10px 10px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"line-height: 140%; font-size: 14px;\"><span style=\"font-size: 14px; line-height: 19.6px;\"><span style=\"color: #ecf0f1; font-size: 14px; line-height: 19.6px;\"><span style=\"line-height: 19.6px; font-size: 14px;\">Company ©  All Rights Reserved</span></span></span></p>\r\n" + 
				"  </div>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: #f9f9f9\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #344767;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: #f9f9f9;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #344767;\"><![endif]-->\r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:15px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"  <table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 1px solid #1c103b;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\r\n" + 
				"    <tbody>\r\n" + 
				"      <tr style=\"vertical-align: top\">\r\n" + 
				"        <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\r\n" + 
				"          <span>&#160;</span>\r\n" + 
				"        </td>\r\n" + 
				"      </tr>\r\n" + 
				"    </tbody>\r\n" + 
				"  </table>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #f9f9f9;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #f9f9f9;\"><![endif]-->\r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 40px 30px 20px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"  </div>\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"    <!--[if (mso)|(IE)]></td></tr></table><![endif]-->\r\n" + 
				"    </td>\r\n" + 
				"  </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"  </table>\r\n" + 
				"  <!--[if mso]></div><![endif]-->\r\n" + 
				"  <!--[if IE]></div><![endif]-->\r\n" + 
				"</body>\r\n" + 
				"</html>\r\n";

		
		
		
		final MimeMessagePreparator preparator = new MimeMessagePreparator() {
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

                helper.setFrom("보내는 이메일"); // sender
                helper.setTo(recipient); // recipient
                helper.setSubject("[Catch] 인증번호"); // mail title
                helper.setText(content, true); // mail content
            }
        };
 
        mailSender.send(preparator);
		
		return certificationNumber;
	}

	@Override
	public void sendForgotPassEmail(String recipient) {
		String content = 
				"<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">\r\n" + 
				"<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">\r\n" + 
				"<head>\r\n" + 
				"<!--[if gte mso 9]>\r\n" + 
				"<xml>\r\n" + 
				"  <o:OfficeDocumentSettings>\r\n" + 
				"    <o:AllowPNG/>\r\n" + 
				"    <o:PixelsPerInch>96</o:PixelsPerInch>\r\n" + 
				"  </o:OfficeDocumentSettings>\r\n" + 
				"</xml>\r\n" + 
				"<![endif]-->\r\n" + 
				"  <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\r\n" + 
				"  <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\r\n" + 
				"  <meta name=\"x-apple-disable-message-reformatting\">\r\n" + 
				"  <!--[if !mso]><!--><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><!--<![endif]-->\r\n" + 
				"  <title></title>\r\n" + 
				"  \r\n" + 
				"    <style type=\"text/css\">\r\n" + 
				"      @media only screen and (min-width: 620px) {\r\n" + 
				"  .u-row {\r\n" + 
				"    width: 600px !important;\r\n" + 
				"  }\r\n" + 
				"  .u-row .u-col {\r\n" + 
				"    vertical-align: top;\r\n" + 
				"  }\r\n" + 
				"\r\n" + 
				"  .u-row .u-col-50 {\r\n" + 
				"    width: 300px !important;\r\n" + 
				"  }\r\n" + 
				"\r\n" + 
				"  .u-row .u-col-100 {\r\n" + 
				"    width: 600px !important;\r\n" + 
				"  }\r\n" + 
				"\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"@media (max-width: 620px) {\r\n" + 
				"  .u-row-container {\r\n" + 
				"    max-width: 100% !important;\r\n" + 
				"    padding-left: 0px !important;\r\n" + 
				"    padding-right: 0px !important;\r\n" + 
				"  }\r\n" + 
				"  .u-row .u-col {\r\n" + 
				"    min-width: 320px !important;\r\n" + 
				"    max-width: 100% !important;\r\n" + 
				"    display: block !important;\r\n" + 
				"  }\r\n" + 
				"  .u-row {\r\n" + 
				"    width: 100% !important;\r\n" + 
				"  }\r\n" + 
				"  .u-col {\r\n" + 
				"    width: 100% !important;\r\n" + 
				"  }\r\n" + 
				"  .u-col > div {\r\n" + 
				"    margin: 0 auto;\r\n" + 
				"  }\r\n" + 
				"}\r\n" + 
				"body {\r\n" + 
				"  margin: 0;\r\n" + 
				"  padding: 0;\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"table,\r\n" + 
				"tr,\r\n" + 
				"td {\r\n" + 
				"  vertical-align: top;\r\n" + 
				"  border-collapse: collapse;\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"p {\r\n" + 
				"  margin: 0;\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				".ie-container table,\r\n" + 
				".mso-container table {\r\n" + 
				"  table-layout: fixed;\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"* {\r\n" + 
				"  line-height: inherit;\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"a[x-apple-data-detectors='true'] {\r\n" + 
				"  color: inherit !important;\r\n" + 
				"  text-decoration: none !important;\r\n" + 
				"}\r\n" + 
				"\r\n" + 
				"table, td { color: #000000; } #u_body a { color: #161a39; text-decoration: underline; }\r\n" + 
				"    </style>\r\n" + 
				"  \r\n" + 
				"  \r\n" + 
				"\r\n" + 
				"<!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Lato:400,700&display=swap\" rel=\"stylesheet\" type=\"text/css\"><!--<![endif]-->\r\n" + 
				"\r\n" + 
				"</head>\r\n" + 
				"\r\n" + 
				"<body class=\"clean-body u_body\" style=\"margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #f9f9f9;color: #000000\">\r\n" + 
				"  <!--[if IE]><div class=\"ie-container\"><![endif]-->\r\n" + 
				"  <!--[if mso]><div class=\"mso-container\"><![endif]-->\r\n" + 
				"  <table id=\"u_body\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #f9f9f9;width:100%\" cellpadding=\"0\" cellspacing=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"  <tr style=\"vertical-align: top\">\r\n" + 
				"    <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\r\n" + 
				"    <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" style=\"background-color: #f9f9f9;\"><![endif]-->\r\n" + 
				"    \r\n" + 
				"\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: #f9f9f9\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #f9f9f9;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: #f9f9f9;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #f9f9f9;\"><![endif]-->\r\n" + 
				"      \r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"  \r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:15px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"  <table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 1px solid #f9f9f9;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\r\n" + 
				"    <tbody>\r\n" + 
				"      <tr style=\"vertical-align: top\">\r\n" + 
				"        <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\r\n" + 
				"          <span>&#160;</span>\r\n" + 
				"        </td>\r\n" + 
				"      </tr>\r\n" + 
				"    </tbody>\r\n" + 
				"  </table>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ffffff;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #ffffff;\"><![endif]-->\r\n" + 
				"      \r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"  \r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:20px 10px 10px 15px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n" + 
				"  <tr>\r\n" + 
				"    <td style=\"padding-right: 0px;padding-left: 0px;\" align=\"center\">\r\n" + 
				"      \r\n" + 
				"      \r\n" + 
				"      \r\n" + 
				"    </td>\r\n" + 
				"  </tr>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 10px 30px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"  <div style=\"font-size: 20px; color: #344767; line-height: 140%; text-align: center; word-wrap: break-word;\">\r\n" + 
				"  <div style=\"font-size: 20px; color: #344767; line-height: 140%; text-align: center; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"line-height: 140%;\"><span style=\"font-size: 24px; line-height: 28px;\"><strong>JOB LUV</strong></span></p>\r\n" + 
				"  </div>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #344767;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #344767;\"><![endif]-->\r\n" + 
				"      \r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"  \r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:35px 10px 10px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\">\r\n" + 
				"  <tr>\r\n" + 
				"    <td style=\"padding-right: 0px;padding-left: 0px;\" align=\"center\">\r\n" + 
				"      \r\n" + 
				"      \r\n" + 
				"      \r\n" + 
				"    </td>\r\n" + 
				"  </tr>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 10px 30px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"font-size: 14px; line-height: 140%; text-align: center;\"><strong><span style=\"color: #ecf0f1; line-height: 42px; font-size: 30px;\">비밀번호 재설정</span></strong></p>\r\n" + 
				"  </div>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #ffffff;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #ffffff;\"><![endif]-->\r\n" + 
				"      \r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"  \r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:40px 40px 50px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"line-height: 140%;\"><br />안녕하세요. 잡아줄게입니다.<br />" + recipient + " 계정의 비밀번호를 재설정 하려면</p>\r\n" + 
				"<p style=\"line-height: 140%;\">하단의 ‘비밀번호 재설정’을 클릭하세요.</p>\r\n" + 
				"<p style=\"line-height: 140%;\"> </p>\r\n" + 
				"<p style=\"line-height: 140%;\">문의 사항은 ddit@ddit.or.kr로 연락 주시기 바랍니다 :)</p>\r\n" + 
				"  </div>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 40px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"  <!--[if mso]><style>.v-button {background: transparent !important;}</style><![endif]-->\r\n" + 
				"<div align=\"left\">\r\n" + 
				"  <!--[if mso]><v:roundrect xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:w=\"urn:schemas-microsoft-com:office:word\" href=\"\" style=\"height:47px; v-text-anchor:middle; width:181px;\" arcsize=\"2%\"  stroke=\"f\" fillcolor=\"#344767\"><w:anchorlock/><center style=\"color:#FFFFFF;font-family:'Lato',sans-serif;\"><![endif]-->  \r\n" + 
				"    <a href=\"http://localhost/mem/changePass?memId=" + recipient + "\" target=\"_blank\" class=\"v-button\" style=\"box-sizing: border-box;display: inline-block;font-family:'Lato',sans-serif;text-decoration: none;-webkit-text-size-adjust: none;text-align: center;color: #FFFFFF; background-color: #344767; border-radius: 1px;-webkit-border-radius: 1px; -moz-border-radius: 1px; width:auto; max-width:100%; overflow-wrap: break-word; word-break: break-word; word-wrap:break-word; mso-border-alt: none;font-size: 14px;\">\r\n" + 
				"      <span style=\"display:block;padding:15px 40px;line-height:120%;\">비밀번호 재설정</span>\r\n" + 
				"    </a>\r\n" + 
				"  <!--[if mso]></center></v:roundrect><![endif]-->\r\n" + 
				"</div>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:30px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"font-size: 14px; line-height: 140%;\"><br /><span style=\"color: #888888; font-size: 14px; line-height: 19.6px;\"><em><span style=\"font-size: 16px; line-height: 22.4px;\"> </span></em></span></p>\r\n" + 
				"  </div>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #344767;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #344767;\"><![endif]-->\r\n" + 
				"      \r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"300\" style=\"width: 300px;padding: 20px 20px 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-50\" style=\"max-width: 320px;min-width: 300px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 20px 20px 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"  \r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"font-size: 14px; line-height: 140%;\"><span style=\"font-size: 16px; line-height: 22.4px; color: #ecf0f1;\">Contact</span></p>\r\n" + 
				"<p style=\"font-size: 14px; line-height: 140%;\"><span style=\"font-size: 14px; line-height: 19.6px; color: #ecf0f1;\">대전광역시 중구 계룡로 846, 3-4층</span></p>\r\n" + 
				"<p style=\"font-size: 14px; line-height: 140%;\"><span style=\"font-size: 14px; line-height: 19.6px; color: #ecf0f1;\">+82 42-222-8202 | ddit@ddit.or.kr</span></p>\r\n" + 
				"  </div>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"300\" style=\"width: 300px;padding: 0px 0px 0px 20px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-50\" style=\"max-width: 320px;min-width: 300px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px 0px 0px 20px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"  \r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:25px 10px 10px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"<div align=\"left\">\r\n" + 
				"  <div style=\"display: table; max-width:187px;\">\r\n" + 
				"  <!--[if (mso)|(IE)]><table width=\"187\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"border-collapse:collapse;\" align=\"left\"><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"border-collapse:collapse; mso-table-lspace: 0pt;mso-table-rspace: 0pt; width:187px;\"><tr><![endif]-->\r\n" + 
				"  \r\n" + 
				"    \r\n" + 
				"    <!--[if (mso)|(IE)]><td width=\"32\" style=\"width:32px; padding-right: 15px;\" valign=\"top\"><![endif]-->\r\n" + 
				"    <table align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"32\" height=\"32\" style=\"width: 32px !important;height: 32px !important;display: inline-block;border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;margin-right: 15px\">\r\n" + 
				"      <tbody><tr style=\"vertical-align: top\"><td align=\"left\" valign=\"middle\" style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\r\n" + 
				"        \r\n" + 
				"      </td></tr>\r\n" + 
				"    </tbody></table>\r\n" + 
				"    <!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"    \r\n" + 
				"    <!--[if (mso)|(IE)]><td width=\"32\" style=\"width:32px; padding-right: 15px;\" valign=\"top\"><![endif]-->\r\n" + 
				"    <table align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"32\" height=\"32\" style=\"width: 32px !important;height: 32px !important;display: inline-block;border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;margin-right: 15px\">\r\n" + 
				"      <tbody><tr style=\"vertical-align: top\"><td align=\"left\" valign=\"middle\" style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\r\n" + 
				"        \r\n" + 
				"      </td></tr>\r\n" + 
				"    </tbody></table>\r\n" + 
				"    <!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"    \r\n" + 
				"    <!--[if (mso)|(IE)]><td width=\"32\" style=\"width:32px; padding-right: 15px;\" valign=\"top\"><![endif]-->\r\n" + 
				"    <table align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"32\" height=\"32\" style=\"width: 32px !important;height: 32px !important;display: inline-block;border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;margin-right: 15px\">\r\n" + 
				"      <tbody><tr style=\"vertical-align: top\"><td align=\"left\" valign=\"middle\" style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\r\n" + 
				"       \r\n" + 
				"      </td></tr>\r\n" + 
				"    </tbody></table>\r\n" + 
				"    <!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"    \r\n" + 
				"    <!--[if (mso)|(IE)]><td width=\"32\" style=\"width:32px; padding-right: 0px;\" valign=\"top\"><![endif]-->\r\n" + 
				"    <table align=\"left\" border=\"0\" cellspacing=\"0\" cellpadding=\"0\" width=\"32\" height=\"32\" style=\"width: 32px !important;height: 32px !important;display: inline-block;border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;margin-right: 0px\">\r\n" + 
				"      <tbody><tr style=\"vertical-align: top\"><td align=\"left\" valign=\"middle\" style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">\r\n" + 
				"        \r\n" + 
				"      </td></tr>\r\n" + 
				"    </tbody></table>\r\n" + 
				"    <!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"    \r\n" + 
				"    \r\n" + 
				"    <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:5px 10px 10px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    <p style=\"line-height: 140%; font-size: 14px;\"><span style=\"font-size: 14px; line-height: 19.6px;\"><span style=\"color: #ecf0f1; font-size: 14px; line-height: 19.6px;\"><span style=\"line-height: 19.6px; font-size: 14px;\">Company ©  All Rights Reserved</span></span></span></p>\r\n" + 
				"  </div>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: #f9f9f9\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #344767;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: #f9f9f9;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #344767;\"><![endif]-->\r\n" + 
				"      \r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"  \r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:15px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"  <table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 1px solid #1c103b;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\r\n" + 
				"    <tbody>\r\n" + 
				"      <tr style=\"vertical-align: top\">\r\n" + 
				"        <td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">\r\n" + 
				"          <span>&#160;</span>\r\n" + 
				"        </td>\r\n" + 
				"      </tr>\r\n" + 
				"    </tbody>\r\n" + 
				"  </table>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">\r\n" + 
				"  <div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: #f9f9f9;\">\r\n" + 
				"    <div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">\r\n" + 
				"      <!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: #f9f9f9;\"><![endif]-->\r\n" + 
				"      \r\n" + 
				"<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]-->\r\n" + 
				"<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">\r\n" + 
				"  <div style=\"height: 100%;width: 100% !important;\">\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]-->\r\n" + 
				"  \r\n" + 
				"<table style=\"font-family:'Lato',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">\r\n" + 
				"  <tbody>\r\n" + 
				"    <tr>\r\n" + 
				"      <td style=\"overflow-wrap:break-word;word-break:break-word;padding:0px 40px 30px 20px;font-family:'Lato',sans-serif;\" align=\"left\">\r\n" + 
				"        \r\n" + 
				"  <div style=\"line-height: 140%; text-align: left; word-wrap: break-word;\">\r\n" + 
				"    \r\n" + 
				"  </div>\r\n" + 
				"\r\n" + 
				"      </td>\r\n" + 
				"    </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"</table>\r\n" + 
				"\r\n" + 
				"  <!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"<!--[if (mso)|(IE)]></td><![endif]-->\r\n" + 
				"      <!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]-->\r\n" + 
				"    </div>\r\n" + 
				"  </div>\r\n" + 
				"</div>\r\n" + 
				"\r\n" + 
				"\r\n" + 
				"    <!--[if (mso)|(IE)]></td></tr></table><![endif]-->\r\n" + 
				"    </td>\r\n" + 
				"  </tr>\r\n" + 
				"  </tbody>\r\n" + 
				"  </table>\r\n" + 
				"  <!--[if mso]></div><![endif]-->\r\n" + 
				"  <!--[if IE]></div><![endif]-->\r\n" + 
				"</body>\r\n" + 
				"\r\n" + 
				"</html>\r\n" + 
				"";
		
		final MimeMessagePreparator preparator = new MimeMessagePreparator() {
            @Override
            public void prepare(MimeMessage mimeMessage) throws Exception {
                final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

                helper.setFrom("보내는 이메일"); // sender
                helper.setTo(recipient); // recipient
                helper.setSubject("[Catch] 비밀번호 재설정"); // mail title
                helper.setText(content, true); // mail content
            }
        };
 
        mailSender.send(preparator);
	}

	@Override
	public void passEmail(Map<String, String> map) {
	    StringBuilder tmp = new StringBuilder();
	    tmp.append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");
	    tmp.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">");
	    tmp.append("<head><!--[if gte mso 9]><xml><o:OfficeDocumentSettings><o:AllowPNG/><o:PixelsPerInch>96</o:PixelsPerInch></o:OfficeDocumentSettings></xml>");
	    tmp.append("<![endif]--><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><meta name=\"x-apple-disable-message-reformatting\">");
	    tmp.append("<!--[if !mso]><!--><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><!--<![endif]-->");
	    tmp.append("<title></title>");
	    tmp.append("<style type=\"text/css\">@media only screen and (min-width: 620px) { .u-row {width: 600px !important;} .u-row .u-col {vertical-align: top;} .u-row  .u-col-100 {width: 600px !important;}}");
	    tmp.append("@media (max-width: 620px) { .u-row-container {max-width: 100% !important;padding-left: 0px !important;padding-right: 0px !important;} .u-row  .u-col {min-width: 320px !important;max-width: 100% !important;display: block !important;}");
	    tmp.append(".u-row {width: 100% !important;} .u-col {width: 100% !important;} .u-col > div {margin: 0 auto;}}body {margin: 0;padding: 0;}");
	    tmp.append("table,tr,td {vertical-align: top;border-collapse: collapse;} p {margin: 0;} .ie-container table,.mso-container table {table-layout: fixed;} * {line-height: inherit;}");
	    tmp.append("a[x-apple-data-detectors='true'] {color: inherit !important;text-decoration: none !important;} @media (max-width: 480px) {.hide-mobile {max-height: 0px;overflow: hidden;display: none !important;}}");
	    tmp.append("table, td { color: #000000; } #u_body a { color: #0000ee; text-decoration: underline; } @media (max-width: 480px) { #u_content_image_1 .v-src-width { width: auto !important; } #u_content_image_1 .v-src-max-width { max-width: 87% !important; } #u_content_heading_1 .v-container-padding-padding { padding: 40px 10px 0px !important; } #u_content_text_2 .v-container-padding-padding { padding: 5px 10px 10px !important; } #u_content_menu_1 .v-padding { padding: 5px 10px !important; } }");
	    tmp.append("</style><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Raleway:400,700&display=swap\" rel=\"stylesheet\" type=\"text/css\"><!--<![endif]-->");
	    tmp.append("</head><body class=\"clean-body u_body\" style=\"margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #ecf0f1;color: #000000\">");
	    tmp.append("<!--[if IE]><div class=\"ie-container\"><![endif]--><!--[if mso]><div class=\"mso-container\"><![endif]-->");
	    tmp.append("<table id=\"u_body\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #ecf0f1;width:100%\" cellpadding=\"0\" cellspacing=\"0\"><tbody><tr style=\"vertical-align: top\"><td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">");
	    tmp.append("<!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" style=\"background-color: #ecf0f1;\"><![endif]-->");
	    tmp.append("<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">");
	    tmp.append("<div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">");
	    tmp.append("<div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">");
	    tmp.append("<!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: transparent;\"><![endif]-->");
	    tmp.append("<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"background-color: #ffffff;width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\" valign=\"top\"><![endif]-->");
	    tmp.append("<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
	    tmp.append("<div style=\"background-color: #ffffff;height: 100%;width: 100% !important;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\">");
	    tmp.append("<!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\"><!--<![endif]-->");
	    tmp.append("<table id=\"u_content_image_1\" style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:60px 0px 0px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding-right: 0px;padding-left: 0px;\" align=\"center\">");
	    tmp.append("<img align=\"center\" border=\"0\" src=\"https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fb1Xgox%2Fbtr73pqKEpj%2FJVZmTHxyeRDIcnk4GEE77K%2Fimg.png\" alt=\"image\" title=\"image\" style=\"outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;clear: both;display: inline-block !important;border: none;height: auto;float: none;width: 74%;max-width: 444px;\" width=\"444\" class=\"v-src-width v-src-max-width\"/></td></tr></table></td></tr></tbody></table>");
	    tmp.append("<table style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:0px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 3px solid #ecf0f1;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\"><tbody><tr style=\"vertical-align: top\">");
	    tmp.append("<td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">");
	    tmp.append("<span>&#160;</span></td></tr></tbody></table></td>");
	    tmp.append("</tr></tbody></table><!--[if (!mso)&(!IE)]><!--></div><!--<![endif]--></div></div><!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]--></div></div></div>");
	    tmp.append("<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">");
	    tmp.append("<div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">");
	    tmp.append("<div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">");
	    tmp.append("<!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: transparent;\"><![endif]-->");
	    tmp.append("<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"background-color: #ffffff;width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]--><div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
	    tmp.append("<div style=\"background-color: #ffffff;height: 100%;width: 100% !important;\">");
	    tmp.append("<!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]--><table id=\"u_content_heading_1\" style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:30px 10px 5px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<h1 style=\"margin: 0px; color: #1a73e8; line-height: 150%; text-align: center; word-wrap: break-word; font-family: arial black,AvenirNext-Heavy,avant garde,arial; font-size: 35px; font-weight: 700; \"><strong>최종합격을 축하드립니다.</strong></h1></td></tr></tbody></table>");
	    tmp.append("<table id=\"u_content_text_2\" style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:5px 50px 10px 90px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<div style=\"font-size: 15px; line-height: 200%; text-align: left; word-wrap: break-word;\">");
	    tmp.append("<p style=\"line-height: 200%;\">축하합니다! "+map.get("memNm")+"님,</p><p style=\"line-height: 200%;\">이번 <strong>"+map.get("entNm")+"</strong>의 <strong>"+map.get("title")+"</strong> 전형에</p><p style=\"line-height: 200%;\">최종 합격 하셨음을 알려드립니다.</p>");
	    tmp.append("<p style=\"line-height: 200%;\">진심으로 축하드립니다!</p><br/><p style=\"line-height: 200%;\">익숙치 않은 면접 환경에서도 최선을 다해</p>");
	    tmp.append("<p style=\"line-height: 200%;\">채용과정에 임해주신 것에 감사드리며,</p><p style=\"line-height: 200%;\">"+map.get("memNm")+" 님을 동료로 맞이할 수 있게 되어 영광입니다.</p>");
	    tmp.append("<p style=\"line-height: 200%;\">앞으로도 잘 부탁드립니다.</p><br/><p style=\"line-height: 200%;\">문의 사항은 ddit@ddit.or.kr로 연락 주시기 바랍니다 :)</p>");
	    tmp.append("<p style=\"line-height: 200%;\">감사합니다.</p></div></td></tr></tbody></table>");
	    tmp.append("<!--[if (!mso)&(!IE)]><!--></div><!--<![endif]--></div></div><!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]--></div></div></div>");
	    tmp.append("<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">");
	    tmp.append("<div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">");
	    tmp.append("<div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">");
	    tmp.append("<!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: transparent;\"><![endif]-->");
	    tmp.append("<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"background-color: #ffffff;width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\" valign=\"top\"><![endif]-->");
	    tmp.append("<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
	    tmp.append("<div style=\"background-color: #ffffff;height: 100%;width: 100% !important;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\">");
	    tmp.append("<!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\"><!--<![endif]-->");
	    tmp.append("<table style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:20px 0px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 1px solid #BBBBBB;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\"><tbody><tr style=\"vertical-align: top\">");
	    tmp.append("<td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">");
	    tmp.append("<span>&#160;</span></td></tr></tbody></table></td></tr></tbody></table><table id=\"u_content_menu_1\" style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<div class=\"menu\" style=\"text-align:center\"><!--[if (mso)|(IE)]><table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\"><tr><![endif]--><!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<a href=\"https://www.unlayer.com\" target=\"_self\" style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;text-decoration:none\"  class=\"v-padding\">Home</a>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]--><span style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;\" class=\"v-padding hide-mobile\">|</span>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<a href=\"https://www.unlayer.com\" target=\"_self\" style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;text-decoration:none\"  class=\"v-padding\">Page</a>  ");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]-->  <!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<span style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;\" class=\"v-padding hide-mobile\">|</span>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<a href=\"https://www.unlayer.com\" target=\"_self\" style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;text-decoration:none\"  class=\"v-padding\">About Us</a>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]-->  <!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<span style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;\" class=\"v-padding hide-mobile\">|</span>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<a href=\"https://www.unlayer.com\" target=\"_self\" style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;text-decoration:none\"  class=\"v-padding\">Contact US</a>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]></tr></table><![endif]--></div></td></tr></tbody></table>");
	    tmp.append("<table style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:10px 10px 40px 28px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<div style=\"line-height: 160%; text-align: left; word-wrap: break-word;\"><p style=\"line-height: 160%;\">Contact</p><p style=\"line-height: 160%;\">대전광역시 중구 계룡로 846, 3-4층</p>");
	    tmp.append("<p style=\"line-height: 160%;\">+82 42-222-8202 | ddit@ddit.or.kr                                    Company ©  All Rights Reserved</p></div></td></tr></tbody></table><!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->");
	    tmp.append("</div></div><!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]--></div></div></div><!--[if (mso)|(IE)]></td></tr></table><![endif]--></td></tr></tbody></table>endif]--></body></html>");
	    
	    String content = tmp.toString();
		
		final MimeMessagePreparator preparator = new MimeMessagePreparator() {
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

                helper.setFrom("보내는 이메일"); // sender
				helper.setTo(map.get("memId")); // recipient
				helper.setSubject("[잡아줄게] 합격 메일"); // mail title
				helper.setText(content, true); // mail content
			}
		};
		
		mailSender.send(preparator);
	}
	
	
	@Override
	public void failEmail(Map<String, String> map) {
		StringBuilder tmp = new StringBuilder();
	    tmp.append("<!DOCTYPE HTML PUBLIC \"-//W3C//DTD XHTML 1.0 Transitional //EN\" \"http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd\">");
	    tmp.append("<html xmlns=\"http://www.w3.org/1999/xhtml\" xmlns:v=\"urn:schemas-microsoft-com:vml\" xmlns:o=\"urn:schemas-microsoft-com:office:office\">");
	    tmp.append("<head><!--[if gte mso 9]><xml><o:OfficeDocumentSettings><o:AllowPNG/><o:PixelsPerInch>96</o:PixelsPerInch></o:OfficeDocumentSettings></xml>");
	    tmp.append("<![endif]--><meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\"><meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\"><meta name=\"x-apple-disable-message-reformatting\">");
	    tmp.append("<!--[if !mso]><!--><meta http-equiv=\"X-UA-Compatible\" content=\"IE=edge\"><!--<![endif]-->");
	    tmp.append("<title></title>");
	    tmp.append("<style type=\"text/css\">@media only screen and (min-width: 620px) { .u-row {width: 600px !important;} .u-row .u-col {vertical-align: top;} .u-row  .u-col-100 {width: 600px !important;}}");
	    tmp.append("@media (max-width: 620px) { .u-row-container {max-width: 100% !important;padding-left: 0px !important;padding-right: 0px !important;} .u-row  .u-col {min-width: 320px !important;max-width: 100% !important;display: block !important;}");
	    tmp.append(".u-row {width: 100% !important;} .u-col {width: 100% !important;} .u-col > div {margin: 0 auto;}}body {margin: 0;padding: 0;}");
	    tmp.append("table,tr,td {vertical-align: top;border-collapse: collapse;} p {margin: 0;} .ie-container table,.mso-container table {table-layout: fixed;} * {line-height: inherit;}");
	    tmp.append("a[x-apple-data-detectors='true'] {color: inherit !important;text-decoration: none !important;} @media (max-width: 480px) {.hide-mobile {max-height: 0px;overflow: hidden;display: none !important;}}");
	    tmp.append("table, td { color: #000000; } #u_body a { color: #0000ee; text-decoration: underline; } @media (max-width: 480px) { #u_content_image_1 .v-src-width { width: auto !important; } #u_content_image_1 .v-src-max-width { max-width: 87% !important; } #u_content_heading_1 .v-container-padding-padding { padding: 40px 10px 0px !important; } #u_content_text_2 .v-container-padding-padding { padding: 5px 10px 10px !important; } #u_content_menu_1 .v-padding { padding: 5px 10px !important; } }");
	    tmp.append("</style><!--[if !mso]><!--><link href=\"https://fonts.googleapis.com/css?family=Raleway:400,700&display=swap\" rel=\"stylesheet\" type=\"text/css\"><!--<![endif]-->");
	    tmp.append("</head><body class=\"clean-body u_body\" style=\"margin: 0;padding: 0;-webkit-text-size-adjust: 100%;background-color: #ecf0f1;color: #000000\">");
	    tmp.append("<!--[if IE]><div class=\"ie-container\"><![endif]--><!--[if mso]><div class=\"mso-container\"><![endif]-->");
	    tmp.append("<table id=\"u_body\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;min-width: 320px;Margin: 0 auto;background-color: #ecf0f1;width:100%\" cellpadding=\"0\" cellspacing=\"0\"><tbody><tr style=\"vertical-align: top\"><td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top\">");
	    tmp.append("<!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td align=\"center\" style=\"background-color: #ecf0f1;\"><![endif]-->");
	    tmp.append("<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">");
	    tmp.append("<div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">");
	    tmp.append("<div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">");
	    tmp.append("<!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: transparent;\"><![endif]-->");
	    tmp.append("<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"background-color: #ffffff;width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\" valign=\"top\"><![endif]-->");
	    tmp.append("<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
	    tmp.append("<div style=\"background-color: #ffffff;height: 100%;width: 100% !important;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\">");
	    tmp.append("<!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\"><!--<![endif]-->");
	    tmp.append("<table id=\"u_content_image_1\" style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:60px 0px 0px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding-right: 0px;padding-left: 0px;\" align=\"center\">");
	    tmp.append("<img align=\"center\" border=\"0\" src=\"https://img1.daumcdn.net/thumb/R1280x0/?scode=mtistory2&fname=https%3A%2F%2Fblog.kakaocdn.net%2Fdn%2Fk3PBn%2Fbtr7RrcTDUW%2F2ggF6or3DmCmjSjHDKL5rk%2Fimg.jpg\" alt=\"image\" title=\"image\" style=\"outline: none;text-decoration: none;-ms-interpolation-mode: bicubic;clear: both;display: inline-block !important;border: none;height: auto;float: none;width: 74%;max-width: 444px;\" width=\"444\" class=\"v-src-width v-src-max-width\"/></td></tr></table></td></tr></tbody></table>");
	    tmp.append("<table style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:0px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 3px solid #ecf0f1;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\"><tbody><tr style=\"vertical-align: top\">");
	    tmp.append("<td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">");
	    tmp.append("<span>&#160;</span></td></tr></tbody></table></td>");
	    tmp.append("</tr></tbody></table><!--[if (!mso)&(!IE)]><!--></div><!--<![endif]--></div></div><!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]--></div></div></div>");
	    tmp.append("<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">");
	    tmp.append("<div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">");
	    tmp.append("<div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">");
	    tmp.append("<!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: transparent;\"><![endif]-->");
	    tmp.append("<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"background-color: #ffffff;width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\" valign=\"top\"><![endif]--><div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
	    tmp.append("<div style=\"background-color: #ffffff;height: 100%;width: 100% !important;\">");
	    tmp.append("<!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;\"><!--<![endif]--><table id=\"u_content_heading_1\" style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:30px 10px 5px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<h1 style=\"margin: 0px; color: #1a73e8; line-height: 150%; text-align: center; word-wrap: break-word; font-family: arial black,AvenirNext-Heavy,avant garde,arial; font-size: 35px; font-weight: 700; \"><strong>"+map.get("memNm")+"님, 결과 안내 드립니다.</strong></h1></td></tr></tbody></table>");
	    tmp.append("<table id=\"u_content_text_2\" style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:5px 50px 10px 90px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<div style=\"font-size: 15px; line-height: 200%; text-align: left; word-wrap: break-word;\">");
	    tmp.append("<p style=\"line-height: 200%;\">안녕하세요. "+map.get("memNm")+"님,</p><p style=\"line-height: 200%;\">이번 <strong>"+map.get("entNm")+"</strong>의 <strong>"+map.get("title")+"</strong> 전형에</p><p style=\"line-height: 200%;\">지원해주셔서 감사합니다.</p><br/>");
	    tmp.append("<p style=\"line-height: 200%;\">안타깝게도 이번 채용과정에서는 "+map.get("memNm")+"님을 모시지 못하게 되었습니다.</p>");
	    tmp.append("<p style=\"line-height: 200%;\">"+map.get("memNm")+"님 의 역량이 부족하는 것이 결코 아니며,</p><p style=\"line-height: 200%;\">본인에게 맞는 기업을 찾아가는 과정이라 여기시고,</p>");
	    tmp.append("<p style=\"line-height: 200%;\">크게 낙심하지 않으셨으면 합니다.</p><br/><p style=\"line-height: 200%;\">앞으로 더 좋은 인연으로 만나뵐 수 있기를 바랍니다.</p>");
	    tmp.append("<p style=\"line-height: 200%;\">감사합니다.</p></div></td></tr></tbody></table>");
	    tmp.append("<!--[if (!mso)&(!IE)]><!--></div><!--<![endif]--></div></div><!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]--></div></div></div>");
	    tmp.append("<div class=\"u-row-container\" style=\"padding: 0px;background-color: transparent\">");
	    tmp.append("<div class=\"u-row\" style=\"Margin: 0 auto;min-width: 320px;max-width: 600px;overflow-wrap: break-word;word-wrap: break-word;word-break: break-word;background-color: transparent;\">");
	    tmp.append("<div style=\"border-collapse: collapse;display: table;width: 100%;height: 100%;background-color: transparent;\">");
	    tmp.append("<!--[if (mso)|(IE)]><table width=\"100%\" cellpadding=\"0\" cellspacing=\"0\" border=\"0\"><tr><td style=\"padding: 0px;background-color: transparent;\" align=\"center\"><table cellpadding=\"0\" cellspacing=\"0\" border=\"0\" style=\"width:600px;\"><tr style=\"background-color: transparent;\"><![endif]-->");
	    tmp.append("<!--[if (mso)|(IE)]><td align=\"center\" width=\"600\" style=\"background-color: #ffffff;width: 600px;padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\" valign=\"top\"><![endif]-->");
	    tmp.append("<div class=\"u-col u-col-100\" style=\"max-width: 320px;min-width: 600px;display: table-cell;vertical-align: top;\">");
	    tmp.append("<div style=\"background-color: #ffffff;height: 100%;width: 100% !important;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\">");
	    tmp.append("<!--[if (!mso)&(!IE)]><!--><div style=\"box-sizing: border-box; height: 100%; padding: 0px;border-top: 0px solid transparent;border-left: 0px solid transparent;border-right: 0px solid transparent;border-bottom: 0px solid transparent;border-radius: 0px;-webkit-border-radius: 0px; -moz-border-radius: 0px;\"><!--<![endif]-->");
	    tmp.append("<table style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:20px 0px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<table height=\"0px\" align=\"center\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" style=\"border-collapse: collapse;table-layout: fixed;border-spacing: 0;mso-table-lspace: 0pt;mso-table-rspace: 0pt;vertical-align: top;border-top: 1px solid #BBBBBB;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\"><tbody><tr style=\"vertical-align: top\">");
	    tmp.append("<td style=\"word-break: break-word;border-collapse: collapse !important;vertical-align: top;font-size: 0px;line-height: 0px;mso-line-height-rule: exactly;-ms-text-size-adjust: 100%;-webkit-text-size-adjust: 100%\">");
	    tmp.append("<span>&#160;</span></td></tr></tbody></table></td></tr></tbody></table><table id=\"u_content_menu_1\" style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:10px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<div class=\"menu\" style=\"text-align:center\"><!--[if (mso)|(IE)]><table role=\"presentation\" border=\"0\" cellpadding=\"0\" cellspacing=\"0\" align=\"center\"><tr><![endif]--><!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<a href=\"https://www.unlayer.com\" target=\"_self\" style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;text-decoration:none\"  class=\"v-padding\">Home</a>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]--><span style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;\" class=\"v-padding hide-mobile\">|</span>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<a href=\"https://www.unlayer.com\" target=\"_self\" style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;text-decoration:none\"  class=\"v-padding\">Page</a>  ");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]-->  <!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<span style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;\" class=\"v-padding hide-mobile\">|</span>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<a href=\"https://www.unlayer.com\" target=\"_self\" style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;text-decoration:none\"  class=\"v-padding\">About Us</a>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]-->  <!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<span style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;\" class=\"v-padding hide-mobile\">|</span>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]><td style=\"padding:5px 15px\"><![endif]-->");
	    tmp.append("<a href=\"https://www.unlayer.com\" target=\"_self\" style=\"padding:5px 15px;display:inline-block;color:#000000;font-size:14px;text-decoration:none\"  class=\"v-padding\">Contact US</a>");
	    tmp.append("<!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]></tr></table><![endif]--></div></td></tr></tbody></table>");
	    tmp.append("<table style=\"font-family:'Raleway',sans-serif;\" role=\"presentation\" cellpadding=\"0\" cellspacing=\"0\" width=\"100%\" border=\"0\">");
	    tmp.append("<tbody><tr><td class=\"v-container-padding-padding\" style=\"overflow-wrap:break-word;word-break:break-word;padding:10px 10px 40px 28px;font-family:'Raleway',sans-serif;\" align=\"left\">");
	    tmp.append("<div style=\"line-height: 160%; text-align: left; word-wrap: break-word;\"><p style=\"line-height: 160%;\">Contact</p><p style=\"line-height: 160%;\">대전광역시 중구 계룡로 846, 3-4층</p>");
	    tmp.append("<p style=\"line-height: 160%;\">+82 42-222-8202 | ddit@ddit.or.kr                                    Company ©  All Rights Reserved</p></div></td></tr></tbody></table><!--[if (!mso)&(!IE)]><!--></div><!--<![endif]-->");
	    tmp.append("</div></div><!--[if (mso)|(IE)]></td><![endif]--><!--[if (mso)|(IE)]></tr></table></td></tr></table><![endif]--></div></div></div><!--[if (mso)|(IE)]></td></tr></table><![endif]--></td></tr></tbody></table>endif]--></body></html>");
		
		String content = tmp.toString();
		
		final MimeMessagePreparator preparator = new MimeMessagePreparator() {
			@Override
			public void prepare(MimeMessage mimeMessage) throws Exception {
				final MimeMessageHelper helper = new MimeMessageHelper(mimeMessage, true, "UTF-8");

                helper.setFrom("보내는 이메일"); // sender
				helper.setTo(map.get("memId")); // recipient
				helper.setSubject("[잡아줄게] 불합격 메일"); // mail title
				helper.setText(content, true); // mail content
			}
		};
		
		mailSender.send(preparator);
	}
}
