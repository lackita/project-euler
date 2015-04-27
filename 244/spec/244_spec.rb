require 'graph'
require 'search'

describe "open slot" do
  it "is in the top left" do
    expect(Node.new([[" ", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"]]).open_slot).to eq TilePosition.new(0, 0)
  end

  it "is in the bottom right" do
    expect(Node.new([["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "B", "B", " "]]).open_slot).to eq TilePosition.new(3, 3)
  end

  it "is somewhere in the middle" do
    expect(Node.new([["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", " ", "B", "B"],
                     ["R", "R", "B", "B"]]).open_slot).to eq TilePosition.new(2, 1)
  end
end

describe "graph node" do
  it "has four edges in the middle" do
    expect(Node.new([["R", "R", "B", "B"],
                     ["R", " ", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"]]).edges.length).to eq 4
  end

  it "has three edges on the top row" do
    expect(Node.new([["R", " ", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"]]).edges.length).to eq 3
  end

  it "has three edges on the bottom row" do
    expect(Node.new([["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", " ", "B", "B"]]).edges.length).to eq 3
  end

  it "has three edges on the left column" do
    expect(Node.new([["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     [" ", "R", "B", "B"],
                     ["R", "R", "B", "B"]]).edges.length).to eq 3
  end

  it "has three edges on the right column" do
    expect(Node.new([["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "B", "B", " "],
                     ["R", "R", "B", "B"]]).edges.length).to eq 3
  end

  it "is connected to the graph node resulting in sliding a tile to the left" do
    expect(Node.new([["R", " ", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"]]).edges.find do |edge|
             edge.direction == "L"
           end.node).to eq Node.new([["R", "B", " ", "B"],
                                     ["R", "R", "B", "B"],
                                     ["R", "R", "B", "B"],
                                     ["R", "R", "B", "B"]])
  end

  it "is connected to the graph node resulting in sliding a tile to the right" do
    expect(Node.new([["R", " ", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"]]).edges.find do |edge|
             edge.direction == "R"
           end.node).to eq Node.new([[" ", "R", "B", "B"],
                                     ["R", "R", "B", "B"],
                                     ["R", "R", "B", "B"],
                                     ["R", "R", "B", "B"]])
  end

  it "is connected to the graph node resulting in sliding a tile up" do
    expect(Node.new([["R", " ", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"]]).edges.find do |edge|
             edge.direction == "U"
           end.node).to eq Node.new([["R", "R", "B", "B"],
                                     ["R", " ", "B", "B"],
                                     ["R", "R", "B", "B"],
                                     ["R", "R", "B", "B"]])
  end

  it "is connected to the graph node resulting in sliding a tile up" do
    expect(Node.new([["R", "R", "B", "B"],
                     ["R", " ", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"]]).edges.find do |edge|
             edge.direction == "D"
           end.node).to eq Node.new([["R", " ", "B", "B"],
                                     ["R", "R", "B", "B"],
                                     ["R", "R", "B", "B"],
                                     ["R", "R", "B", "B"]])
  end

  it "is not modified by checking adjacent edges" do
    node = Node.new([["R", " ", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"],
                     ["R", "R", "B", "B"]])
    node.edges.find do |edge|
      edge.direction == "L"
    end.node
    expect(node).to eq Node.new([["R", " ", "B", "B"],
                                 ["R", "R", "B", "B"],
                                 ["R", "R", "B", "B"],
                                 ["R", "R", "B", "B"]])
  end
end

describe "path" do
  it "computes the example checksum correctly" do
    path = Path.new(Node.new([[" ", "R", "B", "B"],
                              ["R", "R", "B", "B"],
                              ["R", "R", "B", "B"],
                              ["R", "R", "B", "B"]]))
    ["L", "U", "L", "U", "R"].each do |direction|
      path.add_step(path.node.edges.find { |edge| edge.direction == direction })
    end
    expect(path.checksum).to eq 19761398
  end

  it "is not affected by actions to cloned copies" do
    path = Path.new(Node.new([[" ", "R", "B", "B"],
                              ["R", "R", "B", "B"],
                              ["R", "R", "B", "B"],
                              ["R", "R", "B", "B"]]))
    new_path = path.clone
    new_path.add_step(path.node.edges.first)
    expect(path.checksum).to eq 0
  end
end

describe "bfs" do
  it "computes multiple paths of minimal length" do
    start = Node.new([[" ", "R", "B", "B"],
                      ["R", "R", "B", "B"],
                      ["R", "R", "B", "B"],
                      ["R", "R", "B", "B"]])

    finish = Node.new([["R", "R", "B", "B"],
                       ["R", " ", "B", "B"],
                       ["R", "R", "B", "B"],
                       ["R", "R", "B", "B"]])

    expect(BFS.new(start, finish).minimal_paths.length).to eq 2
  end
end
