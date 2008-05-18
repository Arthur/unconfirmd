class Comment
  include DataMapper::Resource

  property :id, Integer, :key => true
  property :content, Text

  has 1, :rumor, :class_name => "Rumor"
end
