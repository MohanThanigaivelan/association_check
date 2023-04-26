require 'active_record'

# Establish connection to the database
ActiveRecord::Base.establish_connection("adapter" => "postgresql")
connection = ActiveRecord::Base.connection

# Table creation
connection.create_table(:accounts ,  id: false, force: true ) do |t|
  t.primary_key :id, :string, default: nil
  t.column :name, :string, limit: 60
end
connection.create_table(:vpcs , force: true ) do |t|
  t.column :name, :string, limit: 60
  t.column :vpc_id ,:string
end

# Model creation
class Account < ActiveRecord::Base
end
class Vpc < ActiveRecord::Base
  belongs_to :account , primary_key: :id, foreign_key:  :vpc_id
end

# Data creation
Account.create(id: "first", name: 'xxx')
vpc = Vpc.create(vpc_id: "first")

# Fetch records through association
pp vpc.account # Executes SELECT "accounts".* FROM "accounts" WHERE "accounts"."id" = 'first'
