require "csv"

puts "1 → 新規でメモを作成する / 2 → 既存のメモを編集する"
memo_type = gets.chomp.to_i

if memo_type == 1
  puts "拡張子を除いたファイル名を入力してください:"
  filename = gets.chomp + ".csv"
  puts "メモしたい内容を記入してください:"
  
  puts "メモの内容を記入して下さい。Ctrl+Dで保存します。"
  input_memo = STDIN.read
  memo = input_memo.chomp
  
  CSV.open("#{filename}.csv", "w") do |csv|
    csv.puts ["#{memo}"]
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
    puts "完了したらCtrl+D（またはcommand+D）を押します"
    content = $stdin.read.chomp
    
    CSV.open(filename, 'w') do |csv|
      csv << [content]
    end

    puts "メモが更新されました。"
  else
    puts "指定されたファイルは存在しません。"
  end

else
  puts "無効な選択です。"
end

