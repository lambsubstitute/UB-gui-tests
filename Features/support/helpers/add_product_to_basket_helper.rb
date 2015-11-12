def add_product_to_basket(product_url)
  @browser.goto(@base_url)
  @browser.goto(@base_url + product_url)
  while @browser.text.include? 'Fetching product details'
    sleep 0.5
  end
  puts 'added item to basket, now sleeping for visible check'
  @browser.div(:id, 'ub-basket-contents').wait_until_present
end


def login_with_phone_number(phnone_no)
  @browser.link(:id, 'checkout').wait_until_present
  @browser.span(:text, '+ Add Personal Info').wait_until_present
  sleep 1
  @browser.send_keys :space
  @browser.send_keys :space

  @browser.span(:text, '+ Add Personal Info').click
  @browser.input(:id, 'email').wait_until_present
  @browser.input(:id, 'phone').wait_until_present


  @browser.text_field(:id, 'email').set 'keith.ford1980@googlemail.com'
  @browser.text_field(:id, 'phone').set phnone_no
  @browser.button(:text, 'Continue').click

  @browser.execute_script('window.confirm("go get your phone and enter the pin you feckless dullard");')
  @browser.alert.wait_while_present(120)
  @browser.link(:id, 'checkout').wait_until_present(120)
end

def remove_added_addresses
  delivery_div = nil
  @browser.divs.each do |div|
    if div.label(:text,'Delivery').exist?
      delivery_div = div
    end
  end

  puts 'removing addresses'
  begin
    @browser.div(:id, 'ub-loading-indicator').wait_while_present
    @browser.send_keys :space
    @browser.send_keys :space

    delivery_div.div(:text,/Auatomation Evangalist/).click
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
  @browser.goto(@base_url)

  puts 'finished removintg addresses'
end

def empty_basket
  @browser.goto(@base_url + 'basket')
  @browser.div(:id, 'ub-basket-contents').wait_until_present

  while (@browser.text.include? "You haven't added anything to your basket.") == false

    @browser.div(:id, 'ub-loading-indicator').wait_while_present
    exit_flag = false
    @browser.links.each do |link|
      break if exit_flag == true
      if exit_flag == false
        if (link.attribute_value('class') == 'remove-item needsclick') && (link.visible? == true)
          link.click
          exit_flag = true
          @browser.div(:id, 'ub-loading-indicator').wait_while_present
        end
      end
    end
    @browser.goto(@base_url + 'basket')
  end
end

def remove_saved_cards
  payments_div = nil
  @browser.divs.each do |div|
    if div.label(:text,'Payment').exist?
      # puts 'found master payments div'
      payments_div = div
      #puts payments_div.text
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
        @browser.div(:id, 'ub-loading-indicator').wait_while_present
      end
    end
  rescue
  end
  puts 'finsihed removing saved cards'
  @browser.goto(@base_url)
end



def item_in_basket_displays_shop(shop_name)
  assert (@browser.div(:class, 'ub-shop').text.include? shop_name), @browser.div(:class, 'ub-shop').text + ' did not include: ' + shop_name
end


def item_with_name_is_in_basket(item_name)
  product = @browser.div(:class, 'ub-product')
  assert (product.li(:class, 'ub-product-title').text.include? item_name), product.li(:class, 'ub-product-title').text + ' did not include: ' + item_name
end

def checkout_button_is_disabled
  @browser.link(:id, 'checkout').wait_until_present
  checkout_class = @browser.link(:id, 'checkout').attribute_value('class')
  assert (checkout_class.include? 'disabled'), checkout_class + ' did not contain disabled'
end


def complete_purchase
  @browser.link(:id, 'checkout').wait_until_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.link(:id, 'checkout').click
  @browser.link(:id, 'checkout').wait_while_present
end


def select_product_size
  @browser.link(:id, 'checkout').wait_until_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.selects.each do |select|
    if select.attribute_value('name') == 'notused'
      options_array = Array.new
      options = select.options
      options.each do |option|
        options_array.push(option.value)
        # puts option.value
      end
      if options_array.size > 2
        select.select options_array[1]
      end
    end
  end
  #@browser.select(:name, 'notused').select 'UK 4'
end


def add_payment_card(card_number)
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.span(:text, '+ Add Payment Card').wait_until_present
  @browser.span(:text, '+ Add Payment Card').click

  @browser.text_field(:id, 'number').wait_until_present
  @browser.text_field(:id, 'number').click
  @browser.text_field(:id, 'number').set card_number
  @browser.text_field(:id, 'expiryDate').set '1220'
  @browser.text_field(:id, 'cvv2').set '222'
  @browser.text_field(:id, 'name').set 'kw ford'
  @browser.button(:id, 'save-card').click
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
end

def select_address(first_line)
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.span(:text, '+ Add Delivery Address').wait_until_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
  @browser.span(:text, '+ Add Delivery Address').click
  address_part = Regexp.new(first_line)
  @browser.link(:text, address_part).wait_until_present
  @browser.link(:text, address_part).click
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
end


def add_address(address_suggest_string)
  @browser.link(:id, 'checkout').wait_until_present
  @browser.div(:id, 'ub-loading-indicator').wait_while_present
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
  @browser.link(:text, '27-31 Clerkenwell Close, London').wait_until_present
  sleep 1
  @browser.link(:text, '27-31 Clerkenwell Close, London').wait_until_present
  @browser.link(:text, '27-31 Clerkenwell Close, London').click
  @browser.text_field(:id, 'company').wait_until_present
  @browser.text_field(:id, 'company').set 'UB'
  @browser.div(:class, "loading-bg").wait_while_present
  @browser.button(:text, 'Save address').click
end

def click_continue
  @browser.button(:text, 'Continue').wait_until_present
  @browser.button(:text, 'Continue').click
end
