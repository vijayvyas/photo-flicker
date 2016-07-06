require 'json'
require 'open-uri'

# Adapted from: https://leonid.shevtsov.me/post/need-random-sample-images-why-not-imgur/
# Note we have to change ['galler'] to ['data']
data = JSON.parse(open('http://imgur.com/gallery.json').read)['data']

# construct URLs
data.each { |i| i['url'] = "http://imgur.com/#{i['hash']}#{i['ext']}" }
# select images that aren't too big
data.select { |i| i['size'] < 200_000 }
# or images that aren't too small
data.select { |i| i['width'] > 400 && i['height'] > 400 }
# select only PNG images
data.select { |i| i['ext'] == '.png' }

data.each do |image|
  Photo.create username: Faker::Internet.user_name,
               caption: Faker::Lorem.sentence, likes_count: Faker::Number.number(4),
               url: image['url'], created_at: Faker::Time.between(1.year.ago, Time.now)
end

# update all photos with missing images
Photo.where(url: nil).each do |photo|
  photo.update_column :url, "https://unsplash.it/500"
end