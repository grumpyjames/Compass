require '../impl/resource.rb'
class Player
  def initialize(stdin = STDIN, stdout = STDOUT)
    @resources = Hash.new(0)
    @stdin = stdin
    @stdout = stdout
    @actions = []
  end

  def receive( resource, quantity )
    @resources[resource] += quantity
  end

  def resources
    @resources
  end

  def resource_count
    count = 0
    @resources.each do |k,v| 
      p k.to_s + " " + v.to_s
      if Resource::RESOURCES.include?(k)
        p k.to_s + " " + v.to_s
        count+=v
      end
    end
    count
  end

  def can_buy?(buyable)
    Costs::COSTS[buyable].each do |k,v|
      return false if @resources[k]<v
    end
    true
  end
  
  def add_to_game(game)
    @game = game
  end
  
  def end_turn
    @game.next_turn
  end
  
  def prompt(question, options)
    allowed = valid_values(options)
    display_string = to_display_string(options)
    read_until_valid(question, allowed, display_string)
  end
  
  def take(action)
    @actions.push(action)
    action.execute(self)
  end
  
  def actions
    @actions
  end
  
  def can_build_on_vertex(vertex)
    vertex.is_buildable_on? && vertex.in_network_of(self)
  end
  
  private
  def valid_values(options)
    parsed_valid_values = []
    options.each do |option| parsed_valid_values << option.first end
    parsed_valid_values
  end
  
  def read_until_valid(question, allowed, display_string)
    valid = input = false
    while !valid
      @stdout.puts "Choose between: "
      @stdout.puts display_string
      input = @stdin.read
      valid = allowed.include?(input)
    end
    input
  end
  
  def to_display_string(options)
    to_put_out = ""
    options.each do |option|
      to_put_out << option[0].to_s << ": " << option[1] << ", " << (option[2] ? option[2].to_s : "")
    end
    to_put_out[0..(to_put_out.length-3)]
  end
  
end
