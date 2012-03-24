require 'spec_helper'

describe Movie do
  describe 'searching for similar movies' do
    #it 'should find movies with same director for given movie'  
    it 'should return empty array if no similar movie found' do
      fake_movie = mock('Movie')
      fake_movie.stub(:id).and_return(1)
      fake_movie.stub(:director).and_return('Invalid')
      similar = Movie.find_similar(fake_movie)
      similar.should == []
    end
  end
end
