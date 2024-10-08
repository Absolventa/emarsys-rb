# frozen_string_literal: true
module Emarsys::FieldMapping

  ATTRIBUTES = [
    {:id => 0,   :identifier => '_interests',                  :name => 'Interests'},
    {:id => 1,   :identifier => '_firstname',                  :name => 'First Name'},
    {:id => 2,   :identifier => '_lastname',                   :name => 'Last Name'},
    {:id => 3,   :identifier => '_email',                      :name => 'E-Mail'},
    {:id => 4,   :identifier => '_date_of_birth',              :name => 'Date of Birth'},
    {:id => 5,   :identifier => '_gender',                     :name => 'Gender'},
    {:id => 6,   :identifier => '_marital_status',             :name => 'Marital Status'},
    {:id => 7,   :identifier => '_children',                   :name => 'Children'},
    {:id => 8,   :identifier => '_education',                  :name => 'Education'},
    {:id => 9,   :identifier => '_title',                      :name => 'Title'},
    {:id => 10,  :identifier => '_address',                    :name => 'Address'},
    {:id => 11,  :identifier => '_city',                       :name => 'City'},
    {:id => 12,  :identifier => '_region',                     :name => 'Region'},
    {:id => 13,  :identifier => '_zip',                        :name => 'ZIP Code'},
    {:id => 14,  :identifier => '_country',                    :name => 'Country'},
    {:id => 15,  :identifier => '_phone',                      :name => 'Phone'},
    {:id => 16,  :identifier => '_fax',                        :name => 'Fax'},
    {:id => 17,  :identifier => '_job_position',               :name => 'Job Position'},
    {:id => 18,  :identifier => '_company',                    :name => 'Company'},
    {:id => 19,  :identifier => '_department',                 :name => 'Department'},
    {:id => 20,  :identifier => '_industry',                   :name => 'Industry'},
    {:id => 21,  :identifier => '_phone_office',               :name => 'Phone (office)'},
    {:id => 22,  :identifier => '_fax_office',                 :name => 'Fax (office)'},
    {:id => 23,  :identifier => '_number_of_employees',        :name => 'Number of Employees'},
    {:id => 24,  :identifier => '_annual_revenue',             :name => 'Annual Revenue (in 000 EUR)'},
    {:id => 25,  :identifier => '_url',                        :name => 'URL'},
    {:id => 26,  :identifier => '_preferred_mail_format',      :name => 'Preferred Mail Format'},
    {:id => 27,  :identifier => '_avg_length_of_visit',        :name => 'Avg. length of visit (minutes)'},
    {:id => 28,  :identifier => '_page_views_per_day',         :name => 'Page views per day'},
    {:id => 29,  :identifier => '_days_since_last_email_sent', :name => 'Days since last e-mail sent'},
    {:id => 30,  :identifier => '_response_rate',              :name => 'Response rate (% of campaigns sent)'},
    {:id => 31,  :identifier => '_opt_in',                     :name => 'Opt-In'},
    {:id => 32,  :identifier => '_user_status',                :name => 'User status'},
    {:id => 33,  :identifier => '_contact_source',             :name => 'Contact source'},
    {:id => 34,  :identifier => '_contact_form',               :name => 'Contact form'},
    {:id => 35,  :identifier => '_registration_language',      :name => 'Registration Language'},
    {:id => 36,  :identifier => '_newsletter',                 :name => 'Newsletter'},
    {:id => 37,  :identifier => '_mobile',                     :name => 'Mobile'},
    {:id => 38,  :identifier => '_first_name_of_partner',      :name => 'First Name of Partner'},
    {:id => 39,  :identifier => '_birthdate_of_partner',       :name => 'Birthdate of Partner'},
    {:id => 40,  :identifier => '_anniversary',                :name => 'Anniversary'},
    {:id => 41,  :identifier => '_company_address',            :name => 'Company Address'},
    {:id => 42,  :identifier => '_zip_official',               :name => 'Zip Code (office)'},
    {:id => 43,  :identifier => '_city_official',              :name => 'City (office)'},
    {:id => 44,  :identifier => '_state_official',             :name => 'State (office)'},
    {:id => 45,  :identifier => '_country_official',           :name => 'Country (office)'},
    {:id => 46,  :identifier => '_salutation',                 :name => 'Salutation'},
    {:id => 47,  :identifier => '_email_valid',                :name => 'E-Mail valid'},
    {:id => 48,  :identifier => '_date_of_first_registration', :name => 'Date of first registration'}
  ]

  def self.attributes
    return @custom_attributes if excluded_default_attributes?
    return ATTRIBUTES.dup.concat(@custom_attributes) if @custom_attributes
    ATTRIBUTES
  end

  def self.set_attributes(attrs)
    @exclude_default_attributes = true
    @custom_attributes = [attrs].flatten
  end

  def self.add_attributes(attrs)
    attributes.concat([attrs].flatten)
  end

  def self.excluded_default_attributes?
    @exclude_default_attributes == true
  end

end
