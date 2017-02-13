require 'spec_helper'

describe Emarsys::Response do

  class FakeResponse
    attr_accessor :body

    def initialize(body)
      self.body = body
    end

    def to_str
      body
    end

    module JSON
      # Value taken from an actual response from Emarsys
      def headers
        {:content_type => 'text/html; charset=utf-8'}
      end
    end

    module CSV
      def headers
        {:content_type => 'text/csv'}
      end
    end
  end

  describe '#initialize' do
    context "json" do
      let(:response_string) { "{\"replyCode\":0,\"replyText\":\"Something\",\"data\":1}" }
      let(:response) { Emarsys::Response.new(FakeResponse.new(response_string).extend(FakeResponse::JSON)) }
      it 'sets code, text and data attributes on initialize' do
        expect(response.code).to eq(0)
        expect(response.text).to eq("Something")
        expect(response.data).to eq(1)
      end
    end
    context "csv" do
      let(:response_string) { "user_id,Vorname,E-Mail,Version Name,Url,Zeit\r\n" }
      let(:response) { Emarsys::Response.new(FakeResponse.new(response_string).extend(FakeResponse::CSV)) }
      it 'sets code and data attributes on initialize' do
        expect(response.code).to eq(0)
        expect(response.data).to eq("user_id,Vorname,E-Mail,Version Name,Url,Zeit\r\n")
      end
    end
  end

  describe '#result' do
    let(:response_string) { "{\"replyCode\":0,\"replyText\":\"Something\",\"data\":1}" }
    let(:response) { Emarsys::Response.new(FakeResponse.new(response_string).extend(FakeResponse::JSON)) }

    it "returns data if code is 0" do
      allow(response).to receive(:code).and_return(0)
      expect(response.result).to eq(1)
    end

    it "raises BadRequest error if code is not 0" do
      allow(response).to receive(:code).and_return(1)
      expect{response.result}.to raise_error(Emarsys::BadRequest)
    end

    it "raises Unauthorized error if http-status is 401" do
      allow(response).to receive(:code).and_return(1)
      allow(response).to receive(:status).and_return(401)
      expect{response.result}.to raise_error(Emarsys::Unauthorized)
    end

    it "raises TooManyRequests error if http-status is 429" do
      allow(response).to receive(:code).and_return(1)
      allow(response).to receive(:status).and_return(429)
      expect{response.result}.to raise_error(Emarsys::TooManyRequests)
    end
  end

end
