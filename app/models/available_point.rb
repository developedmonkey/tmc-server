# Caches points that can be awarded from an exercise.
# Awarded points don't have a hard reference to these because
# these are recreated every time a course is refreshed.
class AvailablePoint < ActiveRecord::Base
  include Comparable

  belongs_to :exercise
  has_one :course, :through => :exercise

  def self.course_points(course)
    joins(:exercise).
    where(:exercises => {:course_id => course.id}).
    map(&:name)
  end

  def self.course_sheet_points(course, sheet)
    joins(:exercise).
    where(:exercises => {:course_id => course.id, :gdocs_sheet => sheet}).
    map(&:name)
  end

  def <=>(other)
    #TODO: secondary sort by string parts
    self.name.gsub(/\D/, '').to_i <=> other.name.gsub(/\D/, '').to_i
  end
end
