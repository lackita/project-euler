class Path
  attr_reader :node, :moves

  def initialize(node, moves=[])
    @node = node
    @moves = moves
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
    self
  end

  def length
    @moves.length
  end

  def clone
    Path.new(@node, @moves.clone)
  end
end

class BFS
  def initialize(start, finish)
    @finish = finish
    @unprocessed = [Path.new(start)]
    @shortest_distance_to_position = {start.position => 0}
  end

  def minimal_paths
    found_paths = []
    while not @unprocessed.empty? and (found_paths.empty? or found_paths[0].length == @unprocessed[0].length)
      path = @unprocessed.shift
      if path.node == @finish
        found_paths.push(path)
      else
        path.node.edges.each do |edge|
          distance_threshhold = @shortest_distance_to_position[edge.node.position]
          if distance_threshhold.nil? or distance_threshhold == path.length
            @shortest_distance_to_position[edge.node.position] = path.length
            @unprocessed.push(path.clone.add_step(edge))
          end
        end
      end
    end
    found_paths
  end
end
