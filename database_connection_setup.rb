require './lib/database_connection'

if ENV['ENVIRONMENT'] == 'test'
  DatabaseConnection.setup('makers_bnb_test')
else
  DatabaseConnection.setup('makers_bnb')
end
