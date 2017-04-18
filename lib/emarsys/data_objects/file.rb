# frozen_string_literal: true
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
      def collection(account: nil, **params)
        get account, 'file', params
      end

      # Upload a file to the media database
      #
      # @param filename [String] The filename
      # @param file [String] Base64 encoded version of the file
      # @param folder [Integer, String] optinal folder to out te file into
      # @return [Hash] Result data
      # @example
      #   Emarsys::File.create("my_file.jpg", "asdhkajsh...")
      #   Emarsys::File.create("my_file.jpg", "asdhkajsh...", 3)
      def create(filename:, file:, folder: nil, account: nil)
        params = {:filename => filename, :file => file}
        params.merge!(:folder => folder) unless folder.nil?
        post account, 'file', params
      end
    end

  end

end
