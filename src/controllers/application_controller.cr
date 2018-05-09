class ApplicationController < Amber::Controller::Base
  include ErrorHelper
  include TimeHelper
  include UserHelper
end
