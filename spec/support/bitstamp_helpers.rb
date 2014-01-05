module BitstampHelpers
  def mock_connection(path, result)
    Faraday.new { |builder|
      builder.adapter :test do |stub|
        stub.post(path) { [200, {}, result] }
      end
    }
  end

  def make_client(connection)
    described_class::HttpClient.new(
      connection, client_id: 1, api_key: "key", api_secret: "secret"
    )
  end
end

RSpec.configure do |config|
  config.include BitstampHelpers, type: :integration, example_group: {
    file_path: /spec\/integration\/bitstamp/
  }
end
