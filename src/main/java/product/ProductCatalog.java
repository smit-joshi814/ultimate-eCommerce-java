package product;

public class ProductCatalog {

	private int product_id;
	private String product_name;
	private String product_description;
	private String product_category;
	private String brand_name;
	private int product_category_id;
	private int product_brand_id;

	/**
	 * @param product_id
	 * @param product_name
	 * @param product_description
	 * @param product_category
	 * @param brand_name
	 */
	public ProductCatalog(int product_id, String product_name, String product_description, String product_category,
			String brand_name) {
		super();
		this.product_id = product_id;
		this.product_name = product_name;
		this.product_description = product_description;
		this.product_category = product_category;
		this.brand_name = brand_name;
	}

	/**
	 * @param product_id
	 * @param product_name
	 * @param product_description
	 * @param product_category
	 * @param brand_name
	 * @param product_category_id
	 * @param product_brand_id
	 */
	public ProductCatalog(int product_id, String product_name, String product_description, String product_category,
			String brand_name, int product_category_id, int product_brand_id) {
		super();
		this.product_id = product_id;
		this.product_name = product_name;
		this.product_description = product_description;
		this.product_category = product_category;
		this.brand_name = brand_name;
		this.product_category_id = product_category_id;
		this.product_brand_id = product_brand_id;
	}

	/**
	 * @return the brand_name
	 */
	public String getBrand_name() {
		return brand_name;
	}

	/**
	 * @return the product_brand_id
	 */
	public int getProduct_brand_id() {
		return product_brand_id;
	}

	/**
	 * @return the product_category
	 */
	public String getProduct_category() {
		return product_category;
	}

	/**
	 * @return the product_category_id
	 */
	public int getProduct_category_id() {
		return product_category_id;
	}

	/**
	 * @return the product_description
	 */
	public String getProduct_description() {
		return product_description;
	}

	/**
	 * @return the product_id
	 */
	public int getProduct_id() {
		return product_id;
	}

	/**
	 * @return the product_name
	 */
	public String getProduct_name() {
		return product_name;
	}

	/**
	 * @param brand_name the brand_name to set
	 */
	public void setBrand_name(String brand_name) {
		this.brand_name = brand_name;
	}

	/**
	 * @param product_brand_id the product_brand_id to set
	 */
	public void setProduct_brand_id(int product_brand_id) {
		this.product_brand_id = product_brand_id;
	}

	/**
	 * @param product_category the product_category to set
	 */
	public void setProduct_category(String product_category) {
		this.product_category = product_category;
	}

	/**
	 * @param product_category_id the product_category_id to set
	 */
	public void setProduct_category_id(int product_category_id) {
		this.product_category_id = product_category_id;
	}

	/**
	 * @param product_description the product_description to set
	 */
	public void setProduct_description(String product_description) {
		this.product_description = product_description;
	}

	/**
	 * @param product_id the product_id to set
	 */
	public void setProduct_id(int product_id) {
		this.product_id = product_id;
	}

	/**
	 * @param product_name the product_name to set
	 */
	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

}
