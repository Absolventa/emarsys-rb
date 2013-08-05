module Emarsys

  # Methods for the Source API
  #
  #
  class Source < DataObject
    class << self

      # List sources
      #
      # @return [Hash] List of sources
      # @example
      #   Emarsys::Source.collection
      def collection
        get 'source', {}
      end

      # Create a new source
      #
      # @param name [String] Name of the new source
      # @return [Hash] Result data
      # @example
      #   Emarsys::Source.create("My new source")
      def create(name)
        post 'source/create', {:name => name}
      end

      # Destroy a specific source
      #
      # @param id [Integer, String] The internal emarsys id
      # @return [Hash] Result data
      # @example
      #   Emarsys::Source.destroy(2)
      def destroy(id)
        delete "source/#{id}", {}
      end

    end
  end
end