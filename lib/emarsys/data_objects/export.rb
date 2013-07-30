module Emarsys
  class Export < DataObject
    class << self
      def resource(id)
        get "export/#{id}", {}
      end
    end
  end
end