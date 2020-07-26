require 'active_record'
require 'pp'
# undefined method 'find_zone!' となるので 追加
require "active_support/all"

Time.zone_default = Time.find_zone! 'Tokyo'
ActiveRecord::Base.default_timezone = :local

ActiveRecord::Base.establish_connection(
  "adapter" => "sqlite3",
  "database" => "./myapp.db",
)

# users テーブルのレコードは User クラスのインスタンスとして扱える
class User < ActiveRecord::Base
end

# insert

# User クラスのインスタンスの作成 しレコードを操作する
user = User.new
user.name = "tanaka"
user.age = 23
user.save

# ↑ は↓ のように書ける
# user = User.new(:name => "hayashi", age: => 25) 
user = User.new(name: "hayashi", age: 25) 
user.save

# new と save をまとめて create で実行
user = User.create(name: "hoshi", age: 22) 
