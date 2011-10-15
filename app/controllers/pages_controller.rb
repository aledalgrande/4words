class PagesController < ApplicationController
  
  def home
  end
  
  def about
    @personas = [
      {
        :img => 'ale',
        :name => 'Alessandro Dal Grande',
        :role => 'Web Developer',
        :desc => "His angel face will diddle you. Merciless entity from Hell, sometimes he's struck by a strange energy and becomes  temporarily a kind person that wants to help the most needful. Some say he can see through your webcam by looking at his wristwatch and that he is the inspiration for new fashion trends in Jakarta. All we know, he's called Alessandro.",
        :twitter => 'aledalgrande'
      }, {
        :img => 'ant',
        :name => 'Anthony Wales',
        :role => 'Project Coordinator',
        :desc => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        :twitter => 'anthonyisrocco'
      }, {
        :img => 'dan',
        :name => 'Daniel Lewis',
        :role => 'Graphic Designer',
        :desc => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        :twitter => 'FrenchieMan'
      }, {
        :img => 'daz',
        :name => 'Darren Pinner',
        :role => 'PR Director',
        :desc => "Lorem ipsum dolor sit amet, consectetur adipisicing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur.",
        :twitter => 'Darrenpinner'
      }].shuffle
  end
  
end