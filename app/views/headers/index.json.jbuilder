json.array!(@headers) do |header|
  json.extract! header, :id, :title, :description, :image
  json.url header_url(header, format: :json)
end
