module HttpConnectionHelpers
  def mock_connection(path, result)
    Faraday.new { |builder|
      builder.adapter :test do |stub|
        stub.post(path) { [200, {}, result] }
      end
    }
  end
end

RSpec.configure do |config|
  config.include HttpConnectionHelpers, type: :integration, example_group: {
    file_path: /spec\/integration/
  }
end
