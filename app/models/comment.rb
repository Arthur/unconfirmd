class Comment
  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :content, Text
  property :author, String
  

  many_to_one :rumor
end
