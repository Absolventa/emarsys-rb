# frozen_string_literal: true
module Emarsys

  # Methods for the Field API
  #
  #
  class Field < DataObject
    class << self

      # List data fields
      #
      # @param params [Hash] optional translation params
      # @option params [Integer, String] :translate translate to another language
      # @return [Hash] List of fields
      # @example
      #   Emarsys::Field.collection
      #   Emarsys::Field.collection(:translate => 'en')
      def collection(account: nil, **params)
        params = params.stringify_keys
        if params['translate']
          get account, "field/translate/#{params['translate'].to_s}", {}
        else
          get account, 'field', {}
        end
      end

      # Query the choice option for a specific field
      #
      # @param id [Integer, String] id of the field
      # @return [Hash] Result Data
      # @example
      #   Emarsys::Field.choice(3)
      def choice(id, account: nil)
        get account, "field/#{id}/choice", {}
      end
    end

  end

end
