# encoding: utf-8
# class documentation

# page built from: http://staging.ub.io/basket

class NewAddress
  include PageInitializer

  # Element identifiers
  MAIN_DIV_ID = 'ub-basket-contents'
  FIRSTNAME_TEXTFIELD_ID = 'firstname'
  LASTNAME_TEXTFIELD_ID = 'lastname'
  ADDLINE1_TEXTFIELD_ID = 'line1'
  CITY_TEXTFIELD_ID = 'city'
  COUNTRY_TEXTFIELD_ID = 'province'
  POSTCODE_TEXTFIELD_ID = 'postcode'

  TITLE_SELECT_ID = 'title'

  def add_first_name(name)
    @browser.text_field(:id, FIRSTNAME_TEXTFIELD_ID).wait_until_present
    @browser.text_field(:id, FIRSTNAME_TEXTFIELD_ID).set name
  end

  def add_last_name(last_name)
    @browser.text_field(:id, LASTNAME_TEXTFIELD_ID).wait_until_present
    @browser.text_field(:id, LASTNAME_TEXTFIELD_ID).set last_name
  end

  def add_address_line1(line1)
    @browser.text_field(:id, ADDLINE1_TEXTFIELD_ID).wait_until_present
    @browser.text_field(:id, ADDLINE1_TEXTFIELD_ID).set line1
  end

#  @browser.goto(@base_url  + 'user/address/new?back=/basket&basket=true')

#  @browser.select(:id, 'title').select 'Mr'

 # @browser.text_field(:id, 'line1').set '27-31, Clerkenwell Close'
  #@browser.text_field(:id, 'city').set 'London'
  #@browser.text_field(:id, 'postcode').set 'ec31 5dc'
  #@browser.text_field(:id, 'province').set 'England'
  #@browser.text_field(:id, 'company').wait_until_present
  #@browser.text_field(:id, 'company').set 'UB'
  #@browser.div(:class, "loading-bg").wait_while_present
  #sleep 1000000
  #@browser.button(:text, /SAVE ADDRESS/).click




  def get_basket
    wait_for_basket
    return @browser.div(:class, MAIN_DIV_ID)
  end

  def wait_for_basket
    if @browser.text.include? "You haven't added anything to your basket."
      puts 'basket is empty'
    else
      while @browser.text.include? 'Checking availability'
        sleep 1
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