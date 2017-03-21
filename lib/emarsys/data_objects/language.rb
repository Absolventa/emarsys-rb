# frozen_string_literal: true
module Emarsys

  # Methods for the Lanugage API
  #
  #
  class Language < DataObject
    class << self

      # List languages
      #
      # @return [Hash] List of languages
      # @example
      #   Emarsys::Language.collection
      def collection(account: nil)
        get account, 'language', {}
      end

    end
  end
end
