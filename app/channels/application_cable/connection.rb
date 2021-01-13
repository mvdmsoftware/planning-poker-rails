module ApplicationCable
  class Connection < ActionCable::Connection::Base
   def disconnect
      session_id = @request.session[:session_id]
      Participant.where(user_session_id: session_id).each do |participant|
         participant.destroy
      end

      Room.where(participants_count: 0).each do |room|
         room.destroy
      end
   end
  end
end
