module TimeHelper
  def parse(s, default : Time)
    begin
      s.try {|s| Time.parse(s, "%F %X")} || default
    rescue e : Time::Format::Error
      nil
    end
  end
end
