require 'spinel'
require 'csv'
require 'ruby-progressbar'

header = [
  :code,      # 郵便番号(7桁)
  :pref,      # 都道府県名
  :city,      # 市区町村名
  :town,      # 町域名
  :pref_kana, # 都道府県名カタカナ
  :city_kana, # 市区町村名カタカナ
  :town_kana  # 町域名カタカナ
]
bar = ProgressBar.create(title: "import", total: 125094, format: "%t: |%B| %P% %e")
spinel = Spinel.new

CSV.foreach('data/address.csv') do |row|
  hash = header.zip(row).to_h
  doc = {id: hash[:code], body: hash.values.join(' ')}
  spinel.store doc
  bar.increment
end

