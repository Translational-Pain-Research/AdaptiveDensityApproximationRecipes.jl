module AdaptiveDensityApproximationRecipes

using RecipesBase
import AdaptiveDensityApproximation as ADA

####################################################################################################
# Auxiliary functions
####################################################################################################

# Get coordinates to plot 2-dim rectangle.
function get_rectangle(block::ADA.Block)
	I = block.cuboid[1]
	J = block.cuboid[2]
	return [I.left,I.left,I.right,I.right,I.left], [J.left, J.right,J.right,J.left,J.left]
end

# Get coordinates to plot a bar as rectangle.
function get_bar(block::ADA.OneDimBlock, height_function::Function)
	return [block.interval.left, block.interval.left, block.interval.right, block.interval.right], [0,height_function(block.weight), height_function(block.weight), 0]
end

# Default selector of color and opacity for wight of block, w.r.t. all other weights.
function default_fill_function(weight,weights)
	min_w,max_w  = extrema(weights)
	if min_w == max_w
		opacity = 1
	else
		opacity = (weight - min_w)/(max_w - min_w)
	end
	return (opacity,"Midnight Blue")
end


function default_line_function(weight,weights)
	return (1,:black)
end







####################################################################################################
# Plotting recipes
####################################################################################################

# Plotting recipe for 2-dimensional grids.
@recipe function f(grid::ADA.Grid; line_color_function = default_line_function, fill_color_function = default_fill_function) 
	
	if ADA.dimension(grid) != 2 
		error("Only grids with dimension <= 2 can be plotted.")
	end


	# The color_function need the complete list of weights for every block.
	key_list = collect(keys(grid))
	weights = [grid[key].weight for key in key_list]


	seriestype := :path

	# Plot all blocks in the grid.
	for key in key_list
		@series begin
			label := nothing
			line_opacity, line_color = line_color_function(grid[key].weight,weights)
			fill_opacity, fill_color = fill_color_function(grid[key].weight,weights)
			fillcolor := fill_color
			fillalpha := fill_opacity
			linecolor := line_color
			linealpha := line_opacity

			X,Y = get_rectangle(grid[key])
			fillrange := minimum(Y)

			return X,Y
		end
	end
		
	return nothing
end


# Plotting recipe for one-dimensional grids.
@recipe function f(grid::ADA.OneDimGrid; line_color_function = default_line_function, fill_color_function = default_fill_function, height_function = x-> x, vertical = false) 

	# The color_function need the complete list of weights for every block.
	key_list = collect(keys(grid))
	weights = [grid[key].weight for key in key_list]

	seriestype := :path

	# Plot all intervals in the grid.
	if vertical
		for key in key_list
			@series begin
				label := nothing
				line_opacity, line_color = line_color_function(grid[key].weight,weights)
				fill_opacity, fill_color = fill_color_function(grid[key].weight,weights)
				fillcolor := fill_color
				fillalpha := fill_opacity
				linecolor := line_color
				X, Y = get_bar(grid[key], height_function)
				fillrange := minimum(X)
				return Y,X
			end
		end
	else
		for key in key_list
			@series begin
				label := nothing
				line_opacity, line_color = line_color_function(grid[key].weight,weights)
				fill_opacity, fill_color = fill_color_function(grid[key].weight,weights)
				fillcolor := fill_color
				fillalpha := fill_opacity
				linecolor := line_color
				fillrange := 0
				return get_bar(grid[key], height_function)
			end
		end
	end

	return nothing
end



end
