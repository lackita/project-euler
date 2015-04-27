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

if BFS.new(start, finish).confirm_path
  print "finish found"
end
