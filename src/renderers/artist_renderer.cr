class ArtistRenderer < Crinder::Base(Artist)
  field id
  field name : String
  field introduction : String
  field user, with: UserRenderer, if: ->{ object.user_id? }
end
