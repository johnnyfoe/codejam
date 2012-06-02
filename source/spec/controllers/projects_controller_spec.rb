require 'spec_helper'

describe ProjectsController do

  describe "GET 'index'" do
    it "should return http success" do
      get 'index'
      response.should be_success
    end
  end

  describe "GET 'create'" do
    it "returns http success" do
      get 'create'
      response.should be_success
    end
  end

  describe "GET 'edit'" do
    it "returns http success" do
      get 'edit'
      response.should be_success
    end
  end

  describe "GET 'contributors'" do
    it "returns http success" do
      get 'contributors'
      response.should be_success
    end
  end

  describe "GET 'skills'" do
    it "returns http success" do
      get 'skills'
      response.should be_success
    end
  end

  describe "GET 'interests'" do
    it "returns http success" do
      get 'interests'
      response.should be_success
    end
  end

  describe "GET 'search'" do
    it "returns http success" do
      get 'search'
      response.should be_success
    end
  end

end
