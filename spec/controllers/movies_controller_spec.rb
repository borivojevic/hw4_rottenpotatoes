require 'spec_helper'

describe MoviesController do
  fixtures :movies
  describe 'find movies with same director' do
    before :each do
      @movie = movies(:star_wars_movie)
      @similar = movies(:THX1138_movie)
    end
    it 'should mathc RESTful route for Find Similar Movies' do
      similar_movies_path(1).should == "/movies/1/similar"
    end
    it 'should call the model method that finds similar movies' do
      Movie.should_receive(:find_similar).with(@movie).and_return(@similar)
      get :similar, {:id => @movie.id}
    end
    describe 'after valid search' do
      before :each do
        Movie.stub(:find_similar).and_return(@similar)
        get :similar, {:id => @movie.id}
      end
      it 'should select Similar Movies template for rendering' do
        response.should render_template("similar")
      end
      it 'should make similar movies avaialbe to the template' do
        assigns(:movie).should == @movie
        assigns(:movies).should == @similar
      end
    end
  end
end
