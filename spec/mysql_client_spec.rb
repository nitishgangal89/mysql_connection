require_relative '../mysql_client'

describe MysqlClient do
  let(:config_options) do
    {
      host: 'localhost',
      username: 'root',
      password: 'root',
      database: 'connection_test'
    }
  end
  let(:mysql_client) { @mysql_client ||= MysqlClient.new(config_options) }

  describe '.execute_select_all' do
    context 'when mysql connection is established and table name is provided' do
      it 'prints the user records' do
        expect_any_instance_of(Mysql).to receive(:query).and_call_original

        resultset = mysql_client.execute_select_all('users')

        expect(resultset).to be_an_instance_of(Mysql::Result)
        expect(resultset.num_rows).to eq(3)
      end
    end

    context 'when table name and column names are provided' do
      it 'prints the user records' do
        expect_any_instance_of(Mysql).to receive(:query).and_call_original

        resultset = mysql_client.execute_select_all('users', ['email'])

        expect(resultset).to be_an_instance_of(Mysql::Result)
        expect(resultset.num_rows).to eq(3)
      end
    end

    context 'when table name is not provided' do
      it 'raises an error and prints error message' do
        resultset = mysql_client.execute_select_all('')

        expect(resultset).to be_falsey
        expect(resultset).not_to be_an_instance_of(Mysql::Result)
      end
    end
  end
end
