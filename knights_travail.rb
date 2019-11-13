class Square

    attr_accessor :x, :y, :children, :parent
    def initialize(x, y, parent = nil)
        @x = x
        @y = y
        @children = []
        @parent = parent
    end

    def make_children()
        possible_coords = []
        moves = [[2,-1],[2,1],[1,2],[-1,2],[-2,1],[-2,-1],[-1,-2],[1,-2]]

        moves.each do |coord|
            possible_coords.push([@x + coord[0], @y + coord[1]])
        end
        
        children = possible_coords.select {|coord| coord[0] >=0 && coord[0] <= 7 && coord[1] >=0 && coord[1] <=7}
        @children = children.map do |child_coords| 
            Square.new(child_coords[0], child_coords[1], self)
        end
    end

    def get_search_coord(search_coord, root_coord)
        queue = []
        queue << root_coord
        until queue.nil?
            current_coord = queue.shift

            return current_coord if current_coord.x == search_coord.x && current_coord.y == search_coord.y
            current_coord.make_children.each {|child| queue << child}
        end
    end

    def find_route(root_arr, search_arr)
        search = Square.new(search_arr[0], search_arr[1])
        root = Square.new(root_arr[0], root_arr[1])
        results = get_search_coord(search, root)

        route = []
        route.unshift([search.x, search.y])
        current = results.parent

        until current.nil?
            route.unshift([current.x, current.y])
            current = current.parent
        end
        puts "Route path:"
        route.each {|coords| puts coords.inspect}
        return nil
    end
end

test = Square.new(2,3)
test.make_children()
test.find_route([3, 2], [4, 6])

