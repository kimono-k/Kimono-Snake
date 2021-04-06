require 'ruby2d'

set background: 'fuchsia'
set fps_cap: 20

# width = 640 / 20 = 32
# height = 480 / 20 = 24

GRID_SIZE = 20

class Snake
  attr_writer :direction

  # Positions for squares later on, based on x, y values
  def initialize
    @positions = [[2, 0], [2, 1], [2, 2], [2, 3]] # Straight line for snake
    @direction = 'down'
  end

  # Draws squares for snake
  def draw
    @positions.each do |position|
      Square.new(x: position[0] * GRID_SIZE, y: position[1] * GRID_SIZE, size: GRID_SIZE - 1, color: 'lime')
    end
  end

  # Moves the snake
  def move
    @positions.shift # Removes [2, 0]
    case @direction
    when 'down'
      @positions.push([head[0], head[1] + 1])
    when 'up'
      @positions.push([head[0], head[1] - 1])
    when 'left'
      @positions.push([head[0] - 1, head[1]])
    when 'right'
      @positions.push([head[0] + 1, head[1]])
    end
  end

  def can_change_direction_to?(new_direction)
    case @direction
    when 'up' then new_direction != 'down'
    when 'down' then new_direction != 'up'
    when 'left' then new_direction != 'right'
    when 'right' then new_direction != 'left'
    end
  end

  private

  def head
    @positions.last
  end

end

snake = Snake.new # Instantiation of object
snake.draw # Method call

# Runs for each frame that's shown on the screen
update do
  clear # Clear screen
  snake.move
  snake.draw
end

on :key_down do |event|
  if ['up', 'down', 'left', 'right'].include?(event.key)
    if snake.can_change_direction_to?(event.key)
      snake.direction = event.key
    end
  end
end

show
