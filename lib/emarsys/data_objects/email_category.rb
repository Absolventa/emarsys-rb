module Emarsys

  # Methods for the EmailCategory API
  #
  #
  class EmailCategory < DataObject

    class << self
      # List email categories
      #
      # @return [Hash] List of email_categories
      def collection
        get 'emailcategory', {}
      end
    end

  end
end