require_relative "../bin/environment"

class Pokemon
attr_accessor :name, :type, :id, :db

  def initialize(name:, type:, id:, db:)
    @name = pk_name
    @type = pk_type
    @id = nil
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

  def self.create(name, type)
    pk_name = name
    pk_type = type
    new_pokemon = self.new(pk_name, pk_type)
    new_pokemon.save
  end

  def self.new_from_db(row)
    id = row[0]
    pk_name = row[1]
    pk_type = row[2]
    new_pokemon = self.new(pk_name, pk_type)
    new_pokemon
  end

  def self.find(name)
    sql = <<-SQL
    SELECT *
    FROM pokemon
    WHERE name = ?
    LIMIT 1
    SQL
    row = DB[:conn].execute(sql, name)[0]
      self.new_from_db(row)
  end

  def update
    sql = "UPDATE pokemon SET name = ?, type = ? WHERE id = ?"
    DB[:conn].execute(sql, self.name, self.type, self.id)
  end

end
