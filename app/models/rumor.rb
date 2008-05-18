require 'digest/md5'

class Rumor
  include DataMapper::Resource

  # before :create, :create_hash

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
    favorable += 1
    save
  end
  
  def minus
    defavorable -= 1
    save
  end
  
  def create_hash
    hash = Digest::MD5.hexdigest(created_at.to_s + title)
  end

end
