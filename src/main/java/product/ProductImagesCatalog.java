/**
 *
 */
package product;

/**
 * @author smitj
 *
 */
public class ProductImagesCatalog {
	private int image_id;
	private int product_item_id;
	private int map_id;
	private String image_path;

	/**
	 * @param image_id
	 * @param product_item_id
	 * @param map_id
	 * @param image_path
	 */
	public ProductImagesCatalog(int image_id, int product_item_id, int map_id, String image_path) {
		super();
		this.image_id = image_id;
		this.product_item_id = product_item_id;
		this.map_id = map_id;
		this.image_path = image_path;
	}

	/**
	 * @return the image_id
	 */
	public int getImage_id() {
		return image_id;
	}

	/**
	 * @return the image_path
	 */
	public String getImage_path() {
		return image_path;
	}

	/**
	 * @return the map_id
	 */
	public int getMap_id() {
		return map_id;
	}

	/**
	 * @return the product_item_id
	 */
	public int getProduct_item_id() {
		return product_item_id;
	}

	/**
	 * @param image_id the image_id to set
	 */
	public void setImage_id(int image_id) {
		this.image_id = image_id;
	}

	/**
	 * @param image_path the image_path to set
	 */
	public void setImage_path(String image_path) {
		this.image_path = image_path;
	}

	/**
	 * @param map_id the map_id to set
	 */
	public void setMap_id(int map_id) {
		this.map_id = map_id;
	}

	/**
	 * @param product_item_id the product_item_id to set
	 */
	public void setProduct_item_id(int product_item_id) {
		this.product_item_id = product_item_id;
	}

}
