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

# pp User.find(3) # id が 3 のレコード
# pp User.select("id, name, age").find(3) #id が 3 のフィールド とレコード
# pp User.select("id, name, age").find_by(name: "tanaka") # name = tanaka のレコード
# pp User.select("id, name, age").find_by name: "tanaka" # ↑ の省略形
# pp User.select("id, name, age").find_by_name "tanaka" # ↑ と同様
# pp User.select("id, name, age").find_by_name("tanaka") # ↑ と同様

pp User.select("id, name, age").find_by_name("kiriya") # 存在しないフィールドは nill になる
pp User.select("id, name, age").find_by_name!("kiriya") # 存在しないフィールドでは エラーを出す
