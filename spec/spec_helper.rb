require 'pg'
require 'task'
require 'list'

DB = PG.connect(:dbname => 'to_do_spec')

RSpec.configure do |config|
  config.after(:each) do
    DB.exec("DELETE FROM tasks *;")
    DB.exec("DELETE FROM lists *;")
  end
end
