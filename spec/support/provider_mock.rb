def provider_mock
  Struct.new(:client) {
    include ApiMethods
  }
end
