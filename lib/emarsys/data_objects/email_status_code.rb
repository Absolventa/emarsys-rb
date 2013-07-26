module Emarsys
  class EmailStatusCode < DataObject
    CODES = [
      {'1'   => 'In design'},
      {'2'   => 'Tested'},
      {'3'   => 'Launched'},
      {'4'   => 'Ready to launch'},
      {'-3'  => 'Deactivated'}
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