/**
 *
 */
package product;

/**
 * @author smitj
 *
 */
public class ProductItemCatalog {
	private int product_item_id;
	private int item_listing_price;
	private int item_selling_price;
	private int item_quantity;
	private boolean item_status;

	/**
	 * @param product_item_id
	 * @param item_listing_price
	 * @param item_selling_price
	 * @param item_quantity
	 * @param item_status
	 */
	public ProductItemCatalog(int product_item_id, int item_listing_price, int item_selling_price, int item_quantity,
			boolean item_status) {
		super();
		this.product_item_id = product_item_id;
		this.item_listing_price = item_listing_price;
		this.item_selling_price = item_selling_price;
		this.item_quantity = item_quantity;
		this.item_status = item_status;
	}

	/**
	 * @return the item_listing_price
	 */
	public int getItem_listing_price() {
		return item_listing_price;
	}

	/**
	 * @return the item_quantity
	 */
	public int getItem_quantity() {
		return item_quantity;
	}

	/**
	 * @return the item_selling_price
	 */
	public int getItem_selling_price() {
		return item_selling_price;
	}

	/**
	 * @return the product_item_id
	 */
	public int getProduct_item_id() {
		return product_item_id;
	}

	/**
	 * @return the item_status
	 */
	public boolean isItem_status() {
		return item_status;
	}

	/**
	 * @param item_listing_price the item_listing_price to set
	 */
	public void setItem_listing_price(int item_listing_price) {
		this.item_listing_price = item_listing_price;
	}

	/**
	 * @param item_quantity the item_quantity to set
	 */
	public void setItem_quantity(int item_quantity) {
		this.item_quantity = item_quantity;
	}

	/**
	 * @param item_selling_price the item_selling_price to set
	 */
	public void setItem_selling_price(int item_selling_price) {
		this.item_selling_price = item_selling_price;
	}

	/**
	 * @param item_status the item_status to set
	 */
	public void setItem_status(boolean item_status) {
		this.item_status = item_status;
	}

	/**
	 * @param product_item_id the product_item_id to set
	 */
	public void setProduct_item_id(int product_item_id) {
		this.product_item_id = product_item_id;
	}

}
