def provider_double
  Struct.new(:client) {
    include ApiMethods
  }
end
