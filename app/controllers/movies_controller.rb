class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    sort_by = params[:sort_by]
    @ratings = params[:ratings]
    #@movies = Movie.all
    if @ratings.nil?
	    if params[:commit].eql?("Refresh")
		    session.delete(:ratings)
		    session.delete(:sort_by) if !session[:sort_by].nil?
		    redirect_to movies_path
	    end
	    @ratings = session[:ratings]
	    sort_by = session[:sort_by]
	    if !@ratings.nil?
		    redirect_to movies_path(:ratings=>@ratings,:sort_by=>sort_by)
	    end
    end
    session[:ratings] = @ratings
    session[:sort_by] = sort_by
    @movies = Movie.sort_rate(@ratings,sort_by)
    @all_ratings = Movie.rating_list
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end
