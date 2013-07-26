module Emarsys
  class Response
    attr_accessor :code, :text, :data

    def initialize(response)
      json = JSON.parse(response)
      self.code = json['replyCode']
      self.text = json['replyText']
      self.data = json['data']
    end

    def result
      if code == 0
        data
      else
        raise "Somethign is wrong - Code #{code}: #{text}"
        #error(code, text)
      end
    end

    def error
      Error.new(code, text).cry
    end

  end
end