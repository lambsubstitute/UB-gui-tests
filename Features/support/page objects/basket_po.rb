# encoding: utf-8
# class documentation

# page built from: http://staging.ub.io/basket

class Basket
  include PageInitializer

  # Element identifiers
  MAIN_DIV_ID = 'ub-basket-contents'
  SHOPTITLE_DIV_CLASS = 'ub-shop'
  PRODUCT_DIV_CLASS = 'ub-product'
  PRODUCT_LI_CLASS = 'ub-product-title'

  def get_basket
    wait_for_basket
    return @browser.div(:class, MAIN_DIV_ID)
  end

  def wait_for_basket
    if @browser.text.include? "You haven't added anything to your basket."
      puts 'basket is empty'
    else
      while @browser.text.include? 'Checking availability'
        sleep 0.5
      end
        # todo might need to put some code here to cope with the ot of stokc generic error
    end
  end

  def get_basket_shop_name
    basket = get_basket
    return basket.div(:class, SHOPTITLE_DIV_CLASS).text
  end

  def get_first_product
    basket = get_basket
    return basket.div(:class, PRODUCT_DIV_CLASS)
  end

  def get_item_name
    product = get_first_product
    return product.li(:class, PRODUCT_LI_CLASS).text
  end

  def get_first_basket_item_name
    product = get_first_product
    return product.li(:class, PRODUCT_LI_CLASS).text
  end

  def basket_present?
    basket = get_basket
    return basket.div(:class, PRODUCT_DIV_CLASS).present?
  end

  def get_item_price
    basket = get_basket
    return basket.li(:class, 'ub-product-price').text
  end

  def get_totals_price
    basket = get_basket
    return basket.div(:class, 'ub-total-container').text
  end


end