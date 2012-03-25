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
  describe 'create new movie' do
    before :each do
      @params = {:title => "Star Wars", :rating => "PG", :director => "George Lucas", :release_date => "1977-05-25"}
      Movie.stub!(:create!).and_return(@movie = movies(:star_wars_movie))
    end
    it 'should call model action to create new movie' do
      Movie.should_receive(:create!).with("title" => "Star Wars", "rating" => "PG", "director" => "George Lucas", "release_date" => "1977-05-25").and_return(@movie)
      post :create, :movie => @params
    end
    it 'should set flash var' do
      post :create, :movie => @params
      flash[:notice].should_not be_nil
    end
    it 'should redirect to movies path' do
      post :create, :movie => @params
      response.should redirect_to(movies_path)
    end
  end
  describe 'delete movie' do
    before :each do
      @movie = movies(:star_wars_movie)
      Movie.stub!(:find).and_return(@movie = movies(:star_wars_movie))
      Movie.stub!(:destroy)
    end
    it 'should find movie by id' do
      Movie.should_receive(:find).with("1").and_return(@movie)
      delete :destroy, :id => 1
    end
    it 'should call delete movie object' do
      @movie.should_receive(:destroy)
      delete :destroy, :id => 1
    end
    it 'set flash var' do
      delete :destroy, :id => 1
      flash[:notice].should_not be_nil
    end
    it 'should rediect to movies path' do
      delete :destroy, :id => 1
      response.should redirect_to(movies_path)
    end
  end
end
