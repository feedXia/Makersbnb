require 'pg'

def setup_test_database
  connection = PG.connect(dbname: 'spaces_test')
  connection.exec('TRUNCATE spaces;')
end
