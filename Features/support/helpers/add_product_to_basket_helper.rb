def add_product_to_basket(product_url)
  #@browser.goto(@base_url)

  @browser.goto(@base_url + product_url)

  # because of cookie issue double adding products, this hasto be wrapped because no idea when it will force reload
  # FUCKING ANNOYING
  begin
  while (@browser.alert.present? == false) && (@browser.text.include? 'Fetching product details')
    sleep 0.5
  end
  rescue
  end

  if @browser.alert.present?
    puts @browser.alert.text
    if @browser.alert.text == 'Something went wrong at our end. Please try again later.'
      @browser.alert.ok
      assert false, 'check the VPN as the country might not have any workers for: ' + @country
    end
  end
  sleep 3
  if @browser.text.include? 'out of stock.'
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
  goto_basket
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
      @browser.link(:text, /DELETE ADDRESS/).wait_until_present
      @browser.link(:text, /DELETE ADDRESS/).click
    end
  rescue
  end
  wait_while_loading_indicator_present
  goto_basket

  puts 'finished removintg addresses'
end

def empty_basket
  #goto_basket
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
  #@browser.goto(@base_url + 'basket/choosecard')
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
 # @browser.goto(@base_url + 'basket/choosecard')
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
  wait_while_loading_indicator_present
  goto_basket
end

def wait_while_loading_indicator_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
end

def checkout_button_is_disabled?
  wait_for_checkout_button
  checkout_class = @browser.link(:id, 'checkout').attribute_value('class')
  assert (checkout_class.include? 'disabled'), checkout_class + ' did not contain disabled'
end

def checkout_button_is_enabled?
  wait_for_checkout_button
  checkout_class = @browser.link(:id, 'checkout').attribute_value('class')
  assert ((checkout_class.include? 'disabled') == false), checkout_class + ' did contain disabled'
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
      options_value_array = Array.new
      options = select.options
      options.each do |option|
        if option.text.include? 'out of stock'
          puts 'not entering this option as a selectable option: ' + option.text
        else
          options_array.push(option.text)
          options_value_array.push(option.value)
          puts 'text:' +  option.text
          puts 'value:' +  option.value
        end
      end


      if options_array.size > 2 && exit_flag == false
       # sleep 1000000

        begin
          #cant tell if the select option is uppercase or lower case as always displays upper case but wont select with upper case
          puts 'trying: ' + options_array[1]
          select.select options_array[1]
        rescue
          puts 'FAILED!!'
          begin
          puts 'trying: ' +  options_value_array[1]
          select.select options_value_array[1]
          rescue
            puts 'FAILED!!'
            begin
            puts 'trying: ' +  options_value_array[1].upcase
            select.select options_value_array[1].upcase
            rescue
              puts 'FAILED!!'
              puts 'trying: ' + options_array[1].gsub(' ', '').gsub("\n", '')
              select.select options_array[1].gsub(' ', '').gsub("\n", '')
            end
          end
        end
        exit_flag = true
      end
    end
    count = count + 1
  end
end

def get_last_active_select_list
  sleep 1
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
  #@browser.span(:text, '+ Add Payment Card').wait_until_present
  @browser.goto(@base_url + 'user/card/new?back=/basket&basket=true')
  @browser.text_field(:id, 'number').wait_until_present
  @browser.text_field(:id, 'number').click
  @browser.text_field(:id, 'number').set card_number
  @browser.text_field(:id, 'expiryDate').set '1220'
  @browser.text_field(:id, 'cvv2').set '222'
  @browser.text_field(:id, 'name').set 'kw ford'
  @browser.button(:id, 'save-card').click
  wait_while_loading_indicator_present
  @clean_cards_flag = true
end

def select_address(first_line)
  wait_while_loading_indicator_present
  @browser.span(:text, '+ Add Delivery Address').wait_until_present
  wait_while_loading_indicator_present
  address_part = Regexp.new(first_line)
  @browser.link(:text, address_part).wait_until_present
  @browser.link(:text, address_part).click
  wait_while_loading_indicator_present
end


def add_address(address_suggest_string)
  wait_for_checkout_button
  wait_while_loading_indicator_present
  @browser.goto(@base_url  +  NEW_ADDRESS_URL)

  new_address = NewAddress.new(@browser)
  new_address.add_address_line1('clerkenwell green')
  new_address.add_city('London')
  new_address.select_title('Mr')
  new_address.add_company('UB')
  new_address.add_first_name('Automation')
  new_address.add_last_name('Evangalist')
  new_address.add_county('England')
  new_address.add_postcode('ec31 5dc')
  wait_while_loading_indicator_present
  new_address.save_address
  @clean_address_flag = true
  wait_while_loading_indicator_present
end

def click_continue
  @browser.button(:text, 'Continue').wait_until_present
  @browser.button(:text, 'Continue').click
end
