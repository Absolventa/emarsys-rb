# frozen_string_literal: true
module Emarsys

  # Methods for the Folder API
  #
  #
  class Folder < DataObject
    class << self

      # List folders
      #
      # @param params [Hash] optional search params
      # @option params [Integer, String] :folder filter by parent folder
      # @return [Hash] List of folders
      # @example
      #   Emarsys::Folder.collection
      #   Emarsys::Folder.collection(:folder => 3)
      def collection(account: nil, **params)
        get account, 'folder', params
      end
    end

  end

end
