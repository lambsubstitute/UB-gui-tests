# encoding: utf-8
# class documentation

# page built from: http://staging.ub.io/basket

class NewAddress
  include PageInitializer

  # Element identifiers
  MAIN_DIV_CLASS = 'ub-page'
  COUNTRY_SELECT_ID = 'countryId'
  FIRSTNAME_TEXTFIELD_ID = 'firstname'
  LASTNAME_TEXTFIELD_ID = 'lastname'
  ADDLINE1_TEXTFIELD_ID = 'line1'
  COMPANY_TEXTFIELD_ID = 'company'
  CITY_TEXTFIELD_ID = 'city'
  COUNTRY_TEXTFIELD_ID = 'province'
  POSTCODE_TEXTFIELD_ID = 'postcode'

  SAVE_BUTTON_REGEX = /SAVE ADDRESS/

  TITLE_SELECT_ID = 'title'

  def get_new_address_form
    @browser.div(:class, MAIN_DIV_CLASS).wait_until_present
    @browser.text_field(:id, FIRSTNAME_TEXTFIELD_ID).wait_until_present
    return @browser.div(:class, MAIN_DIV_CLASS)
  end

  def add_first_name(name)
    new_address_form = get_new_address_form
    new_address_form.text_field(:id, FIRSTNAME_TEXTFIELD_ID).set name
  end

  def add_last_name(last_name)
    new_address_form = get_new_address_form
    new_address_form.text_field(:id, LASTNAME_TEXTFIELD_ID).set last_name
  end

  def add_address_line1(line1)
    new_address_form = get_new_address_form
    new_address_form.text_field(:id, ADDLINE1_TEXTFIELD_ID).set line1
  end

  def add_company(company)
    new_address_form = get_new_address_form
    new_address_form.text_field(:id, COMPANY_TEXTFIELD_ID).set company
  end

  def add_city(city)
    new_address_form = get_new_address_form
    new_address_form.text_field(:id, CITY_TEXTFIELD_ID).set city
  end

  def add_county(country)
    new_address_form = get_new_address_form
    new_address_form.text_field(:id, COUNTRY_TEXTFIELD_ID).set country
  end

  def add_postcode(postcode)
    new_address_form = get_new_address_form
    new_address_form.text_field(:id, POSTCODE_TEXTFIELD_ID).set postcode
  end

  def select_title(title)
    new_address_form = get_new_address_form
    new_address_form.select(:id, TITLE_SELECT_ID).select title
  end

  def select_country(country)
    new_address_form = get_new_address_form
    new_address_form.select(:id, COUNTRY_SELECT_ID).select country
  end

  def return_available_countries
    new_address_form = get_new_address_form
    return new_address_form.select(:id, COUNTRY_SELECT_ID).values
  end

  def return_available_titles
    new_address_form = get_new_address_form
    return new_address_form.select(:id, TITLE_SELECT_ID).values
  end

  def save_address
    new_address_form = get_new_address_form
    new_address_form.button(:text,  SAVE_BUTTON_REGEX).click
  end

end