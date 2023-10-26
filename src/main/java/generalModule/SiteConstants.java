package generalModule;

public class SiteConstants {
	public static final String SITE_URL = "http://localhost:8080/MyECommerce";
	public static final String[] ANIMATE = { "fade-up", "fade-down", "fade-right", "fade-left", "fade-up-right",
			"fade-up-left", "fade-down-right", "fade-down-left", "flip-left", "flip-right", "flip-up", "flip-down",
			"zoom-in", "zoom-in-up", "zoom-in-down", "zoom-in-left", "zoom-in-right", "zoom-out", "zoom-out-up",
			"zoom-out-down", "zoom-out-right", "zoom-out-left" };

	// SETTING BOTH PAGE ITEMS SAME (VALUE MUST BE EVEN)
	public static final int PRODUCTS_PER_PAGE = 6;

	// FOR NUMBER OF ITEMS TO BE SHOWN PER PAGE
	public static int PRODUCT_RS_GRID_SIZE = PRODUCTS_PER_PAGE;
	public static int PRODUCTS_RS_LIST_SIZE = 4;

	// FOR DISCOUNT RATE BADGE
	public static int MINIMUM_DISCOUNT_RATE_BADGE = 20;
	public static int MAXIMUM_DISCOUNT_RATE_BADGE = 80;

	// FOR DANGER STOCK LEFT MESSAGE
	public static int STOCK_LEFT_MESSAGE_BADGE_AT = 30;

	public static final boolean ADD_TO_CART_ON_GRID_LIST = true;

	// DON'T YOU DARE TO TOUCH OR REMOVE THIS
	public static String VAR_NAME_COMBO = "";

	public static boolean HAND_HALD_TOOLBAR = false;

	// SET THE MAXIMUM AGE OF CART COOKIE
	public static int MAX_COOKIE_AGE_FOR_CART = 60 * 60 * 24;

	public static String COUNTRY_CURRANCY_UNICODE = "&#8377;"; // FOR INDIAN RUPEE SYMBOL

	// SET THE MAXIMUM AGE OF USER COOKIE
	public static final int MAX_COOKIE_AGE_FOR_USER = 60 * 60 * 24 * 5;

	// SET SERVICE TAX
	public static double SERVICE_TAX = 0.01; // 1%

	// HOME PAGE FEACTURED CATEGORY
	public static String FEACTURED_CATEGORY = "Shirts";
	public static String FEACTURED_CATEGORY_IMAGE = "";
}
