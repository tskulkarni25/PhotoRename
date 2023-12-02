require 'date'

def solution(s)
  # Split the input string into lines
  lines = s.strip.split("\n")
  
  # Create a hash to store photos grouped by city
  city_photos = Hash.new { |hash, key| hash[key] = [] }

  # Process each line and group photos by city
  lines.each_with_index do |line, index|
    photo_name, city_name, date_time = line.strip.split(',')
    city_photos[city_name] << [photo_name, DateTime.parse(date_time), index]
  end

  # Sort photos within each city by date and time, and by the original index
  city_photos.each do |city, photos|
    photos.sort_by! { |_, date_time, index| [date_time, index] }
  end

  # Create a hash to store the new names of each photo
  new_names = Hash.new { |hash, key| hash[key] = [] }
  
  # Generate new names for each photo
  city_photos.each do |city, photos|
    max_digits = photos.length.to_s.length
    photos.each_with_index do |(photo_name, _, _), i|
      extension = photo_name.split('.').last
      new_name = "#{city}#{(i + 1).to_s.rjust(max_digits, '0')}.#{extension}"
      new_names[photo_name] = new_name
    end
  end

  # Create an array of new names in the original order
  ordered_new_names = lines.map { |line| new_names[line.split(',').first.strip] }
  
  # Join the new names into a string and return
  ordered_new_names.join("\n")
end

# Check if a command-line argument is provided
if ARGV.length > 0
  # Pass the command-line argument (input string) to the solution function
  result = solution(ARGV[0])
  puts "\nOutput: "
  puts result
else
  puts "Usage: ruby photo_rename.rb \"input_string\""
end