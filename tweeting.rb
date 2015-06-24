require 'twitter'

client = Twitter::REST::Client.new do |config|
  config.consumer_key        = "F0HIo849Vlz4PkYARNKPRAaY1"
  config.consumer_secret     = "aRGQUGrWgCU5FFRdv22425e8g1PIUi8YRjhtdxHtCSxOewhdJb"
  config.access_token        = "3334758579-4GpNdB4Bg2qbJntppDMlswbAQI0XejZlkeGY929"
  config.access_token_secret = "69nFi6sI0wdjBslTXi6Fu3WnOELAtVJ6I0teIYbuCPecy"
end

if File.exists?("/sys/bus/w1/devices/28-000004e3dda7/w1_slave")
  line = File.readlines("/sys/bus/w1/devices/28-000004e3dda7/w1_slave")[1]
  temperature = line[29..34].to_f / 1000
else
  temp = "unknown"
end

system('raspistill -o camera_image.jpg --vflip')

client.update_with_media("office-temperature: #{temperature}C", File.new("camera_image.jpg"))
