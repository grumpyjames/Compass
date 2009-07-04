class FakePlayer
  def initialize
    @resources = Hash.new(0)
    @questions = []
    @options = []
    @responses = []
    @response_index = -1
  end
  def receive(resource, quantity)
    @resources[resource] += quantity    
  end
  def resources
    @resources
  end
  def add_to_game(game)
    @game = game
  end
  def add_response(response)
    @responses.push(response)
  end
  def add_responses(responses)
    @responses.concat(responses)
  end
  def game
    @game
  end
  def prompt(question, options)
    @questions.push(question)
    @options.push(options)
    @prompted = true
    puts question
    options.each do |option|
      puts option[0].to_s + ": " + option[1].to_s 
    end
    @response_index+=1
    return @responses[@response_index] ? @responses[@response_index]:"r"
  end
  def prompted
    @prompted
  end
  def options
    @options
  end
  def questions
    @questions
  end	
end
