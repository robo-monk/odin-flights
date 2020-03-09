class BookingsController < ApplicationController
  before_action :set_booking, only: [:show, :edit, :update, :destroy]

  # GET /bookings
  # GET /bookings.json
  def index
    @bookings = Booking.all
  end

  # GET /bookings/1
  # GET /bookings/1.json
  def show
  end

  # GET /bookings/new
  def new
    @booking_flight = Flight.find(params[:flight_id])
    @booking = @booking_flight.bookings.new
    # @passenger = @booking.passengers.new
  end

  # GET /bookings/1/edit
  def edit
  end

  # POST /bookings
  # POST /bookings.json
  def create
    # puts booking_params
    puts params
    @booking_flight = Flight.find(params[:flight_id])
    # puts params

    @booking = @booking_flight.bookings.build(booking_params)
    passenger = Passenger.new(name: params[:booking][:name], email: params[:booking][:email])

    respond_to do |format|
      if @booking.save
        @booking.passengers << passenger
        puts 'email of first passengers of booking'

        passenger = @booking.passengers.first
        puts passenger
        puts passenger.email
        PassengerMailer.with(passenger: passenger).thank_you_email.deliver_now
        format.html { redirect_to @booking, notice: 'Booking was successful.' }
        format.json { render :show, status: :created, location: @booking }
      else
        format.html { render :new }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /bookings/1
  # PATCH/PUT /bookings/1.json
  def update
    respond_to do |format|
      if @booking.update(booking_params)
        format.html { redirect_to @booking, notice: 'Booking was successfully updated.' }
        format.json { render :show, status: :ok, location: @booking }
      else
        format.html { render :edit }
        format.json { render json: @booking.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /bookings/1
  # DELETE /bookings/1.json
  def destroy
    @booking.destroy
    respond_to do |format|
      format.html { redirect_to bookings_url, notice: 'Booking was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_booking
      @booking = Booking.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def booking_params
      # params.fetch(:booking, {})
    end
end
