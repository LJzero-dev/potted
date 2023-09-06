package ctrl;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLEncoder;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;
import org.json.XML;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class PlantBookCtrl {
	@GetMapping("/plantBook")
	public String plantBook(HttpServletRequest request, Model model) throws Exception{
		request.setCharacterEncoding("utf-8");
	        StringBuilder urlBuilder = new StringBuilder("http://openapi.nature.go.kr/openapi/service/rest/PlantService/naturalizedSearch2"); /*URL*/
	        urlBuilder.append("?" + URLEncoder.encode("serviceKey","UTF-8") + "=eK%2Bh7ZUqemVimmd2QHIY39z3iyTO6LPrfEsKz6ztWfVpnpcSVP9Iws9Q9G0avyhKEid0se7AOr8lSHas4L0yLQ%3D%3D"); /*Service Key*/
	        urlBuilder.append("&" + URLEncoder.encode("st","UTF-8") + "=" + URLEncoder.encode("1", "UTF-8")); /*1-국명/2-학명/3-국명일치/4-학명일치*/
	        urlBuilder.append("&" + URLEncoder.encode("sw","UTF-8") + "=" + URLEncoder.encode("꽃", "UTF-8")); /*검색대상어*/
	        urlBuilder.append("&" + URLEncoder.encode("numOfRows","UTF-8") + "=" + URLEncoder.encode("5", "UTF-8")); /*한 페이지 결과 수*/
	        urlBuilder.append("&" + URLEncoder.encode("pageNo","UTF-8") + "=" + URLEncoder.encode("2", "UTF-8")); /*페이지 번호*/
	        URL url = new URL(urlBuilder.toString());
	        HttpURLConnection conn = (HttpURLConnection) url.openConnection();
	        conn.setRequestMethod("GET");
	        conn.setRequestProperty("Content-type", "application/json");
	        System.out.println("Response code: " + conn.getResponseCode());
	        BufferedReader rd;
	        if(conn.getResponseCode() >= 200 && conn.getResponseCode() <= 300) {
	            rd = new BufferedReader(new InputStreamReader(conn.getInputStream()));
	        } else {
	            rd = new BufferedReader(new InputStreamReader(conn.getErrorStream()));
	        }
	        StringBuilder sb = new StringBuilder();
	        String line;
	        while ((line = rd.readLine()) != null) {
	            sb.append(line);
	        }
	        rd.close();
	        conn.disconnect();;
	            model.addAttribute("plantListJson", new PlantBookCtrl().xmlToJson(sb));
		return "plantBook/plantList";
	}
	public String xmlToJson(StringBuilder xml) {
        JSONObject jsonObj = XML.toJSONObject(xml.toString());
        String json = jsonObj.toString(4);
		return json;
	}
	@GetMapping("/test3")
	public String test3() {
		return "test3";
	}
}
