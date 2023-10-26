package product;

public class Cart {
	private int product_id;
	private int product_item_id;
	private int product_price;
	private int product_quantity;
	private int product_final_price;
	private String product_name;
	private String option1;
	private String option2;
	private String[] option3 = new String[2];
	private String[] option4 = new String[2];
	private String product_item_image_path;
	private boolean isInStock;
	private int stock_items;

	public Cart() {

	}

	/**
	 * @param product_item_id
	 * @param product_price
	 * @param product_quantity
	 * @param product_name
	 * @param option1
	 * @param option2
	 * @param product_item_image_path
	 */
	public Cart(int product_id, int product_item_id, int product_price, int product_quantity, String product_name,
			String option1, String product_item_image_path, boolean isInStock) {
		super();
		this.product_id = product_id;
		this.product_item_id = product_item_id;
		this.product_price = product_price;
		this.product_quantity = product_quantity;
		this.product_final_price = product_price * product_quantity;
		this.product_name = product_name;
		this.option1 = option1;
		this.product_item_image_path = product_item_image_path;
		this.isInStock = isInStock;
	}

	public Cart(int product_id, int product_item_id, int product_price, int product_quantity, String product_name,
			String option1, String option2, String product_item_image_path, boolean isInStock) {
		super();
		this.product_id = product_id;
		this.product_item_id = product_item_id;
		this.product_price = product_price;
		this.product_quantity = product_quantity;
		this.product_final_price = product_price * product_quantity;
		this.product_name = product_name;
		this.option1 = option1;
		this.option2 = option2;
		this.product_item_image_path = product_item_image_path;
		this.isInStock = isInStock;
	}

	public Cart(int product_id, int product_item_id, int product_price, int product_quantity, String product_name,
			String option1, String option2, String[] option3, String product_item_image_path, boolean isInStock) {
		super();
		this.product_id = product_id;
		this.product_item_id = product_item_id;
		this.product_price = product_price;
		this.product_quantity = product_quantity;
		this.product_final_price = product_price * product_quantity;
		this.product_name = product_name;
		this.option1 = option1;
		this.option2 = option2;
		this.option3 = option3;
		this.product_item_image_path = product_item_image_path;
		this.isInStock = isInStock;
	}

	public Cart(int product_id, int product_item_id, int product_price, int product_quantity, String product_name,
			String option1, String option2, String[] option3, String[] option4, String product_item_image_path,
			boolean isInStock) {
		super();
		this.product_id = product_id;
		this.product_item_id = product_item_id;
		this.product_price = product_price;
		this.product_quantity = product_quantity;
		this.product_final_price = product_price * product_quantity;
		this.product_name = product_name;
		this.option1 = option1;
		this.option2 = option2;
		this.option3 = option3;
		this.option4 = option4;
		this.product_item_image_path = product_item_image_path;
		this.isInStock = isInStock;
	}

	/**
	 * @return the option1
	 */
	public String getOption1() {
		return option1;
	}

	/**
	 * @return the option2
	 */
	public String getOption2() {
		return option2;
	}

	/**
	 * @return the option3
	 */
	public String[] getOption3() {
		return option3;
	}

	/**
	 * @return the option4
	 */
	public String[] getOption4() {
		return option4;
	}

	/**
	 * @return the product_final_price
	 */
	public int getProduct_final_price() {
		return product_final_price;
	}

	/**
	 * @return the product_id
	 */
	public int getProduct_id() {
		return product_id;
	}

	/**
	 * @return the product_item_id
	 */
	public int getProduct_item_id() {
		return product_item_id;
	}

	/**
	 * @return the product_item_image_path
	 */
	public String getProduct_item_image_path() {
		return product_item_image_path;
	}

	/**
	 * @return the product_name
	 */
	public String getProduct_name() {
		return product_name;
	}

	/**
	 * @return the product_price
	 */
	public int getProduct_price() {
		return product_price;
	}

	/**
	 * @return the product_quantity
	 */
	public int getProduct_quantity() {
		return product_quantity;
	}

	/**
	 * @return the stock_items
	 */
	public int getStock_items() {
		return stock_items;
	}

	/**
	 * @return the isInStock
	 */
	public boolean isInStock() {
		return isInStock;
	}

	/**
	 * @param isInStock the isInStock to set
	 */
	public void setInStock(boolean isInStock) {
		this.isInStock = isInStock;
	}

	/**
	 * @param option1 the option1 to set
	 */
	public void setOption1(String option1) {
		this.option1 = option1;
	}

	/**
	 * @param option2 the option2 to set
	 */
	public void setOption2(String option2) {
		this.option2 = option2;
	}

	/**
	 * @param option3 the option3 to set
	 */
	public void setOption3(String[] option3) {
		this.option3 = option3;
	}

	/**
	 * @param option4 the option4 to set
	 */
	public void setOption4(String[] option4) {
		this.option4 = option4;
	}

	public void setProduct_final_price() {
		this.product_final_price = product_price * product_quantity;
	}

	/**
	 * @param product_id the product_id to set
	 */
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	/**
	 * @param product_item_id the product_item_id to set
	 */
	public void setProduct_item_id(int product_item_id) {
		this.product_item_id = product_item_id;
	}

	/**
	 * @param product_item_image_path the product_item_image_path to set
	 */
	public void setProduct_item_image_path(String product_item_image_path) {
		this.product_item_image_path = product_item_image_path;
	}

	/**
	 * @param product_name the product_name to set
	 */
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	/**
	 * @param product_price the product_price to set
	 */
	public void setProduct_price(int product_price) {
		this.product_price = product_price;
	}

	/**
	 * @param product_quantity the product_quantity to set
	 */
	public void setProduct_quantity(int product_quantity) {
		this.product_quantity = product_quantity;
	}

	/**
	 * @param stock_items the stock_items to set
	 */
	public void setStock_items(int stock_items) {
		this.stock_items = stock_items;
	}

}
