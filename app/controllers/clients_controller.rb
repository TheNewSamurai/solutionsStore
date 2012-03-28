require 'open-uri'
require 'net/https'
require 'rexml/document'

class ClientsController < ApplicationController
  # GET /clients
  # GET /clients.json
  def index
    @clients = Client.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @clients }
    end
  end

  # GET /clients/1
  # GET /clients/1.json
  def show
    @client = Client.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/new
  # GET /clients/new.json
  def new
    @client = Client.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @client }
    end
  end

  # GET /clients/1/edit
  def edit
    @client = Client.find(params[:id])
  end

  # POST /clients
  # POST /clients.json
  def create
    @client = Client.new(params[:client])

    respond_to do |format|
      if @client.save
        format.html { redirect_to @client, notice: 'Client was successfully created.' }
        format.json { render json: @client, status: :created, location: @client }
		geolocation(@client.address, @client.city, @client.state)
      else
        format.html { render action: "new" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /clients/1
  # PUT /clients/1.json
  def update
    @client = Client.find(params[:id])

    respond_to do |format|
      if @client.update_attributes(params[:client])
        format.html { redirect_to @client, notice: 'Client was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @client.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /clients/1
  # DELETE /clients/1.json
  def destroy
    @client = Client.find(params[:id])
    @client.destroy

    respond_to do |format|
      format.html { redirect_to clients_url }
      format.json { head :no_content }
    end
  end
  
  # Get the geo coordinates based on the provided address
  # limited to US address currently. For more info refer to:
  # http://developer.yahoo.com/geo/placefinder/guide/index.html
  def geolocation(tmpAddr,tmpCity,tmpState)
	
	#Properly format the Address 
	while tmpAddr.include? ' '
		tmpAddr.sub!(' ','+')
	end
	if tmpAddr.include? '.'
		tmpAddr.delete '.'
	end
	#puts URI.parse("http://where.yahooapis.com/geocode?q=#{tmpAddr},+#{tmpCity},+#{tmpState}")
	parsedXML = Net::HTTP.get(URI.parse("http://where.yahooapis.com/geocode?q=#{tmpAddr},+#{tmpCity},+#{tmpState}"))	#Sends the GET request to where.yahoo
	puts "@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@ \n" + parsedXML
	
	doc = REXML::Document.new(parsedXML)
	@lat = []
	@long = []
	
	doc.elements.each('ResultSet/Result/offsetlat') do |ele|	#Pass the macthing XML portion
		@lat << ele.text										#Add the latitude XML element into Array
		puts @lat
	end
	
	doc.elements.each('ResultSet/Result/offsetlon') do |ele|	#Pass the macthing XML portion
		@long << ele.text										#Add the longitude XML element into Array
		puts @long
	end
  end
end
