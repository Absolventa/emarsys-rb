# frozen_string_literal: true
module Emarsys

  # Methods for the Export API
  #
  #
  class Export < DataObject
    class << self

      # Find a specific export
      #
      # @param id [Integer, String] The internal emarsys id
      # @return [Hash] Result data
      # @example
      #   Emarsys::Export.resource(2)
      def resource(id, account: nil)
        get account, "export/#{id}", {}
      end

      # Download export data
      #
      # @param id [Integer, String] The internal emarsys id
      # @option offset [Integer] Defines the ID to start listing from
      # @option limit [Integer] Defines how many IDs are listed
      # @return [String] text/csv
      # @example
      #   Emarsys::Export.data(2)
      def data(id, offset: nil, limit: nil, account: nil)
        params = {}
        params.merge!(:offset => offset) if offset
        params.merge!(:limit => limit) if limit
        get account, "export/#{id}/data", params
      end

      # Export a segment
      #
      # @param filter [Integer] The segment ID
      # @option distribution_method [String] ftp, sftp, local or mail
      # @option contact_fields [Array] Contact field IDs to export
      # @return [Hash] Result data
      # @example
      #   Emarsys::Export.filter(filter: 123, distribution_method: 'local', contact_fields: [1, 3, 106533])
      def filter(filter:, distribution_method:, contact_fields:, account: nil, **params)
        params.merge!(
          filter: filter,
          distribution_method: distribution_method,
          contact_fields: contact_fields
        )
        post account, "export/filter", params
      end
    end

  end

end
