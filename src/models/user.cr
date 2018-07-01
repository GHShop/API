class User < Granite::Base
  enum Level
    Guest
    Clerk
    Manager
    Owner
  end

  adapter pg
  table_name users
  before_create set_defaults

  field! oauth_id : Int64
  field! email : String
  field! name : String
  field! level_number : Int32
  timestamps

  def level
    @level ||= Level.from_value(level_number)
  end

  def level=(level : Level)
    @level = level
    @level_number = level.value
  end

  def level=(number : Int)
    self.level = Level.from_value(number)
  end

  def level=(name : String)
    self.level = Level.parse(name)
  end

  def set_defaults
    self.level = Level::Guest
    pp level_number
  end
end
