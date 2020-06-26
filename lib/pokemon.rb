class Pokemon
attr_accessor :name, :type, :id, :db

  def initialize(pk_name:, pk_type:)
    @name = pk_name
    @type = pk_type
  end

  def save
    if self.id
      self.update
    else
      sql = <<-SQL


  end

  def self.find

  end

  def update

  end

end
