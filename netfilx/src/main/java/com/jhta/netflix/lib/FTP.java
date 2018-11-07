package com.jhta.netflix.lib;

public class FTP {
	private String url;
	private String id;
	private String pwd;
	private String port;
	
	public FTP() {}
	
	public FTP(String url, String id, String pwd, String port) {
		this.url = url;
		this.id = id;
		this.pwd = pwd;
		this.port = port;
	}

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getPwd() {
		return pwd;
	}

	public void setPwd(String pwd) {
		this.pwd = pwd;
	}

	public String getPort() {
		return port;
	}

	public void setPort(String port) {
		this.port = port;
	}
	
}
