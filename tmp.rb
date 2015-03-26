file_name = "./tmp/out.txt"

out_file = File.open(file_name, "a+")
puts "Before writing File content: #{out_file.read}"

out_file.puts("write your stuff here")

out_file.close