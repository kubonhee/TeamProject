package net.yangchoo.controller;
import java.util.Collection;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import com.fasterxml.jackson.annotation.JsonInclude.Include;
import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.core.type.TypeReference;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.PropertyNamingStrategy;

import net.yangchoo.domain.GoogleOAuthRequest;
import net.yangchoo.domain.GoogleOAuthResponse;

@Controller
public class OauthController {
	@RequestMapping(value = "/google/auth", method = RequestMethod.GET)
	public String googleAuth(Model model, @RequestParam(value = "code") String authCode)
			throws JsonProcessingException {
		
		//HTTP Request를 위한 RestTemplate
				RestTemplate restTemplate = new RestTemplate();

				//Google OAuth Access Token 요청을 위한 파라미터 세팅
				
				GoogleOAuthRequest googleOAuthRequestParam = GoogleOAuthRequest
						.builder()
						.clientId("1015554852025-5uhhbn8qftl60g0dba2g3q1hc1k76u2m.apps.googleusercontent.com")
						.clientSecret("ppIZrK0pWhSqH4BCFt720kJn")
						.code(authCode)
						.redirectUri("http://localhost:8080")
//						.responseType("code")
						.grantType("authorization_code").build();
				
				//JSON 파싱을 위한 기본값 세팅
				//요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
				ObjectMapper mapper = new ObjectMapper();
				mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
				mapper.setSerializationInclusion(Include.NON_NULL);

				//AccessToken 발급 요청
				ResponseEntity<String> resultEntity = restTemplate.postForEntity("https://accounts.google.com/o/oauth2/v2/auth" , googleOAuthRequestParam, String.class);

				//Token Request
				GoogleOAuthResponse result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleOAuthResponse>() {
				});

				//ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다)
				String jwtToken = result.getIdToken();
				String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo")
				.queryParam("id_token", jwtToken).build().toUriString();
				
				String resultJson = restTemplate.getForObject(requestUrl, String.class);
				
//				Map<String,String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>(){});
//				model.addAllAttributes(userInfo);
				model.addAttribute("token", result.getAccessToken());

				return "/";
		
//			System.out.println("--------------------------절취선1");
//			//HTTP Request를 위한 RestTemplate
//			RestTemplate restTemplate = new RestTemplate();
//	 
//			//Google OAuth Access Token 요청을 위한 파라미터 세팅
//		/*	GoogleOAuthRequest googleOAuthRequestParam =  new GoogleOAuthRequest();
//			googleOAuthRequestParam.setClientId("1028174609911-433j0ub6ablgbnubj4i6bvm0dclv23je.apps.googleusercontent.com");
//			googleOAuthRequestParam.setClientSecret("ALSEXcRMY_WyYA_ogxYAAXvp");
//			googleOAuthRequestParam.setCode(authCode);
//			googleOAuthRequestParam.setRedirectUri("http://localhost:8080");
//			googleOAuthRequestParam.setGrantType("authorization_code");*/
//			
//			GoogleOAuthRequest googleOAuthRequestParam = GoogleOAuthRequest
//					.builder()
//					.clientId("1015554852025-5uhhbn8qftl60g0dba2g3q1hc1k76u2m.apps.googleusercontent.com")
//					.clientSecret("ppIZrK0pWhSqH4BCFt720kJn")
//					.code(authCode)
//					.redirectUri("http://localhost:8080")
////					.responseType("code")
//					.grantType("authorization_code").build();
//			
//			System.out.println("--------------------------절취선2");
//			System.out.println(googleOAuthRequestParam);
//			
//			//JSON 파싱을 위한 기본값 세팅
//			//요청시 파라미터는 스네이크 케이스로 세팅되므로 Object mapper에 미리 설정해준다.
//			
//			ObjectMapper mapper = new ObjectMapper();
//			mapper.setPropertyNamingStrategy(PropertyNamingStrategy.SNAKE_CASE);
//			mapper.setSerializationInclusion(Include.NON_NULL);
//			
//			System.out.println("--------------------------절취선3");
//			System.out.println(mapper);
//			System.out.println("--------------------------절취선4");
//			
//			//AccessToken 발급 요청
//			ResponseEntity<String> resultEntity = restTemplate.postForEntity("https://accounts.google.com/o/oauth2/v2/auth", googleOAuthRequestParam, String.class);
//			//ResponseEntity<String> resultEntity = restTemplate.postForEntity("https://accounts.google.com/o/oauth2/token", googleOAuthRequestParam, String.class);
//			
//			/*GOOGLE_TOKEN_BASE_URL*/
//			
////			System.out.println(resultEntity);
//			System.out.println("--------------------------절취선5");
//			
//			//Token Request
//			GoogleOAuthResponse result = mapper.readValue(resultEntity.getBody(), new TypeReference<GoogleOAuthResponse>() {
//			});
//			
//			System.out.println(result);
//			System.out.println("--------------------------절취선6");
//	 
//			//ID Token만 추출 (사용자의 정보는 jwt로 인코딩 되어있다)
//			String jwtToken = result.getIdToken();
////			String requestUrl = UriComponentsBuilder.fromHttpUrl("https://accounts.google.com/o/oauth2/token").queryParam("id_token", jwtToken).toUriString();//.encode 해줘야함
//			
//			String requestUrl = UriComponentsBuilder.fromHttpUrl("https://oauth2.googleapis.com/tokeninfo").queryParam("id_token", jwtToken).toUriString();//.encode 해줘야함
//			String resultJson = restTemplate.getForObject(requestUrl, String.class);
//			System.out.println("--------------------------절취선6");
//			Map<String,String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>(){});
//			//Map<String,String> userInfo = mapper.readValue(resultJson, new TypeReference<Map<String, String>>(){});
//			model.addAllAttributes((Collection<?>) userInfo);
//			model.addAttribute("token", result.getAccessToken());
//			
//			return "/";
		}
	}

