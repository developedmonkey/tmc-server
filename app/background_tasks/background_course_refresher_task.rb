require 'background_course_refresher'

class BackgroundCourseRefresherTask
  def initialize
    @refresher = BackgroundCourseRefresher.new
  end

  def run
    @refresher.do_refresh
  end
end
