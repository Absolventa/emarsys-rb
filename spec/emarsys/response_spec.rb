require 'spec_helper'

describe Emarsys::Response do

  describe '#initialize' do
    it 'sets code, text and data attributes on initialize' do
      response_string = "{\"replyCode\":0,\"replyText\":\"Something\",\"data\":1}"
      response = Emarsys::Response.new(response_string)
      expect(response.code).to eq(0)
      expect(response.text).to eq("Something")
      expect(response.data).to eq(1)
    end
  end

  describe '#result' do
    let(:response) { Emarsys::Response.new("{\"replyCode\":0,\"replyText\":\"Something\",\"data\":1}") }

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
