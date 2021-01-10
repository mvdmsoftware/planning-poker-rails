class RoomsController < ApplicationController
  # GET /rooms
  # GET /rooms.json
  def index
    @rooms = Room.all
  end

  # GET /rooms/1
  # GET /rooms/1.json
  def show
   uid = params[:unique_identifier]
   @room = Room.where(unique_identifier: uid).first
  end

  # GET /rooms/new
  def new
      room = Room.new
      room.save

      redirect_to show_room_path(unique_identifier: room.unique_identifier)
  end

  # POST /rooms/:room/estimate/:value
  def estimate
   room = Room.find(params[:room])

   return recirect_to root_path if room.nil?

   existing_estimate = room.estimates.where(user_session_id: session[:session_id]).first
   if(existing_estimate)
      existing_estimate.value = params[:value]
      existing_estimate.save
   else
      room.estimates.new(value: params[:value], user_session_id: session[:session_id])
      room.save
   end

   redirect_to show_room_path(unique_identifier: room.unique_identifier)
  end
end
