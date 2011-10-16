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
        :desc => "A 28 year old Customer Service Team Manager, husband and father with a passion for Business, Technology and Media. Since becoming a father I've become determined to succeed, not necessarily because I want to rake in the $$$ but because I have a craving and a desire to create something.",
        :twitter => 'anthonyisrocco'
      }, {
        :img => 'dan',
        :name => 'Daniel Lewis',
        :role => 'Graphic Designer',
        :desc => "Thrives on developing creative solutions to design problems, focused and passionate about illustration, branding, digital and good old pencil skills.\nI'm a keen cook and like travelling the UK for restaurants.\n\"I'm always prepared to help others and this project was a great opportunity to help make a big difference to the future of East Africa.\"",
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