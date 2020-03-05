class FlightsController < ApplicationController
  before_action :set_flight, only: [:show, :edit, :update, :destroy]

  # GET /flights
  # GET /flights.json
  def index
    # params[:from]
    # Flight.where(id: 5).select(:id, :first_name)
    @airport_options = Airport.all.map{ |a| [ a.code, a.id ] }
    @airport_options.unshift ['any', nil]

    # unless params[:from].nil? 
    #   @flights = Flight.where(from_id: params[:from])
    # else
    #   @flights = Flight.all
    # end
    @flights = find_flights(params)
  end

  # GET /flights/1
  # GET /flights/1.json
  def show
  end

  # GET /flights/new
  def new
    @flight = Flight.new
  end

  # GET /flights/1/edit
  def edit
  end

  # POST /flights
  # POST /flights.json
  def create
    @flight = Flight.new(flight_params)

    respond_to do |format|
      if @flight.save
        format.html { redirect_to @flight, notice: 'Flight was successfully created.' }
        format.json { render :show, status: :created, location: @flight }
      else
        format.html { render :new }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /flights/1
  # PATCH/PUT /flights/1.json
  def update
    respond_to do |format|
      if @flight.update(flight_params)
        format.html { redirect_to @flight, notice: 'Flight was successfully updated.' }
        format.json { render :show, status: :ok, location: @flight }
      else
        format.html { render :edit }
        format.json { render json: @flight.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /flights/1
  # DELETE /flights/1.json
  def destroy
    @flight.destroy
    respond_to do |format|
      format.html { redirect_to flights_url, notice: 'Flight was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_flight
      @flight = Flight.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def flight_params
      params.permit(:datetime, :from, :to, :duration, :price)
    end

    def find_flights(params)
      params[:from].nil? || params[:from].empty? ? from = 'from_id' : from = params[:from]
      params[:to].nil? || params[:to].empty? ? to = 'to_id' : to = params[:to]
      # AVOID THIS, SQL INJECTION IS POSSIBLE!
      from_text = Airport.exists?(id: params[:from]) ? "#{Airport.find(params[:from]).code} <i> (#{Airport.find(params[:from]).name}) </i>": 'ANYWHERE'
      to_text = Airport.exists?(id: params[:to]) ? "#{Airport.find(params[:to]).code} <i> (#{Airport.find(params[:to]).name}) </i>" : 'ANYWHERE'

      @searching_for = "<h2> Searching for: </h2> Flights from  <strong> #{from_text} </strong>  to <strong> #{to_text} </strong".html_safe
      @flights = Flight.where("from_id = #{from} AND to_id = #{to}").order(:datetime)
    end
end
