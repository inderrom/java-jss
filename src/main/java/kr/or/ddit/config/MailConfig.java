package kr.or.ddit.config;
import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;
 
@Configuration
public class MailConfig {
    
    @Bean
    public JavaMailSender getMailSender() {
        
        JavaMailSenderImpl mailSender = new JavaMailSenderImpl();
        
        mailSender.setHost("smtp.naver.com");
        mailSender.setPort(465);
        mailSender.setUsername("보내는 이메일");
        mailSender.setPassword("계정 비밀번호");
        
        Properties javaMailProperties = new Properties();
        
        javaMailProperties.put("mail.smtp.ssl.enable", "true");
        javaMailProperties.put("mail.smtp.auth", "true");
        javaMailProperties.put("mail.smtp.ssl.trust", "smtp.naver.com");
 
        mailSender.setJavaMailProperties(javaMailProperties);
        
        return mailSender;
    }
}