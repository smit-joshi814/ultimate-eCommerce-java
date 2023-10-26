package generalModule;

public class FormatPrice {

	public static String formatPrice(String value) {
		value = value.replace(",", "");
		char lastDigit = value.charAt(value.length() - 1);
		String result = "";
		int len = value.length() - 1;
		int nDigits = 0;

		for (int i = len - 1; i >= 0; i--) {
			result = value.charAt(i) + result;
			nDigits++;
			if (((nDigits % 2) == 0) && (i > 0)) {
				result = "," + result;
			}
		}
		return SiteConstants.COUNTRY_CURRANCY_UNICODE + (result + lastDigit);
	}
}
