def add_product_to_basket(product_url)
  @browser.goto(@base_url)
  @browser.goto(@base_url + product_url)
  while (@browser.alert.present? == false) && (@browser.text.include? 'Fetching product details')
    sleep 0.5
  end

  if @browser.alert.present?
    puts @browser.alert.text
    if @browser.alert.text == 'Something went wrong at our end. Please try again later.'
      @browser.alert.ok
      assert false, 'check the VPN as the country might not have any workers for: ' + @country
    end
  end

  if @browser.text.include? "out of stock."
    sleep 10
  end
  puts 'added item to basket, now sleeping for visible check'
  wait_for_basket
end

def add_product_to_basket_with_no_waits_or_checks(product_url)
  @browser.goto(@base_url)
  @browser.goto(@base_url + product_url)
end

def goto_basket
  @browser.goto(@base_url + 'basket')
  wait_for_basket
end

def wait_for_basket
  basket = Basket.new(@browser)
  basket.wait_for_basket
end

def get_basket_shop
  basket = Basket.new(@browser)
  return basket.get_basket_shop_name
end

def wait_for_checkout_button
  @browser.link(:id, 'checkout').wait_until_present(120)
end

def wait_while_checkout_button_is_present
  @browser.link(:id, 'checkout').wait_while_present
end

def item_in_basket_displays_shop(expected_shop_name)
  basket_shop_name = get_basket_shop
  assert (basket_shop_name.include? expected_shop_name), basket_shop_name + ' did not include: ' + expected_shop_name
end

def get_basket_item_name
  basket = Basket.new(@browser)
  return basket.get_item_name
end

def item_with_name_is_in_basket(item_name)
  product_name = get_basket_item_name
  assert (product_name.include? item_name), product_name + ' did not include: ' + item_name
end


def login_with_phone_number(phnone_no)
  wait_for_checkout_button
  @browser.span(:text, '+ Add Personal Info').wait_until_present
  sleep 1
  @browser.send_keys :space
  sleep 1
  @browser.send_keys :space

  @browser.span(:text, '+ Add Personal Info').click
  @browser.input(:id, 'email').wait_until_present
  @browser.input(:id, 'phone').wait_until_present


  @browser.text_field(:id, 'email').set DEFAULT_EMAIL
  @browser.text_field(:id, 'phone').set phnone_no
  @browser.button(:text, 'Continue').click

  @browser.execute_script('window.confirm("go get your phone and enter the pin you feckless dullard");')
  @browser.alert.wait_while_present(120)
  wait_for_checkout_button
end

def remove_added_addresses
  delivery_div = nil
  @browser.divs.each do |div|
    if div.label(:text, 'Delivery').exist?
      delivery_div = div
    end
  end

  puts 'removing addresses'
  begin
    wait_while_loading_indicator_present
    @browser.send_keys :space
    @browser.send_keys :space

    delivery_div.div(:text, /Auatomation Evangalist/).click
    @browser.div(:class, 'ub-page').wait_until_present
    sleep 1
    address_links = Array.new
    @browser.links.each do |link|
      if link.attribute_value('class') == 'ub-list-action'
        address_links.push(link.href)
      end
    end

    address_links.each do |address|
      @browser.goto(address)
      @browser.link(:text, 'Delete address').wait_until_present
      @browser.link(:text, 'Delete address').click
    end
  rescue
  end
  goto_basket

  puts 'finished removintg addresses'
end

def empty_basket
  goto_basket
  while (@browser.text.include? "You haven't added anything to your basket.") == false
    wait_while_loading_indicator_present
    exit_flag = false
    @browser.links.each do |link|
      break if exit_flag == true
      if exit_flag == false
        if (link.attribute_value('class') == 'remove-item needsclick') && (link.visible? == true)
          link.click
          exit_flag = true
          wait_while_loading_indicator_present
        end
      end
    end
    sleep 1
    goto_basket
  end
end

def basket_is_empty?
  return @browser.text.include? "You haven't added anything to your basket."
end

