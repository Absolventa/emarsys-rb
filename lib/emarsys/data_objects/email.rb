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
      def collection(account: nil, **params)
        get account, 'email', params
      end

      # Get Email attirbutes of a specific email
      #
      # @param id [Integer, String] The internal id of an email
      # @return [Hash] Attributes hash
      # @example
      #   Emarsys::Email.resource(1)
      def resource(id, account: nil)
        get account, "email/#{id}", {}
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
      def create(account: nil, **params)
        post account, "email", params
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
      def launch(id, account: nil, **params)
        post account, "email/#{id}/launch", params
      end

      # Preview an email
      #
      # @param id [Integer, String] Internal email id
      # @param version [String] 'html' or 'text' version
      # @return [Hash] Result data
      # @example
      #   Emarsys::Email.preview(1)
      def preview(id, version: 'html', account: nil)
        post account, "email/#{id}/preview", {:version => version}
      end

      # View response summary of an email
      #
      # @param id [Integer, String] Internal email id
      # @return [Hash] Result data
      # @example
      #   Emarsys::Email.response_summary(1)
      def response_summary(id, account: nil)
        get account, "email/#{id}/responsesummary", {}
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
      def send_test_mail(id, account: nil, **params)
        post account, "email/#{id}/sendtestmail", params
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
      def delivery_status(id, account: nil, **params)
        post account, "email/#{id}/getdeliverystatus", params
      end

      # Tracking email campaign unsubscribes
      #
      # @param params [hash] unsubscribe parameters
      # @option params [String] 'contact_uid'
      # @option params [String] 'email_id'
      # @option params [String] 'launch_list_id'
      # @return [Hash] Result data
      # @example
      #   Emarsys::Email.unsubscribe({contact_uid: '1', email_id: '1', launch_list_id: '1'})
      def unsubscribe(account: nil, **params)
        post account, "email/unsubscribe", params
      end
      
      # https://help.emarsys.com/hc/en-us/articles/115004523714
      def email_launches(id, account: nil)
        post account, "email/getlaunchesofemail", emailId: id
      end

      # Exports the selected fields of all contacts who responded to emails
      # within the specified time range.
      #
      # @param distribution_method [String] ftp or local
      # @param time_range [array] Array with two elements (start date, end date)
      # @param contact_fields [array] Array of contact field IDs
      # @param sources [array] Array which defines sources
      # @param analysis_fields [array] Array that defines the contact behaviours to analyse
      # @option params [hash]
      # @return [Hash] Result data
      # @example
      #   Emarsys::Email.export_responses(
      #     'local',
      #     ['2012-02-09', '2014-08-13'],
      #     [1, 3],
      #     ['trackable_links'],
      #     [5, 8, 13]
      #   )
      def export_responses(distribution_method:, time_range:, contact_fields:, sources:, analysis_fields:, account: nil, **params)
        params.merge!(
          :distribution_method => distribution_method,
          :time_range => time_range,
          :contact_fields => Emarsys::ParamsConverter.new(contact_fields).convert_to_ids,
          :sources => sources,
          :analysis_fields => analysis_fields
        )
        post account, "email/getresponses", params
      end

      # http://documentation.emarsys.com/resource/developers/endpoints/email/query-responses/
      def responses(type:, start_date: nil, end_date: nil, campaign_id: nil, account: nil)
        params = { type: type }
        if !campaign_id.nil?
          params.merge!(campaign_id: campaign_id)
        elsif !start_date.nil? && !end_date.nil?
          params.merge!(start_date: start_date, end_date: end_date)
        else
          raise "Either campaign_id OR start_date/end_date must be provided"
        end
        post account, "email/responses", params
      end

      # http://documentation.emarsys.com/resource/developers/endpoints/email/query-responses-result/
      def responses_result(query_id, account: nil)
        get account, "email/#{query_id}/responses", {}
      end
    end
  end
end
