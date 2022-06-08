require 'active_record'

ActiveRecord::Base.establish_connection(
  adapter: 'sqlite3',
  database: ':memory:',
  verbosity: 'quiet'
)

ActiveRecord::Base.connection.create_table :users do |table|
  table.string :username
  table.integer :reputation
  table.decimal :coins, default: 0
  table.decimal :tax, default: 30
  table.integer :available_3d_models_amount, default: 1
  table.references :level
end

ActiveRecord::Base.connection.create_table :levels do |table|
  table.string :title
  table.integer :experience
end

ActiveRecord::Base.connection.create_table :privileges do |table|
  table.integer :kind
  table.decimal :bonus
  table.references :level
end
