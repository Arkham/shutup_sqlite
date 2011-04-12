class ActiveRecord::ConnectionAdapters::SQLiteAdapter

  def shutup?(sql)
    sql.match(/^\s*SELECT\s+name\s+FROM\s+sqlite_master\s+/)
  end

  def log_info(sql, name, ms)
    super(sql, name, ms) unless shutup?(sql)
  end

  def execute(sql, name = nil)
    unless shutup?(sql)
      log(sql, name) { @connection.execute(sql) }
    else
      @connection.execute(sql)
    end
  end

end

