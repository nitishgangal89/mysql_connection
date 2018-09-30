require 'mysql'

# This class basically connects to database and executes the query.
class MysqlClient
  # Initializes the options needed for establishing mysql connection
  # @param opts [Hash] The parameters necessary MySQL connection.
  # @option opts [String] :host MySql host.
  # @option opts [String] :username Username of MySQL.
  # @option opts [String] :password Password of MySQL.
  # @option opts [String] :database MySQL database name.
  def initialize(opts = {})
    @host = opts[:host]
    @username = opts[:username]
    @password = opts[:password]
    @database = opts[:database]
  end

  # This method is responsible for -
  # - establishes the mysql connection,
  # - executes select all query from table,
  # - prints each record and
  # - closes connection.
  # This accepts column names if any specific columns are to be fetched.
  # If not provided, it prints out the entire record.
  # @param table_name [String] Table name on which select all query is executed.
  # @param column_names [Array] Array of column names to be fetched.
  def execute_select_all(table_name, column_names = [])
    column_names = column_names.empty? ? '*' : column_names.join(',')
    connection = establish_connection

    resultset = connection.query("select #{column_names} from #{table_name}")
    resultset.each_hash { |record| puts record }
  rescue StandardError => e
    puts "There is an error connecting to the database. Error: #{e.message}"
    false
  ensure
    close_connection(connection)
  end

  private

  # @private
  # Establishes the mysql connection
  def establish_connection
    Mysql.new(@host, @username, @password, @database)
  end

  # @private
  # Closes the connection if already established
  def close_connection(connection_obj)
    connection_obj.close if connection_obj
  end
end
