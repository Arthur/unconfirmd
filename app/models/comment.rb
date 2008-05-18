class Comment
  include DataMapper::Resource

  property :id, Integer, :serial => true
  property :content, Text
  property :author, String
  
  # after :save, :count_comments

  many_to_one :rumor
  
  def count_comments
    r = self.rumor
    r.comments_count = r.comments.size
    puts r.inspect
    puts r.save.inspect # No SQL query is launched
  end
  
end
