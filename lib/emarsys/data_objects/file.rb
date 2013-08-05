module Emarsys

  # Methods for the File API
  #
  #
  class File < DataObject
    class << self

      # List files
      #
      # @param params [Hash] optional search params
      # @option params [Integer, String] :folder filter by folder
      # @return [Hash] List of files
      # @example
      #   Emarsys::File.collection
      #   Emarsys::File.collection(:folder => 3)
      def collection(params = {})
        get 'file', params
      end

      # Upload a file to the media database
      #
      # @param filename [String] The filename
      # @param base64_encoded_file [String] Base64 encoded version of the file
      # @param folder_id [Integer, String] optinal folder to out te file into
      # @return [Hash] Result data
      # @example
      #   Emarsys::File.create("my_file.jpg", "asdhkajsh...")
      #   Emarsys::File.create("my_file.jpg", "asdhkajsh...", 3)
      def create(filename, base64_encoded_file, folder_id = nil)
        params = {:filename => filename, :file => base64_encoded_file}
        params.merge!({:folder => folder_id}) unless folder_id.nil?
        post 'file', params
      end
    end

  end

end