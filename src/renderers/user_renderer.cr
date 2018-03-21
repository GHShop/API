class UserRenderer < Crinder::Base(User)
  field id
  field email : String
  field name : String
  field level : String
end
