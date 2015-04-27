require 'graph'
require 'search'

finish = Node.new([[" ", "B", "R", "B"],
                   ["B", "R", "B", "R"],
                   ["R", "B", "R", "B"],
                   ["B", "R", "B", "R"]])

start = Node.new([[" ", "R", "B", "B"],
                  ["R", "R", "B", "B"],
                  ["R", "R", "B", "B"],
                  ["R", "R", "B", "B"]])

print BFS.new(start, finish).minimal_paths.map { |path| path.checksum }.inject :+
