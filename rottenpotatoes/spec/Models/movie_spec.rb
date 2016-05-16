require 'spec_helper'

describe MoviesController do
  describe 'edit page for appropriate Movie' do
    it 'has to return list of hardcoded ratings' do
      r = Movie.all_ratings
      r.length.should == 5
    end
  end
end