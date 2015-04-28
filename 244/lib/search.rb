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
    @discovered_path_moves = {[] => true}
  end

  def minimal_paths
    @found_paths = []
    while work_remains?
      path = @unprocessed.shift
      if path.node == @finish
        @found_paths.push(path)
      else
        path.node.edges.each do |edge|
          if minimal_subpath?(path, edge)
            @shortest_distance_to_position[edge.node.position] = path.length
            @unprocessed.push(path.clone.add_step(edge))
            @discovered_path_moves[path.moves] = true
          end
        end
      end
    end
    @found_paths
  end

  def work_remains?
    not @unprocessed.empty? and minimal_path_candidates_remain?
  end

  def minimal_path_candidates_remain?
    @found_paths.empty? or @found_paths[0].length == @unprocessed[0].length
  end

  def minimal_subpath?(path, edge)
    distance_threshhold(edge).nil? or exceeds_threshhold?(path, edge)
  end

  def distance_threshhold(edge)
    @shortest_distance_to_position[edge.node.position]
  end

  def exceeds_threshhold?(path, edge)
    distance_threshhold(edge) == path.length and not @discovered_path_moves[path.moves]
  end
end
