package login;

import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.internet.AddressException;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
 
public class EmailSMTP {
 
	//이메일주소를 파라미터로 받고 메일을 보낸 후 보낸 인증번호(String)를 반환하는 메소드
    public String SendEmail(String emailAdr){
    	
    	String mailnumber;
         
    	//네이버 smtp이용
        Properties p = System.getProperties();
        p.put("mail.smtp.starttls.enable", "true");     
        p.put("mail.smtp.host", "smtp.naver.com");      
        p.put("mail.smtp.auth","true");                 
        p.put("mail.smtp.port", "587");                
        p.put("mail.smtp.port", "587");                
           
        Authenticator auth = new MyAuthentication();
        //session 생성 및  MimeMessage생성
        Session session = Session.getDefaultInstance(p, auth);
        MimeMessage msg = new MimeMessage(session);
        
        RandomNumber number=new RandomNumber(); 
        mailnumber=number.makerandom();//인증번호 난수생성 메소드
        String numberMsg = "인증번호는 " + mailnumber + "입니다.";
         
        try{
            //편지보낸시간
            msg.setSentDate(new Date());
            InternetAddress from = new InternetAddress() ;
            from = new InternetAddress("jsh00999@naver.com"); //발신자 아이디
            // 이메일 발신자
            msg.setFrom(from);
            // 이메일 수신자
            InternetAddress to = new InternetAddress(emailAdr);
            msg.setRecipient(Message.RecipientType.TO, to);
            // 이메일 제목
            msg.setSubject("BestSeller 인증번호 확인 메일입니다.", "UTF-8");
            // 이메일 내용
            msg.setText(numberMsg, "UTF-8");
            // 이메일 헤더
            msg.setHeader("content-Type", "text/html");
            //메일보내기
            javax.mail.Transport.send(msg, msg.getAllRecipients());
            
           
             
        }catch (AddressException addr_e) {
            addr_e.printStackTrace();
        }catch (MessagingException msg_e) {
            msg_e.printStackTrace();
        }catch (Exception msg_e) {
            msg_e.printStackTrace();
        }
        
        return mailnumber;
    }
    
}
 
//게정 인증
class MyAuthentication extends Authenticator {
      
    PasswordAuthentication pa;
    public MyAuthentication(){
         
        String id = "jsh00999";  //네이버 이메일 아이디
        String pw = "비밀번호입력"; //네이버 비밀번호
 
        pa = new PasswordAuthentication(id, pw);
    }
 
    public PasswordAuthentication getPasswordAuthentication() {
        return pa;
    }
} 

class RandomNumber{
	//인증번호를 위한 난수생성
	public String makerandom() {
		Random random = new Random();
		int createNum=0;
		String ranNum="";
		int letter=6;
		String resultNum="";
		
		for (int i = 0; i < letter; i++) {
			createNum = random.nextInt(9);
			ranNum = Integer.toString(createNum);
			resultNum+=ranNum;
		}
		
		return resultNum;
	}
}
  
