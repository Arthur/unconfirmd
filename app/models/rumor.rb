class Rumor
  include DataMapper::Resource

  property :id, Integer, :key => true
  property :title, String
  property :author, String
  property :private, TrueClass
  property :favorable, Integer
  property :defavorable, Integer
  property :hash, String
  property :created_at, DateTime
  property :updated_at, DateTime  

  has 1, :parent, :class_name => "Rumor"
end
