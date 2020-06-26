class Pokemon
attr_accessor :name, :type, :id, :db

  def initialize(pk_name:, pk_type:, id: = nil)
    @name = pk_name
    @type = pk_type
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL
      INSERT INTO pokemon (name, type)
      VALUES (?, ?)
      SQL
      DB[:conn].execute(sql, self.name, self.type)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM pokemon")[0][0]
    end 
  end

  end

  def self.find

  end

  def update

  end

end
