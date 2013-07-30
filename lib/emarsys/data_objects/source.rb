module Emarsys
  class Source < DataObject
    class << self
      def collection
        get 'source', {}
      end

      def create(name)
        post 'source/create', {:name => name}
      end

      def destroy(id)
        delete "source/#{id}", {}
      end
    end
  end
end