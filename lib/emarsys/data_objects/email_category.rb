# frozen_string_literal: true
module Emarsys

  # Methods for the EmailCategory API
  #
  #
  class EmailCategory < DataObject
    class << self

      # List email categories
      #
      # @return [Hash] List of email_categories
      # @example
      #   Emarsys::EmailCategory.collection
      def collection(account: nil)
        get account, 'emailcategory', {}
      end

    end
  end
end
