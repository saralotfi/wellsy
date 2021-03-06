class BookingsController < ApplicationController
  before_action :authenticate_user!


  def my_sessions
    @sessions = current_user.sessions
  end


  def missed
    @booking = Booking.find(params[:id])
    @booking.attended = !@booking.attended
    @booking.save
  end

  def create
    @session = Session.find(params[:session_id])
    @booking = Booking.new
    @booking.session = @session
    @booking.user = current_user
      if @booking.save
        flash[:notice] = "Booking for #{@session.activity.name} complete!"
        redirect_to thank_you_path
      else
        flash[:notice] = "Session could not be booked!"
        redirect_to sessions_path
      end
  end

  def destroy
    @booking = Booking.find(params[:id])
    @booking.destroy
    redirect_to my_bookings_path
  end



  private

  # def booking_params
  #   params.require(:booking).permit(:starting_date, :ending_date)
  # end

end

