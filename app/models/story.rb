class Story < ApplicationRecord
  validates :title, :description, presence: true
  # syntax for broadcasting data 
  # Here, the newly created stories are broadcast to the stories channel 
  # using a callback that is triggered each time a new story is created. 
  # This type of streaming requires the setup of a WebSocket connection 
  # to the channel that will receive the updates
  after_create_commit { broadcast_prepend_to 'stories' }
end
