module Emarsys
  class File < DataObject
    class << self
      def collection(params = {})
        get 'file', params
      end

      def create(filename, base64_encoded_file, folder_id = nil)
        params = {:filename => filename, :file => base64_encoded_file}
        params.merge!({:folder => folder_id}) unless folder_id.nil?
        post 'file', params
      end
    end
  end
end