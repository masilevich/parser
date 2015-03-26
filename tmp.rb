  if File.exist?("tmp/out.txt")
    out_file = File.open("tmp/out.txt", "r")
    puts "Before writing File exist File content: #{out_file.read}"
    out_file.close
  else
    puts "Before writing File not exist"
  end

  out_file = File.new("tmp/out.txt", "a")
  out_file.puts("write your stuff here")
  out_file.close

  if File.exist?("tmp/out.txt")
    out_file = File.open("tmp/out.txt", "r")
    puts "After writing File exist File content: #{out_file.read}"
    out_file.close
  else
    puts "After writing File not exist"
  end