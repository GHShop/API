require "granite_orm/adapter/pg"

Granite::ORM.settings.database_url = Amber.settings.database_url
Granite::ORM.settings.logger = Amber.settings.logger.dup
Granite::ORM.settings.logger.progname = "Granite"

class Granite::ORM::Base
  def self.create(**args)
    create(args.to_h)
  end

  def self.create(args : Hash(Symbol | String, DB::Any))
    instance = new
    instance.set_attributes(args)
    instance.save
    instance
  end
end
