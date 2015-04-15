json.type "FeatureCollection" 
json.features @events do |event|
  json.type "Feature"
  json.id event.id
  json.properties do
    json.color "blue"
    json.id event.id
    json.title event.title
    json.description event.description
    json.eventTime event.nice_date
    json.eventpictures event.pictures do |picture|
      json.pictureId picture.id
      json.thumbURL picture.image.url(:thumb)
      json.mediumURL picture.image.url(:medium)
      json.originalURL picture.image.url
    end
  end

  json.geometry do
    json.type "Point"
    json.coordinates [
      event.longitude,
      event.latitude
    ]
  end
end