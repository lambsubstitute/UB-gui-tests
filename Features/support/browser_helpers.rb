
#get todays day
def GetDay()
  today = Time.now
  today = today.strftime('%a')
  puts today
  return today
end

# Gets a regular expression to do class matching with so you don't need to worry
# about any other non-cuke class' being on an html element
# e.g. @browser.link(:class, get_class_regex("cuke_add_button"))
def cuke_class(target_class)
  #/(\b)cuke_#{target_class.gsub(' ','_')}(\b)/
end


## methods for working with links ##
# get a link by class, returns link object if found
def link_by_class(class_name)
  return @browser.link(:class, cuke_class(class_name))
end

# check if the link exists by class, returns true or false
def link_by_class_exists(class_name)
  return link_by_class(class_name).exist?
end

# get link by text, returns link object if found
def link_by_text(link_text)
  return @browser.link(:text, link_text)
end

# check if link exists by text, returns true or false
def link_by_text_exists(link_text)
  return link_by_text(link_text).exist?
end

# get link by href, returns link object
def link_by_href(link_href)
  return @browser.link(:href, link_href)
end

def link_by_href_exists(link_href)
  return link_by_href(link_href).exist?
end

# get link by id, returns link object
def link_by_id(link_id)
  return @browser.link(:id, link_id)
end

# check if link exists by its id, returns true or false
def link_by_id_exists(link_id)
  return link_by_id(link_id).exist?
end



##methods for working with labels
# check if label exists by class, returns true or false
def label_by_class_exists(label_class)
  return @browser.label(:class, cuke_class(label_class)).exist?
end

# check if label exists by text, returns true or false
def label_by_text_exists(label_text)
  return @browser.label(:text, label_text).exist?
end



## methods for working with checkboxes
# get checkbox by class, returns checkbox object
def checkbox_by_class(checkbox_class)
  return @browser.checkbox(:class, cuke_class(checkbox_class))
end

# check checkbox with class exists, returns true or false
def checkbox_by_class_exists(checkbox_class)
  return checkbox_by_class(checkbox_class).exist?
end

# get check box by value, returns checkbox object
def checkbox_by_value(checkbox_value)
  return @browser.checkbox(:value, checkbox_value)
end

# set check box by value
def checkbox_by_value_set(checkbox_value)
  checkbox_by_value(checkbox_value).set
end

# get checkbox by id, returns checkbox object
def checkbox_by_id(checkbox_id)
  return @browser.checkbox(:id, checkbox_id)
end

# set the checkbox
def checkbox_by_id_set(checkbox_id)
  checkbox_by_id(checkbox_id).set
end




## methods for working with images
#get image by its alt, returns image object
def image_by_alt(image_alt)
  return @browser.image(:alt, image_alt)
end

# check image alt exists, returns true or false
def image_by_alt_exists(image_alt)
  return image_by_alt(image_alt).exist?
end




## methods for working with spans ##
# get a span by class, returns span object
def span_by_class(class_name)
  return @browser.span(:class, cuke_class(class_name))
end

#span by class exists, returns true or false
def span_by_class_exists(class_name)
  return span_by_class(class_name).exist?
end

# get a span by text, returns span object
def span_by_text(text_name)
  return @browser.span(:text, text_name)
end

#span by text exists, returns true or false
def span_by_text_exists(text_name)
  return span_by_text(text_name).exist?
end




## methods for working with divs ##
# get a div by class, returns div object
def div_by_class(class_name)
  return @browser.div(:class, cuke_class(class_name))
end

# check if div exists by class, returns true or false
def div_by_class_exists(class_name)
  return div_by_class(class_name).exist?
end

# get a div by id, returns boolean
def div_by_id_exists(id_name)
  return div_by_id(id_name).exist?
end

# get a div by id, returns div object
def div_by_id(id_name)
  return @browser.div(:id, id_name)
end


## methods for working with headers
# check if H2 header exists via its text, returns true or false
def h2_with_text_exists(text)
  return @browser.h2(:text, text).exist?
end

# check if H2 element exists via class, returns true or false
def h2_with_class_exists(h2_class)
  return @browser.h2(:class, cuke_class(h2_class)).exist?
end

# check if H3 header exists via its text, returns true or false
def h3_with_text_exists(text)
  return @browser.h3(:text, text).exist?
end

# check if H3 header exists via its class, returns true or false
def h3_with_class_exists(h3_class)
  return @browser.h3(:class, cuke_class(h3_class)).exist?
end




## methods for working with text
# check if text exists in the page, returns true or false
def text_exists(text)
  return @browser.text.should include (text)  #<< not returning correct value, should not be using should in this circumstance  TODO: CHECK THIS WITH PROPER LINE ON FULL TEST SUITE
                                              # return @browser.text.include? (text)
