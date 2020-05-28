# Connection to MySQL - mysql_connection
This contains a ruby script which establishes connection with mysql and execute queries.

# Note:
Please make sure mysql is configured to access remotely with proper credentials.

## Installations required (Gems)

Following gems are needed to install:
```
gem install mysql
gem install rspec
```

## Running the script

1. Run the console requiring the mysql_client.rb. For example:

```
irb -r ./mysql_client.rb
```

2. Create mysql client object as shown below:

```
client = MysqlClient.new(host: 'localhost', username: 'root', password: 'root', database: 'database')
```
Note: Please note to use appropriate database credentials and existing database name.

3. Execute select all query as shown below:

```
client.execute_select_all('table_name')
```
If you want to fetch specific columns.

```
client.execute_select_all('table_name', ['column_name_1', 'column_name_1'])
```
Note: Please note to use appropriate table name and column names as per your database sturcture.

## Rspecs

1. create the database named as 'connection_test' in database

1. Import sql dump in test database

```
mysql -u root -p connection_test < db/test/test_db.sql
```
2. Run unit tests as shown below:

```
rspec spec/mysql_client_spec.rb
```
Note: Mysql host and user credentials are specified in the mysql_client_spec.rb file itself. So, might need to change that accordingly.
