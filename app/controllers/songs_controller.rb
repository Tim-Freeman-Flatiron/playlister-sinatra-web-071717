class SongsController < ApplicationController
	use Rack::Flash 

	get '/songs' do
		@songs = Song.all
		erb :'/songs/index'
	end

	post '/songs' do
		@song = Song.new(params[:song])
		@artist = Artist.find_by(name: params[:artist][:name])

		if !@artist
			@song.artist = Artist.create(params[:artist])
		else
			@song.artist = @artist
		end
		@song.save

		flash[:message] = "Successfully created song."

		redirect "/songs/#{@song.slug}"
	end
	
	get '/songs/new' do
		@genres = Genre.all
		erb :'/songs/new'
	end

	get '/songs/:slug/edit' do
		@song = Song.find_by_slug(params[:slug])
		@genres = Genre.all
		@artists = Artist.all

		erb :'/songs/edit'
	end

	patch '/songs/:slug' do
		@song = Song.find_by_slug(params[:slug])
		@song.update = params[:song]

		redirect "/songs/#{@song.slug}"
	end

	get '/songs/:slug' do
		@song = Song.find_by_slug(params[:slug])
		erb :'/songs/show'
	end


end