module Emarsys
  class Source < DataObject
    class << self
      def collection
        get 'source', {}
      end

      def create(params = {})
        post 'source/create', params
      end

      def destroy(id)
        delete "source/#{id}", {}
      end
    end
  end
end