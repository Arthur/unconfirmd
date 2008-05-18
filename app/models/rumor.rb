require 'uuidtools'

class Rumor
  include DataMapper::Resource

  # WTF with DataMapper, how to write a before :create ??
  before :save, :create_hash

  property :id, Integer, :serial => true
  property :title, String
  property :author, String
  property :private, TrueClass
  property :favorable, Integer, :default => 0
  property :defavorable, Integer, :default => 0
  property :hash, String
  property :created_at, DateTime
  property :updated_at, DateTime  

  has 1, :parent, :class_name => "Rumor"
  has n, :comments, :class_name => "Comment"
  
  def plus
    self.favorable += 1
  end
  
  def minus
    self.defavorable += 1
  end
  
  def create_hash
    self.hash = UUID.random_create.to_i unless hash
  end

end
