json.type "FeatureCollection" 
json.features @events do |event|
  json.type "Feature"
  json.properties do
    json.color "blue"
    json.id event.id
    json.title event.title
    json.description event.description
  end

  json.geometry do
    json.type "Point"
    json.coordinates [
      event.longitude,
      event.latitude
    ]
  end
end