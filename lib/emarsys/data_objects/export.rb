module Emarsys

  # Methods for the Export API
  #
  #
  class Export < DataObject

    class << self
      def resource(id)
        get "export/#{id}", {}
      end
    end

  end

end