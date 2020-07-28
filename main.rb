require 'active_record'
require 'pp'
# undefined method 'find_zone!' となるので 追加
require "active_support/all"
require 'logger'

Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local

ActiveRecord::Base.logger = Logger.new(STDOUT)

ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./myapp.db",
)

# users テーブルのレコードは User クラスのインスタンスとして扱える
class User < ActiveRecord::Base
end

User.delete_all # ファイルが実行されるたびに挿入されるのでリセット

User.create(name: "tanaka", age: 19)
User.create(name: "takahashi", age: 25)
User.create(name: "hayashi", age: 31)
User.create(name: "mizutani", age: 28)
User.create(name: "otsuka", age: 35)

# where 範囲オブジェクト

# pp User.select("id, name, age").where(age: 20..29) # 年齢が 20-29 の間 のみのフィールド
# pp User.select("id, name, age").where(age: 20..29) # 年齢が 20-29 の間 のみのフィールド
# pp User.select("id, name, age").where(age: [19, 31]) # 年齢が 19 と 31 のみのフィールド

# AND

# pp User.select("id, name, age").where("age >= 20").where("age < 30") # 年齢が 20 以上 30 未満のフィールド 
# pp User.select("id, name, age").where("age >= 20 and age < 30") # ↑ の省略形 

# OR

# pp User.select("id, name, age").where("age <= 20 or age >= 30") # 20歳以下 30歳以上
# pp User.select("id, name, age").where("age <= 20").or(
#   User.select("id, name, age").where("age >= 30")) # ↑ or を使用
pp User.where("age <= 20").or(User.where("age >= 30")).select("id, name, age") # select を省略

# NOT

pp User.select("id, name, age").where.not(id: 3) # id が 3 以外 