end




## methods for working with text fields
# get a textfield by class, returns textfeld object
def textfield_by_class(class_name)
  return @browser.text_field(:class, cuke_class(class_name))
end

# check textfield exists, returns true or false
def textfield_by_class_exists(class_name)
  return textfield_by_class(class_name).exist?
end

# set the text for a textfield by class, returns nothing
def textfield_by_class_set_text(class_name, text)
  textfield_by_class(class_name).set text
end

# get a textfield by id, returns textfield object
def textfield_by_id(id_name)
  return @browser.text_field(:id, id_name)
end

# check textfield exists by id, returns true or false
def textfield_by_id_exists(id_name)
  return textfield_by_id(id_name).exist?
end

# set the text for a textfield by id, returns nothing
def textfield_by_id_set_text(id_name, text)
  textfield_by_id(id_name).set text
end

def textfield_by_id_clear_text(id_name)
  textfield_by_id(id_name).clear
end





## methods for working with radio buttons
#get radio button by class, returns radio button
def radio_by_class(radio_class)
  return @browser.radio(:class, cuke_class(radio_class))
end





## methods for working with parapgrahs
# get a paragraph by class, returns paragraph
def paragraph_by_class(class_name)
  return @browser.p(:class, cuke_class(class_name))
end

# check a paragraph by class exists, returns true or false
def paragraph_by_class_exists(class_name)
  return paragraph_by_class(class_name).exist?
end

# get parapgraph by text, returns parapragh object
def paragraph_by_text(text)
  return @browser.p(:text, text)
end

# check a paragraph by text exists, returns true or false
def paragraph_by_text_exists(text)
  return paragraph_by_text(text).exist?
end




## methods for working with dropdowns
# get a select by class, returns dropdown object
def select_by_class(class_name)
  @browser.select_list(:class, cuke_class(class_name))
end

# check dropdown exists, returns true or false
def select_by_class_exists(class_name)
  return select_by_class(class_name).exist?
end

def select_by_class_set_value(class_name, value)
  select_by_class(class_name).select value
end

# get select list from id, returns select list object
def select_by_id(id_name)
  @browser.select_list(:id, id_name)
end

def select_by_id_set_value(id_name, value)
  select_by_id(id_name).select value
end


## methods for file field
#find file find by id
def filefield_by_id(filefield_id)
  return @browser.file_field(:id, filefield_id)
end

# set the filefield field
def filefield_by_id_set_value(filefield_id, value)
  filefield_by_id(filefield_id).set value
end







## methods for working with buttons
# get a button by class, returns button object
def button_by_class(class_name)
  @browser.button(:class, class_name)
end

# check if button exists by its class, returns true or false
def button_by_class_exists(class_name)
  return button_by_class(class_name).exist?
end

# get a button by id, returns button object
def button_by_id(button_id)
  return @browser.button(:id, button_id)
end

# get button by text, returns button object
def button_by_text(button_text)
  return @browser.button(:text, button_text)
end

# check if button exists by its text, returns true or false
def button_by_text_exists(button_text)
  return button_by_text(button_text).exist?
end


## methods for lists - ordered and unordered
# get a ordered list by class, returns ordered list object
def ol_by_class(class_name)
  return @browser.ol(:class, cuke_class(class_name))
end

def ol_by_id(id_name)
  return @browser.ol(:id, id_name)
end

# get a li by class, returns list object
def li_by_class(class_name)
  return @browser.li(:class, cuke_class(class_name))
end

def li_by_id(id_name)
  return @browser.li(:id, id_name)
end




## methods for tables
# get table by class, returns table object
def table_by_class(table_class)
  return  @browser.table(:class, cuke_class(table_class))
end

# check if tabel exists by class, returns true or false
def table_by_class_exists(table_class)
  return table_by_class(table_class).exist?
end

# get table by id, returns table object
def table_by_id(table_id)
  return  @browser.table(:id, table_id)
end

# check table exists by id, returns true or false
def table_by_id_exists(table_id)
  return  table_by_id(table_id).exist?
end



# gets elements by class
def elements_by_class(element_type, class_name)
  @browser.elements_by_xpath("//#{element_type}[contains(@class,'#{class_name}')]")
end

# get element by class
def element_by_class(element_type, class_name)
  @browser.element_by_xpath("//#{element_type}[contains(@class,'#{class_name}')]")
end

# get element by xpath
def element_by_xpath(xpath)
  @browser.element_by_xpath(xpath)
end

# get elements by xpath
def elements_by_xpath(xpath)
  @browser.elements_by_xpath(xpath)
end