package generalModule;

public class GetPercantege {
	public static int getPercantage(int listng_price, int selling_price) {
		return (((listng_price - selling_price) * 100) / listng_price);
	}
}
