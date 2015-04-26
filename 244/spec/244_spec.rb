require 'graph'

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

  it "has the same hash function as its position" do
    position = [["R", " ", "B", "B"],
                ["R", "R", "B", "B"],
                ["R", "R", "B", "B"],
                ["R", "R", "B", "B"]]
    expect(Node.new(position).hash).to eq position.hash
  end
end

describe "checksum" do
  it "computes the example checksum correctly" do
    expect(Path.new([76, 85, 76, 85, 82]).checksum).to eq 19761398
  end
end
