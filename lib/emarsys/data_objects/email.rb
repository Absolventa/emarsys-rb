module Emarsys

  # Methods for the Email API
  #
  #
  class Email < DataObject
    class << self

      # List email campaigns
      #
      # @param params [Hash] Optional filter for the emails
      # @option params [String] :status filter by status
      # @option params [String] :contactlist filter by contactlist
      # @return [Hash] List of emails
      # @example
      #   Emarsys::Email.collection
      #   Emarsys::Email.collection(:status => 3)
      #   Emarsys::Email.collection(:contactlist => 5)
      def collection(params = {})
        get 'email', params
      end

      # Get Email attirbutes of a specific email
      #
      # @param id [Integer, String] The internal id of an email
      # @return [Hash] Attributes hash
      # @example
      #   Emarsys::Email.resource(1)
      def resource(id)
        get "email/#{id}", {}
      end

      # Create a new email campaign
      #
      # @param params [Hash] Email information to create
      # @option params [String] :name Name of the email campagin
      # @option params [String] :language Language Code
      # @option params [String] :fromemail sets the from-header email
      # @option params [String] :fromname sets the from-header name
      # @option params [String] :subject Subject of the email
      # @option params [String] :email_category associated Email-Category-Id
      # @return [Hash] internal id of the campaign
      def create(params = {})
        post "email", params
      end

      # TODO POST /<id>/launch
      def launch(id, params = {})
        raise "Not implemented yet"
      end

      def preview(id, version = 'html')
        post "email/#{id}/preview", {:version => version}
      end

      def response_summary(id)
        get "email/#{id}/responsesummary", {}
      end

      # TODO POST /<id>/sendtestmail
      def send_test_mail
        raise "Not implemented yet"
      end

      # TODO POST /<id>/url
      def send_test_mail(id, params = {})
        #recipient_list = [], segment_id = nil, contactlist_id = nil
        raise "Not implemented yet"
      end

      # TODO POST /getdeliverystatus
      def delivery_status(id, params = {})
        raise "Not implemented yet"
      end

      # TODO POST /getlaunchesofemail
      def email_launches(id)
        raise "Not implemented yet"
      end

      # TODO POST /getresponses
      def export_responses(params = {})
        raise "Not implemented yet"
      end
    end
  end
end