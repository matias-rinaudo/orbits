class MusicSerializer < ActiveModel::Serializer
  attributes :id, :title, :author, :album, :duration, :reference_api
end
