require "csv"

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"

memo_type = gets.to_i

if memo_type == 1
  puts "拡張子を除いたファイル名を入力してください:"
  filename = gets.chomp + ".csv"
  puts "メモしたい内容を記入してください:"
  puts "完了したらcommand + Dを押します"
  content = []
  while (line = gets) != "\x04\n"
    content << line.chomp
  end

  CSV.open(filename, 'w') do |csv|
    content.each do |line|
      csv << [line]
    end
  end

  puts "メモが保存されました。"

elsif memo_type == 2
  puts "編集したいメモのファイル名（拡張子を除いて）を入力してください:"
  filename = gets.chomp + ".csv"
  
  if File.exist?(filename)
    puts "現在の内容:"
    CSV.foreach(filename) do |row|
      puts row[0]
    end
    
    puts "新しい内容を記入してください:"
    puts "完了したらcommand + Dを押します"
    content = []
    while (line = gets) != "\x04\n"
      content << line.chomp
    end
    
    CSV.open(filename, 'w') do |csv|
      content.each do |line|
        csv << [line]
      end
    end

    puts "メモが更新されました。"
  else
    puts "指定されたファイルは存在しません。"
  end

else
  puts "無効な選択です。"
end
