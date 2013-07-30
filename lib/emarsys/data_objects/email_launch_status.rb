module Emarsys
  class EmailLaunchStatus < DataObject
    CODES = [
      {'0'   => 'Not launched'},
      {'1'   => 'Launch called via API, launching in Progress'},
      {'2'   => 'Email launched or scheduled for future launch'},
      {'10'   => 'Error (details in api_error)'}
    ]

    class << self
      def collection(params = {})
        CODES
      end

      def resource(id)
        CODES.select{|hash| hash.has_key?(id.to_s)}[0]
      end
    end
  end
end