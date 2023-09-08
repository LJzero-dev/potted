package svc;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.HashMap;

import org.json.simple.JSONObject;
import org.json.simple.parser.JSONParser;

import dao.*;
import vo.MemberInfo;

public class KakaoSvc {
	private KakaoDao kakaoDao;
	
	public void setKakaoDao(KakaoDao kakaoDao) {
		this.kakaoDao = kakaoDao;	
	}

	public String getAccessToken(String code) {
		String access_token = "";
		String refresh_token = "";
		String reqURL = "https://kauth.kakao.com/oauth/token";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("POST");
			conn.setDoOutput(true);	
			
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(conn.getOutputStream()));
			StringBuilder sb = new StringBuilder();	
			sb.append("grant_type=authorization_code");
			sb.append("&client_id=5a2d9d0124bccf5124c37344be839c1c");
			sb.append("&redirect_uri=http://localhost:8086/potted/kakaoLoginProc");
			sb.append("&code=" + code);
			bw.write(sb.toString());
			bw.flush();
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			// ���� 200�̸� ����
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "", result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("result : " + result);
			
			JSONParser p = new JSONParser();
			JSONObject jo = (JSONObject)p.parse(result);
			access_token = (String)jo.get("access_token");
			refresh_token = (String)jo.get("refresh_token");
			
			br.close();		bw.close();
			
		} catch(Exception e) {
			System.out.println("getAccessToken() �޼ҵ� ����");
			e.printStackTrace();
		}
		
		return access_token;
	}

	public HashMap<String, String> getUserInfo(String accessToken) {
		HashMap<String, String> loginInfo = new HashMap<String, String>();
		String reqURL = "https://kapi.kakao.com/v2/user/me";
		
		try {
			URL url = new URL(reqURL);
			HttpURLConnection conn = (HttpURLConnection)url.openConnection();
			conn.setRequestMethod("GET");
			conn.setRequestProperty("Authorization", "Bearer " + accessToken);
			
			int responseCode = conn.getResponseCode();
			System.out.println("responseCode : " + responseCode);
			// ���� 200�̸� ����
			
			BufferedReader br = new BufferedReader(new InputStreamReader(conn.getInputStream()));
			String line = "", result = "";
			while ((line = br.readLine()) != null) {
				result += line;
			}
			System.out.println("result : " + result);
			
			JSONParser p = new JSONParser();
			JSONObject jo = (JSONObject)p.parse(result);
			JSONObject properties = (JSONObject)jo.get("properties");
			JSONObject kakao_account = (JSONObject)jo.get("kakao_account");
			
			String nickname = properties.get("nickname").toString();
			String gender = kakao_account.get("gender").toString();
			String birthday = kakao_account.get("birthday").toString();
			String email = kakao_account.get("email").toString();

			loginInfo.put("nickname", nickname);
			loginInfo.put("gender", gender);
			loginInfo.put("birthday", birthday);
			loginInfo.put("email", email);
			
		} catch(Exception e) {
			System.out.println("getUserInfo() 메소드 오류");
			e.printStackTrace();
		}
		
		return loginInfo;
	}

	public int isMem(String email) {
		int result = kakaoDao.isMem(email);
		return result;
	}

	public MemberInfo getLoginInfo(String email) {
		MemberInfo mi = kakaoDao.getLoginInfo(email);
		return mi;
	}
}