def remove_saved_cards
  payments_div = nil
  @browser.divs.each do |div|
    if div.label(:text, 'Payment').exist?
      payments_div = div
    end
  end
  puts "removing saved cards"
  @browser.send_keys :space
  @browser.send_keys :space
  if payments_div.span(:text, /1111/).present?
    payments_div.span(:text, /1111/).click
  end
  begin
    @browser.links.each do |link|
      if link.attribute_value('class') == 'ub-list-action'
        link.click
        wait_while_loading_indicator_present
      end
    end
  rescue
  end
  puts 'finsihed removing saved cards'
  goto_basket
end

def wait_while_loading_indicator_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
end

def checkout_button_is_disabled
  wait_for_checkout_button
  checkout_class = @browser.link(:id, 'checkout').attribute_value('class')
  assert (checkout_class.include? 'disabled'), checkout_class + ' did not contain disabled'
end


def complete_purchase
  wait_for_checkout_button
  wait_while_loading_indicator_present
  @browser.link(:id, 'checkout').click
  wait_while_checkout_button_is_present
end


def select_all_product_attributes
  wait_for_checkout_button
  wait_while_loading_indicator_present

  basket = Basket.new(@browser)
  product = basket.get_first_product

  product_attributes = product.div(:class, 'ub-product-attributes')
  attribute_count = product_attributes.selects.length
  count = 0

  while count < attribute_count
    exit_flag = false
    select = get_last_active_select_list
    if select.nil? == false
      options_array = Array.new
      options = select.options
      options.each do |option|
        options_array.push(option.value)
        puts option.value
      end


      if options_array.size > 2 && exit_flag == false
        puts options_array[1]
        select.select options_array[1]
        exit_flag = true
      end
    end
    count = count + 1
  end
end

def get_last_active_select_list
  basket = Basket.new(@browser)
  product = basket.get_first_product
  select_to_return = nil
  product_attributes = product.div(:class, 'ub-product-attributes')
  product_attributes.selects.each do |select|
    if select.selected_index == 0 && select.enabled? && select.options.length > 1
      select_to_return = select
    end
  end
  return select_to_return
end


def add_payment_card(card_number)
  wait_while_loading_indicator_present
  @browser.span(:text, '+ Add Payment Card').wait_until_present
  @browser.span(:text, '+ Add Payment Card').click

  @browser.text_field(:id, 'number').wait_until_present
  @browser.text_field(:id, 'number').click
  @browser.text_field(:id, 'number').set card_number
  @browser.text_field(:id, 'expiryDate').set '1220'
  @browser.text_field(:id, 'cvv2').set '111'
  @browser.text_field(:id, 'name').set 'kw ford'
  @browser.button(:id, 'save-card').click
  wait_while_loading_indicator_present
end

def select_address(first_line)
  wait_while_loading_indicator_present
  @browser.span(:text, '+ Add Delivery Address').wait_until_present
  wait_while_loading_indicator_present
  @browser.span(:text, '+ Add Delivery Address').click
  address_part = Regexp.new(first_line)
  # address_part_reg = Regexp.new(address_part)
  @browser.link(:text, address_part).wait_until_present
  @browser.link(:text, address_part).click
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
end


def add_address(address_suggest_string)
  wait_for_checkout_button
  wait_while_loading_indicator_present
  @browser.span(:text, '+ Add Delivery Address').wait_until_present


  @browser.send_keys :space
  @browser.send_keys :space
  sleep 0.5

  @browser.span(:text, '+ Add Delivery Address').click
  @browser.text_field(:id, 'firstname').wait_until_present
  @browser.text_field(:id, 'firstname').set 'Auatomation'
  @browser.select(:id, 'title').select 'Mr'
  @browser.text_field(:id, 'lastname').set 'Evangalist'
  @browser.text_field(:id, 'suggest').set address_suggest_string
  @browser.link(:text, '27-31, Clerkenwell Close').wait_until_present
  sleep 3
  @browser.link(:text, '27-31, Clerkenwell Close').wait_until_present
  @browser.link(:text, '27-31, Clerkenwell Close').click
  @browser.text_field(:id, 'company').wait_until_present
  @browser.text_field(:id, 'company').set 'UB'
  @browser.div(:class, "loading-bg").wait_while_present
  @browser.button(:text, 'Save address').click
end

def click_continue
  @browser.button(:text, 'Continue').wait_until_present
  @browser.button(:text, 'Continue').click
end
