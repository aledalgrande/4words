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
        :desc => "Ant (or Rocco) has a passion for business technology and a creative entrepreneurial spirit. He enjoys managing projects, especially when he can influence the end product! He got a team together to help the 50/50 project because as a husband and father, couldn't imagine what it would be like to not be able to feed your wife let alone your child.",
        :twitter => 'anthonyisrocco'
      }, {
        :img => 'dan',
        :name => 'Daniel Lewis',
        :role => 'Graphic Designer',
        :desc => "Thrives on developing creative solutions to design problems, focused and passionate about illustration, branding, digital and good old pencil skills.\nI'm a keen cook and like travelling the UK for restaurants. \"I'm always prepared to help others and this project was a great opportunity to help make a big difference to the future of East Africa.\"",
        :twitter => 'FrenchieMan'
      }, {
        :img => 'daz',
        :name => 'Darren Pinner',
        :role => 'PR Director',
        :desc => "In the day he masquerades as an MD of a field marketing company and at night he plots his next 'big idea'. Currently working from Bronte Beach, Sydney - it's tough but someone's got to do it.<br/>50/50 offered the opportunity to collaborate with some of the most talented people on the planet to help those on the planet most at need.",
        :twitter => 'Darrenpinner'
      }].shuffle
  end
  
end