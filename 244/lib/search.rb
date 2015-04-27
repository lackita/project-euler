class Path
  attr_reader :node

  def initialize(node, moves=[])
    @moves = moves
    @node = node
  end

  def checksum
    checksum = 0
    @moves.each do |move|
      checksum = (checksum*243 + move.ord) % 100000007
    end
    checksum
  end

  def add_step(edge)
    @node = edge.node
    @moves.push(edge.direction)
  end
end

class BFS
  def initialize(start, finish)
    @finish = finish
    @unprocessed = [start]
    @discovered = {start.position => true}
  end

  def confirm_path
    while not @unprocessed.empty? and @unprocessed[0] != @finish
      @unprocessed.shift.edges.each do |edge|
        if not @discovered[edge.node.position]
          @discovered[edge.node.position] = true
          @unprocessed.push(edge.node)
        end
      end
    end
    @unprocessed[0] == @finish
  end
end
