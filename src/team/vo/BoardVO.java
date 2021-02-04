package team.vo;

public class BoardVO 
{
	private int    no;
	private String title;
	private String content;
	private String wdate;
	private String file;
	private int    hit;
	private int    r_count;
	
	public BoardVO(){}
	
	public void   setNo     (int no) {this.no = no;}
	public int    getNo     () {return this.no;}
	
	public void   setSubject(String title) {this.title = title;}
	public String getSubject() {return this.title;}
	
	public void   setBody   (String content) {this.content = content;}
	public String getBody   () {return this.content;}
	
	public void   setWdate  (String wdate) {this.wdate = wdate;}
	public String getWdate  () {return this.wdate;}
	
	public void   setFile   (String file) {this.file = file;}
	public String   getFile () {return this.file;}
	
	public void   setHit    (int hit) {this.hit = hit;}
	public int    getHit    () {return this.hit;}
	
	public void   setR_count(int r_count) {this.r_count = r_count;}
	public int    getR_count() {return this.r_count;}
}
