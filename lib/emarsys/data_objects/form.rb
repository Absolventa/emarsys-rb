module Emarsys

  # Methods for the Form API
  #
  #
  class Form < DataObject
    class << self

      # List segments
      #
      # @return [Hash] List of forms
      # @example
      #   Emarsys::Form.collection
      def collection
        get 'form', {}
      end

    end
  end

end