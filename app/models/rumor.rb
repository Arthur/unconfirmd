require 'uuidtools'

class Rumor
  include DataMapper::Resource

  # WTF with DataMapper, how to write a before :create ??
  after :save, :create_hash
  after :save, :count_comments

  # TODO validates_presence_of :title

  property :id, Integer, :serial => true
  property :title, String
  property :author, String
  property :private, TrueClass
  property :favorable, Integer, :default => 0
  property :defavorable, Integer, :default => 0
  property :hash, String
  property :created_at, DateTime # TODO not set by DataMapper on creation
  property :updated_at, DateTime # TODO not set by DataMapper on save
  property :comments_count, Integer, :default => 0

  has 1, :parent, :class_name => "Rumor"
  has n, :comments, :class_name => "Comment"
  
  def plus
    self.favorable += 1
  end
  
  def minus
    self.defavorable += 1
  end
  
  def create_hash
    self.hash = Digest::MD5.hexdigest(self.title) unless hash
  end

  def count_comments
    self.comments_count = self.comments.size
  end

  def score
    score = ""
    if self.favorable >= self.defavorable
      score = (self.favorable.to_f / self.defavorable.to_f * 100).to_s
      score << "% agree"
    else
      score = (self.defavorable.to_f / self.favorable.to_f * 100).to_s
      score << "% disagree"
    end
    score
  end

  def populars
  end

  def actives
  end

end
