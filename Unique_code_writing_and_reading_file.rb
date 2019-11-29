def generate_code(number)
	charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
	Array.new(number) { charset.sample }.join
end
def file_read(text)
    file = File.open("testing.txt", "r").each do |line|
        words = line.split
        if words[0] == text
            return words[0] + " " + words[1]
        end
    end
    file.close
end
def file_write(texts)
    file = File.open("testing.txt", "a")
    code = generate_code(8)
    file.puts "#{texts} #{code}"
    file.close
    puts "your url is #{texts} and code is #{code}."
end

puts "enter url"
texts = gets.chomp
puts file_read(texts)
if file_read(texts) == nil
    file_write(texts)
end

