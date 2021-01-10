class RoomsController < ApplicationController
  # GET /rooms/:room_identifier
  # GET /rooms/:room_identifier.json
  def show
   room_identifier = params[:room_identifier]
   @room = find_room(room_identifier)

   if(@room.nil?)
      return redirect_to join_room_path(room_identifier: room_identifier)
   end
  end

  # GET /rooms/new
  def new
      room = Room.new
      room.save

      redirect_to join_room_path(room_identifier: room.unique_identifier)
  end

  # GET /rooms/join/:room_identifier
  def join
   session_id = session[:session_id]
   room_identifier = params[:room_identifier]

   room = find_room(room_identifier)

   if(room.nil?)
      room = Room.new({unique_identifier: room_identifier})
      room.save
   end

   unless room.participants.exists?(user_session_id: session_id)
      room.participants.new(user_session_id: session_id)
      room.save
   end

   redirect_to show_room_path(room_identifier: room_identifier)
  end

  # POST /rooms/:room_identifier/estimate/:value
  def estimate
   session_id = session[:session_id]
   room_identifier = params[:room_identifier]

   room = find_room(room_identifier)

   return redirect_to root_path if room.nil?

   participant = room.participants.where(user_session_id: session_id).first
   if(participant)
      participant.estimate = params[:value]
      participant.save
   else
      room.participants.new(estimate: params[:value], user_session_id: session_id)
      room.save
   end

   redirect_to show_room_path(room_identifier: room_identifier)
  end

  # POST /rooms/:room_identifier/hide
  def hide
   room_identifier = params[:room_identifier]
   room = find_room(room_identifier)
   room.hide!

   redirect_to show_room_path(room_identifier: room_identifier)
  end

  # POST /rooms/:room_identifier/show
  def reveal
   room_identifier = params[:room_identifier]
   room = find_room(room_identifier)
   room.reveal!

   redirect_to show_room_path(room_identifier: room_identifier)
  end

  # POST /rooms/:room_identifier/reset
  def reset
   room_identifier = params[:room_identifier]
   room = find_room(room_identifier)
   room.participants.all.each do |participant|
      participant.estimate = nil
      participant.save
   end
   room.hide!

   redirect_to show_room_path(room_identifier: room_identifier)
  end

  private 
   def find_room(unique_identifier)
      Room.where(unique_identifier: unique_identifier).first
   end
end
