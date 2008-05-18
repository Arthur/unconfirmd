require 'uuidtools'

class Rumor
  include DataMapper::Resource

  # WTF with DataMapper, how to write a before :create ??
  after :save, :create_hash

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
  # property :comments_count, Integer, :default => 0

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

  def score
    return "" if self.defavorable == 0 && self.favorable == 0
    
    score = ""
    if self.favorable >= self.defavorable
      if self.defavorable == 0
        score = 100.to_s
      else
        score = (self.favorable.to_f / count_vote * 100).round.to_s
      end
      score << "% agree"
    else
      if self.favorable == 0
        score = 100.to_s
      else
        score = (self.defavorable.to_f / count_vote * 100).round.to_s
      end
      score << "% disagree"
    end
    score
  end

  def count_vote
    self.favorable + self.defavorable
  end

  def self.populars
    rumors = Rumor.all
    rumors.sort do |r1, r2|
      (r2.comments.size*3 + r2.count_vote) <=> (r1.comments.size*3 + r1.count_vote)
    end
  end

end
