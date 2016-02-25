# encoding: utf-8
# class documentation

# page built from: http://staging.ub.io/basket

class ChooseAddress
  include PageInitializer

  # Element identifiers
  MAIN_DIV_CLASS = 'ub-page'
  SELECTEDADDRESSSECTION_DIV_CLASS = 'form-core primary-select form-core-nth default-selection'
  ADDRESSSECTION_DIV_CLASS = /form-core primary-select form-core-nth/




  def goto_add_choose_address_page(base_url)
    @browser.goto(base_url  +  ADDRESS_LIST_URL)
  end




end