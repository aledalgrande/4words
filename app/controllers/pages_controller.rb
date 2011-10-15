class PagesController < ApplicationController
  
  def home
  end
  
  def about
    @personas = [{:img => 'ale', :name => 'Alessandro Dal Grande', :role => 'Web Developer'}, {:img => 'ant', :name => 'Anthony Wales', :role => 'Project Coordinator'}, {:img => 'dan', :name => 'Daniel Lewis', :role => 'Graphic Designer'}, {:img => 'daz', :name => 'Darren Pinner', :role => 'PR Director'}].shuffle
  end
  
end