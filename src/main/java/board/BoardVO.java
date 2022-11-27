package board;

import java.sql.Date;

public class BoardVO {
	
	private int num_aticle;// auto_inc
	private String nickname; //not null
	private String category; //not null
	private String title;    //not null
	private String contents; //not null
	private String deal_status;//not null
	private Date upload; //default
	private String goods_name; //not null
	private int num_cmnt; //null ok
	
	private String price; //NOT NULL
	private String goods_img; // TEXT NOT NULL,
	private String tag; // TEXT
	
	public String getPrice() {
		return price;
	}	


	public void setPrice(String price) {
		this.price = price;
	}


	public String getGoods_img() {
		return goods_img;
	}


	public void setGoods_img(String goods_img) {
		this.goods_img = goods_img;
	}


	public String getTag() {
		return tag;
	}


	public void setTag(String tag) {
		this.tag = tag;
	}


	public BoardVO() {
		System.out.println("BoardVO 생성자호출");
	}
	
	//글 리스트에 관한 내용에 대한 생성성자
		public BoardVO (int num_aticle, String nickname, String deal_status) {
			this.num_aticle = num_aticle;
			this.nickname = nickname;
			this.deal_status = deal_status;
		}
		
	//글 리스트에 관한 내용에 대한 생성성자
	public BoardVO (int num_aticle, String nickname, String title, String deal_status, Date upload) {
		this.num_aticle = num_aticle;
		this.nickname = nickname;
		this.title = title;
		this.deal_status = deal_status;
		this.upload = upload;
	}
	
	//글내용 전체 속성에 대한 생성자
	public BoardVO(int num_aticle, String nickname, String category, String title, String contents,
			String deal_status, Date upload, String goods_name, String price ) {
		
		this.num_aticle = num_aticle;
		this.nickname = nickname;
		this.category = category;
		this.title = title;
		this.contents = contents;
		this.deal_status = deal_status;
		this.upload = upload;
		this.goods_name = goods_name;
		this.price = price;
	}



	public int getNum_aticle() {
		return num_aticle;
	}



	public void setNum_aticle(int num_aticle) {
		this.num_aticle = num_aticle;
	}



	public String getNickname() {
		return nickname;
	}



	public void setNickname(String nickname) {
		this.nickname = nickname;
	}



	public String getCategory() {
		return category;
	}



	public void setCategory(String category) {
		this.category = category;
	}



	public String getTitle() {
		return title;
	}



	public void setTitle(String title) {
		this.title = title;
	}



	public String getContents() {
		return contents;
	}



	public void setContents(String contents) {
		this.contents = contents;
	}



	public String getDeal_status() {
		return deal_status;
	}



	public void setDeal_status(String deal_status) {
		this.deal_status = deal_status;
	}



	public Date getUpload() {
		return upload;
	}



	public void setUpload(Date upload) {
		this.upload = upload;
	}



	public String getGoods_name() {
		return goods_name;
	}



	public void setGoods_name(String goods_name) {
		this.goods_name = goods_name;
	}



	public int getNum_cmnt() {
		return num_cmnt;
	}



	public void setNum_cmnt(int num_cmnt) {
		this.num_cmnt = num_cmnt;
	}


	public void setImgFileNmae(String imgFileName) {
		
	}
	



}