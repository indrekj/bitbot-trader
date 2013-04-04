class HttpRequestMock
  attr_reader :path, :params

  def post(path, params)
    {success: true, path: path, params: params}
  end
end
