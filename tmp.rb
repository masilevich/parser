  file_name = "./tmp/out.txt"
  if File.exist?(file_name)
    out_file = File.open(file_name, "r")
    puts "Before writing File exist File content: #{out_file.read}"
    out_file.close
  else
    puts "Before writing File not exist"
  end

  out_file = File.new(file_name, "a")
  out_file.puts("write your stuff here")
  out_file.close

  if File.exist?(file_name)
    out_file = File.open(file_name, "r")
    puts "After writing File exist File content: #{out_file.read}"
    out_file.close
  else
    puts "After writing File not exist"
  end