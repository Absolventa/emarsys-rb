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
      def resource(id)
        get "export/#{id}", {}
      end
    end

  end

end