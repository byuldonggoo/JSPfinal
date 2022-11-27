package login;


public class UserVO {

	private String id;
	private String password;
	private String nickname;
	private String phone_number;
	private String profile_img;
	private String addr;
	private String detail_addr;
	
	public UserVO() {
		
	}
	
	public UserVO(String id, String password, String nickname, String phone_number,String profile_img,String addr,String detail_addr) {
		this.id = id;
		this.password = password;
		this.nickname = nickname;
		this.phone_number = phone_number;
		this.profile_img = profile_img;
		this.addr=addr;
		this.detail_addr=detail_addr;
	}

	public UserVO(String id, String nickname, String phone_number, String profile_img, String addr,	String detail_addr) {
		this.id = id;
		this.nickname = nickname;
		this.phone_number = phone_number;
		this.profile_img = profile_img;
		this.addr=addr;
		this.detail_addr=detail_addr;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return password;
	}

	public void setPwd(String password) {
		this.password = password;
	}

	public String getNickname() {
		return nickname;
	}

	public void setNickname(String nickname) {
		this.nickname = nickname;
	}

	public String getPhone_number() {
		return phone_number;
	}

	public void setPhone_number(String phone_number) {
		this.phone_number = phone_number;
	}

	public String getProfile_img() {
		return profile_img;
	}

	public void setProfile_img(String profile_img) {
		this.profile_img = profile_img;
	}

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

	public String getDetail_addr() {
		return detail_addr;
	}

	public void setDetail_addr(String detail_addr) {
		this.detail_addr = detail_addr;
	}
	
	
	
	
	
	
	
}