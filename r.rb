require 'net/http'

# Function to check proxy
def check_proxy(proxy)
  ip, port = proxy.split(":")
  port = port.to_i
  begin
    uri = URI("http://httpbin.org/ip")
    http = Net::HTTP.new(uri.host, uri.port, ip, port)
    http.open_timeout = 5
    http.read_timeout = 5
    response = http.get(uri)
    return response.code == "200"
  rescue
    return false
  end
end

# Main script logic
puts "Enter the file containing proxies (IP:PORT format):"
file_name = gets.chomp
proxies = File.readlines(file_name).map(&:strip)

working_proxies = []

proxies.each do |proxy|
  puts "Checking #{proxy}..."
  if check_proxy(proxy)
    working_proxies << proxy
    puts "#{proxy} is working!"
  else
    puts "#{proxy} failed."
  end
end

puts "\nCheck completed!"
puts "Enter the name of the file to save working proxies:"
save_file = gets.chomp

File.open(save_file, "w") do |file|
  working_proxies.each { |proxy| file.puts proxy }
end

puts "Working proxies saved to #{save_file}!"
