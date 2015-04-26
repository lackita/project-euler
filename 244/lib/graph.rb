class Node
  attr_reader :position

  def initialize(position)
    @position = position
  end

  def open_slot
    @position.each_index do |row|
      @position[row].each_index do |col|
        if @position[row][col] == " "
          return TilePosition.new(row, col)
        end
      end
    end
  end

  def edges
    edges = []

    if open_slot.col > 0
      edges.push(Edge.new(self, "R"))
    end

    if open_slot.col < last_col
      edges.push(Edge.new(self, "L"))
    end

    if open_slot.row > 0
      edges.push(Edge.new(self, "D"))
    end

    if open_slot.row < last_row
      edges.push(Edge.new(self, "U"))
    end

    edges
  end

  def last_row
    @position.length - 1
  end

  def last_col
    @position[0].length - 1
  end

  def ==(other_node)
    @position == other_node.position
  end

  def hash
    @position.hash
  end
end

class Edge
  attr_reader :direction

  def initialize(origin, direction)
    @origin = origin
    @direction = direction
  end

  def node
    Node.new(new_position)
  end

  def new_position
    new_position = @origin.position.map { |row| row.clone }
    new_position[old_open_slot.row][old_open_slot.col] = new_position[new_open_slot.row][new_open_slot.col]
    new_position[new_open_slot.row][new_open_slot.col] = " "
    new_position
  end

  def old_open_slot
    @origin.open_slot
  end

  def new_open_slot
    if @direction == "L"
      TilePosition.new(@origin.open_slot.row, @origin.open_slot.col + 1)
    elsif @direction == "R"
      TilePosition.new(@origin.open_slot.row, @origin.open_slot.col - 1)
    elsif @direction == "U"
      TilePosition.new(@origin.open_slot.row + 1, @origin.open_slot.col)
    elsif @direction == "D"
      TilePosition.new(@origin.open_slot.row - 1, @origin.open_slot.col)
    end
  end
end

class TilePosition
  attr_reader :row, :col

  def initialize(row, col)
    @row = row
    @col = col
  end

  def ==(other_position)
    @row == other_position.row and @col = other_position.col
  end
end

class Path
  def initialize(moves)
    @moves = moves
  end

  def checksum
    checksum = 0
    @moves.each do |move|
      checksum = (checksum*243 + move) % 100000007
    end
    checksum
  end
end
