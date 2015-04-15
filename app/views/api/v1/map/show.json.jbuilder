json.type "FeatureCollection" 
json.features do
  json.type "Feature"
  json.id @event.id
  json.properties do
    json.color "blue"
    json.id @event.id
    json.title @event.title
    json.description @event.description
    json.eventpictures @event.pictures do |pic|
      json.pictureId pic.id
      json.thumbURL pic.image.url(:thumb)
      json.mediumURL pic.image.url(:medium)
      json.originalURL pic.image.url
    end
  end

  json.geometry do
    json.type "Point"
    json.coordinates [
      @event.longitude,
      @event.latitude
    ]
  end
end