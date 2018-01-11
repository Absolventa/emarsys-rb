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

      # Create a new custom field
      #
      # @param name [String] name of the new field
      # @param application_type [String] type of the new field
      # @param string_id [String] optional string_id for the new field
      # @return [Hash] Result Data
      # @example
      #   Emarsys::Field.create(
      #     name: 'New field',
      #     application_type: 'shorttext',
      #     string_id: 'string_id_for_the_new_field'
      #   )
      #   Emarsys::Field.create(
      #     name: 'New number field',
      #     application_type: 'numeric'
      #   )
      def create(name:, application_type:, string_id: nil, account: nil)
        params = { name: name, application_type: application_type }
        params[:string_id] = string_id if string_id
        post account, 'field', params
      end
    end

  end

end
