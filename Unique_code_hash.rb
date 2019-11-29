
url = ""
$code_hash = {}
code = ""
option = 0

def loop(url)
      if $code_hash.keys.include?("#{url}") then
            code = $code_hash[url]
            puts "Unique code is #{code}."
            puts "press 1 to continue... or press enter to exit"
            option = gets.chomp.to_i
            if option == 1
                  puts "Enter your url: "
                  url = gets.chomp
                  puts loop(url)
            end
      else
        $code_hash["#{url}"] = "#{generate_code(8)}"
        puts "Unique code is " + $code_hash["#{url}"]
        puts "press 1 to continue... or press enter to exit"
        option = gets.chomp.to_i
        if option == 1
            puts "Enter your url: "
            url = gets.chomp
            puts loop(url)
        end

      end   
end

def generate_code(number)
      charset = Array('A'..'Z') + Array('a'..'z') + Array(0..9)
      Array.new(number) { charset.sample }.join
end

puts "Enter your url: "
url = gets.chomp
puts loop(url)


