package kr.co.pension.dto;

public class ReserveDTO {
	
	private String inday, outday, userid, jumuncode,writeday;
	private int id, suk, inwon, bbq, fire, chgprice, rid, state;
	
	private int roomchk;
	private boolean chk;
	
	
	
	public boolean isChk() {
		return chk;
	}
	public void setChk(boolean chk) {
		this.chk = chk;
	}
	public int getRoomchk() {
		return roomchk;
	}
	public void setRoomchk(int roomchk) {
		this.roomchk = roomchk;
	}
	public String getWriteday() {
		return writeday;
	}
	public void setWriteday(String writeday) {
		this.writeday = writeday;
	}
	public String getInday() {
		return inday;
	}
	public void setInday(String inday) {
		this.inday = inday;
	}
	public String getOutday() {
		return outday;
	}
	public void setOutday(String outday) {
		this.outday = outday;
	}
	public String getUserid() {
		return userid;
	}
	public void setUserid(String userid) {
		this.userid = userid;
	}
	public String getJumuncode() {
		return jumuncode;
	}
	public void setJumuncode(String jumuncode) {
		this.jumuncode = jumuncode;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getSuk() {
		return suk;
	}
	public void setSuk(int suk) {
		this.suk = suk;
	}
	public int getInwon() {
		return inwon;
	}
	public void setInwon(int inwon) {
		this.inwon = inwon;
	}
	public int getBbq() {
		return bbq;
	}
	public void setBbq(int bbq) {
		this.bbq = bbq;
	}
	public int getFire() {
		return fire;
	}
	public void setFire(int fire) {
		this.fire = fire;
	}
	public int getChgprice() {
		return chgprice;
	}
	public void setChgprice(int chgprice) {
		this.chgprice = chgprice;
	}
	public int getRid() {
		return rid;
	}
	public void setRid(int rid) {
		this.rid = rid;
	}
	public int getState() {
		return state;
	}
	public void setState(int state) {
		this.state = state;
	}
	
	
}
