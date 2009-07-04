class FakePlayer
  def initialize
    @resources = Hash.new(0)
    @questions = []
    @options = []
    @responses = []
    @response_index = -1
    @buildable_vertices = Hash.new(false)
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
      puts option[0].to_s + ": " + option[1].to_s + (option[2] ? " " + option[2].to_s : "")
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
  def allow_build_on(vertex)
    @buildable_vertices[vertex] = true
  end
  def can_build_on_vertex(vertex)
    @buildable_vertices[vertex]
  end
end
