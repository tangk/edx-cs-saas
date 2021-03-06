class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    if id =~ /\Atitle/
      flash[:sortby] = id
      redirect_to movies_path
    elsif id =~ /\Arelease_date/
      flash[:sortby] = id
      redirect_to movies_path
    else
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
    end
  end

  def index
    @all_ratings = Movie.uniq.pluck(:rating)
    if flash[:sortby] =~ /\Atitle/
      @movies = Movie.order("title ASC").all
    elsif flash[:sortby] =~ /\Arelease_date/
      @movies = Movie.order("release_date ASC").all
    else
      @movies = Movie.all
    end
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
