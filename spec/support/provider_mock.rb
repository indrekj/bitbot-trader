def provider_mock
  Class.new {
    def initialize(client)
      @client = client
    end

    include ApiMethods
  }
end
