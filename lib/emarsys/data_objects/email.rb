# frozen_string_literal: true
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
      # @option params [Integer] :email_category associated Email-Category-Id
      # @option params [Integer] :segment associated Segment-id
      # @option params [Integer] :contactlist associated Contactlist-id
      # @option params [String] :html_source
      # @option params [String] :text_source
      # @option params [Integer] :unsubscribe (optional)
      # @option params [Integer] :browse (optional)
      # @return [Hash] internal id of the campaign
      # @example
      #   Emarsys::Email.create(
      #     name: 'Test', language: 'de', fromemail: 'john.doe@example.com', fromname: 'John Doe',
      #     subject: 'Test Subject', :email_category: 3, segment: 1121, contactlist: 0,
      #     html_source: '<h1>Test</h1>', text_source: 'Test'
      #   )
      def create(params = {})
        post "email", params
      end

      # Launches an email
      #
      # @param id [Integer, String] Internal email id
      # @param params [hash] Optional launch parmeters
      # @option params [Datetime] :schedule launch time
      # @option params [String] :timezone
      # @return [Hash] Result data
      # @example
      #   Emarsys::Email.launch(1)
      def launch(id, params = {})
        post "email/#{id}/launch", params
      end

      # Preview an email
      #
      # @param id [Integer, String] Internal email id
      # @param version [String] 'html' or 'text' version
      # @return [Hash] Result data
      # @example
      #   Emarsys::Email.preview(1)
      def preview(id, version = 'html')
        post "email/#{id}/preview", {:version => version}
      end

      # View response summary of an email
      #
      # @param id [Integer, String] Internal email id
      # @return [Hash] Result data
      # @example
      #   Emarsys::Email.response_summary(1)
      def response_summary(id)
        get "email/#{id}/responsesummary", {}
      end

      # Instruct emarsys to send a test mail
      #
      # @param id [Integer, String] Internal email id
      # @param params [hash] recipient parmeters
      # @option params [String] :recipientlist email_addresses separated by ';'
      # @option params [Integer] :segment_id custom segement id
      # @option params [Integer] :contactlist_id custom contactlist id
      # Only one of the three parameters must be sent.
      #
      # @return [Hash] Result data
      # @example
      #   Emarsys::Email.send_test_mail(1, {:recipientlist => 'john.doe@example.com;jane.doe@example.com'})
      def send_test_mail(id, params = {})
        post "email/#{id}/sendtestmail", params
      end

      # Returns the delivery status of an email
      #
      # @param id [Integer, String] Internal email id
      # @param params [hash] recipient parmeters
      # @option params [String] 'lastId'
      # @option params [Integer] 'launchId'
      # @return [Hash] Result data
      # @example
      #   Emarsys::Email.delivery_status(1)
      def delivery_status(id, params = {})
        post "email/#{id}/getdeliverystatus", params
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
