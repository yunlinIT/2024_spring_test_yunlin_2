package com.example.demo.util;

import java.io.UnsupportedEncodingException;
import java.lang.reflect.Array;
import java.net.URLEncoder;
import java.util.Map;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

public class Ut {
	private static final ObjectMapper objectMapper = new ObjectMapper();

	public static String f(String format, Object... args) {
		return String.format(format, args);
	}

	public static boolean isNullOrEmpty(String str) {
		return str == null || str.trim().length() == 0;
	}

	public static boolean isEmpty(Object obj) {
		if (obj == null) {
			return true;
		}

		if (obj instanceof Integer) {
			return (int) obj == 0;
		}

		if (obj instanceof String) {
			return ((String) obj).trim().length() == 0;
		}

		if (obj instanceof Map) {
			return ((Map<?, ?>) obj).isEmpty();
		}

		if (obj.getClass().isArray()) {
			return Array.getLength(obj) == 0;
		}

		return false;
	}

	public static String jsHistoryBack(String resultCode, String msg) {
		if (resultCode == null) {
			resultCode = "";
		}
		if (msg == null) {
			msg = "";
		}
		String resultMsg = resultCode + " / " + msg;

		return Ut.f("""
				<script>
					const resultMsg = '%s'.trim();
					if(resultMsg.length > 0){
						alert(resultMsg);
					}
					history.back();
				</script>
				""", resultMsg);
	}

	public static String jsReplace(String resultCode, String msg, String replaceUri) {
		if (resultCode == null) {
			resultCode = "";
		}
		if (msg == null) {
			msg = "";
		}
		if (replaceUri == null) {
			msg = "/";
		}

		String resultMsg = resultCode + " / " + msg;

		return Ut.f("""
				<script>
					const resultMsg = '%s'.trim();
					if(resultMsg.length > 0){
						alert(resultMsg);
					}
					location.replace('%s');
				</script>
				""", resultMsg, replaceUri);
	}

	public static String toJsonString(Object obj) {
		try {
			return objectMapper.writeValueAsString(obj);
		} catch (JsonProcessingException e) {
			e.printStackTrace();
			// 실제 프로덕션 환경에서는 로깅 프레임워크를 사용하거나 적절한 예외 처리를 해야 합니다.
			return null;
		}
	}

	public static String getEncodedCurrentUri(String currentUri) {

		try {
			return URLEncoder.encode(currentUri, "UTF-8");
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
			return currentUri;
		}

	}

}