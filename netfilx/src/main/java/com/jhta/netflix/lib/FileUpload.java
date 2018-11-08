package com.jhta.netflix.lib;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;

import org.omg.Messaging.SyncScopeHelper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.jcraft.jsch.Channel;
import com.jcraft.jsch.ChannelSftp;
import com.jcraft.jsch.JSch;
import com.jcraft.jsch.JSchException;
import com.jcraft.jsch.Session;
import com.jcraft.jsch.SftpATTRS;
import com.jcraft.jsch.SftpException;

@Component
public class FileUpload {
	@Autowired private FTP ftp;
	 
	private final Logger LOGGER = LoggerFactory.getLogger(this.getClass());
	
	    private Session session = null;
	    private Channel channel = null;
	    private ChannelSftp channelSftp = null;

	public void init(){
		String url = ftp.getUrl(); 
 		String id = ftp.getId();
 		String pwd = ftp.getPwd();
 		int port = ftp.getPort();
         
        //JSch 객체 생성
        JSch jsch = new JSch();
        try {
            //세션객체 생성 ( user , host, port )     
            session = jsch.getSession(id, url, port);
             
            //password 설정
            session.setPassword(pwd);
             
            //세션관련 설정정보 설정
            java.util.Properties config = new java.util.Properties();
             
            //호스트 정보 검사하지 않는다.
            config.put("StrictHostKeyChecking", "no");
            session.setConfig(config);
             
            //접속
            session.connect();
 
            //sftp 채널 접속
            channel = session.openChannel("sftp");
            channel.connect();
             
        } catch (JSchException e) {
            e.printStackTrace();
        }
        channelSftp = (ChannelSftp) channel;
         
    }
 
    // 단일 파일 업로드 
    public void upload( String dir , File file){
        FileInputStream in = null;
        String path_url = "/docker/tomcat8/watflix"+dir;
        SftpATTRS attrs = null;
        try {
			attrs = channelSftp.stat(path_url);
		} catch (Exception e) {
			System.out.println(e.getMessage());
		}
        if(attrs==null) {
        	try {
				channelSftp.mkdir(path_url);
			} catch (SftpException e) {
				System.out.println(e.getMessage());
			}
        }
        try{ //파일을 가져와서 inputStream에 넣고 저장경로를 찾아 put 
            in = new FileInputStream(file);
            if(channelSftp.stat(path_url)==null) {
            	channelSftp.mkdir(path_url);
            }
            channelSftp.cd(path_url);
            channelSftp.put(in,file.getName());
        }catch(SftpException se){
            se.printStackTrace();
        }catch(FileNotFoundException fe){
            fe.printStackTrace();
        }finally{
            try{
                in.close();
            } catch(IOException ioe){
                ioe.printStackTrace();
            }
        }
    }
 
    // 파일서버와 세션 종료
    public void disconnect(){
        channelSftp.quit();
        session.disconnect();
    }
}
