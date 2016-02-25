# encoding: utf-8
# class documentation

# page built from: http://staging.ub.io/basket

class NewCard
  include PageInitializer

  # Element identifiers
  MAIN_DIV_CLASS = 'ub-page'
  COUNTRY_SELECT_ID = 'countryId'
  CARDNUMBER_TEXTFIELD_ID = 'number'
  EXPIRYDATE_TEXTFIELD_ID = 'expiryDate'
  CVV_TEXTFIELD_ID = 'cvv2'
  NAMEONCARD_TEXTFIELD_ID = 'name'
  SAVE_BUTTON_ID = 'save-card'

  TITLE_SELECT_ID = 'title'

  def get_new_card_form
    @browser.div(:class, MAIN_DIV_CLASS).wait_until_present
    @browser.text_field(:id, NAMEONCARD_TEXTFIELD_ID).wait_until_present
    return @browser.div(:class, MAIN_DIV_CLASS)
  end

  def add_name(name)
    new_card_form = get_new_card_form
    new_card_form.text_field(:id, NAMEONCARD_TEXTFIELD_ID).set name
  end

  def add_card_number(card_number)
    new_card_form = get_new_card_form
    new_card_form.text_field(:id, CARDNUMBER_TEXTFIELD_ID).set card_number
  end

  def add_expiry_date(expiry_date)
    new_card_form = get_new_card_form
    new_card_form.text_field(:id, EXPIRYDATE_TEXTFIELD_ID).set expiry_date
  end

  def add_cvv(cvv)
    new_card_form = get_new_card_form
    new_card_form.text_field(:id, CVV_TEXTFIELD_ID).set cvv
  end



  def save_card
    new_card_form = get_new_card_form
    new_card_form.button(:id,  SAVE_BUTTON_ID).click
  end

  def goto_new_card_page(base_url)
    @browser.goto(base_url + NEW_CARD_FORM_URL)
  end

end