/**
 *
 */
package product;

/**
 * @author smitj
 *
 */
public class ItemVariationCatalog {
	private int product_item_id;
	private int mapping_id;
	private String variaton_name;
	private String variation_value;

	/**
	 * @param product_item_id
	 * @param mapping_id
	 * @param variaton_name
	 * @param variation_value
	 */
	public ItemVariationCatalog(int product_item_id, int mapping_id, String variaton_name, String variation_value) {
		super();
		this.product_item_id = product_item_id;
		this.mapping_id = mapping_id;
		this.variaton_name = variaton_name;
		this.variation_value = variation_value;
	}

	/**
	 * @return the mapping_id
	 */
	public int getMapping_id() {
		return mapping_id;
	}

	/**
	 * @return the product_item_id
	 */
	public int getProduct_item_id() {
		return product_item_id;
	}

	/**
	 * @return the variation_value
	 */
	public String getVariation_value() {
		return variation_value;
	}

	/**
	 * @return the variaton_name
	 */
	public String getVariaton_name() {
		return variaton_name;
	}

	/**
	 * @param mapping_id the mapping_id to set
	 */
	public void setMapping_id(int mapping_id) {
		this.mapping_id = mapping_id;
	}

	/**
	 * @param product_item_id the product_item_id to set
	 */
	public void setProduct_item_id(int product_item_id) {
		this.product_item_id = product_item_id;
	}

	/**
	 * @param variation_value the variation_value to set
	 */
	public void setVariation_value(String variation_value) {
		this.variation_value = variation_value;
	}

	/**
	 * @param variaton_name the variaton_name to set
	 */
	public void setVariaton_name(String variaton_name) {
		this.variaton_name = variaton_name;
	}

}
