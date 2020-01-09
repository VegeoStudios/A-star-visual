# A-star-visual
This is a program I created using java in Processing to visualize the A\* pathfinding algorithm in a grid.

Alright, there is a lot going on in this visualization.

First of all, the different tiles:

* Open Set *(green)*
* Closed Set *(red)*
* Unexplored *(white)*
* Obstacles *(black dots)*
* Start/end *(blue)*

# A* algorithm

I am going to avoid fully explaining A\* because I am mildly lazy but here goes nothing.

The algorithm is basically giving each tile that is being "explored" (Open Set) a value. This value is called the "F score" which is the sum of the distance traveled to the point and the underestimated distance to the destination. These are the "G score" and the "H score" respectively.

After the F score is determined for each tile in the open set, the tile with the lowest F score is selected (if there are multiple, I chose the one with the lowest H score in that group) to be explored next. That tile is moved from the open set to the closed set and the neighbors of that tile are added to the open set.

This is just looped through until the path finds the end tile or there is no solution (when the open set is completely empty).

# Visuals

I have many visualizations going on in this program. Let's take a look at the colors.

You may have noticed there are many shades of the same color going on. In the red, I have each tile keep track of when it was added to the closed set. The darker the red, the newer the tile. This is why you see a more gradual gradient along the end path.

The green just gradients by the distance the tile is from the end so there is darker green near the end.

The blue lines you see going everywhere are the various paths that are being checked for the tiles being explored in each frame. The lines are mostly transparent so you can see the most common path being taken.

When the A\* algorithm is finished, there will be a single blue path if it found the destination. If there are a bunch of red paths, that means there is no solution to get to the end tile.

# Animation

As you can see, the algorithm is running incredibly slow. This is because I have so many visual calculations going on.

Every frame I am making many steps in the algorithm. In this case: 30. I keep all the information for each path calculated every frame and store it so I can display it all at once.

# Thoughts?

If you have any suggestions for how I can improve the visualization to show more of what's going on, let me know! If you have any questions, I'd be happy to answer to the best of my ability.

# Edits

**\[0\]** Thank you all for your amazing responses! I am making sure I am replying to all the comments here as I see we have some fellow aspiring computer scientists here.

A mod came by and replied to one of my comments and let me know to try not to post too often haha. All cool, but that means more polished simulations for you people!

I will continue to expand this project and try to create more coding visualizations of algorithms over time but for now, I will try to add your suggestions to this project.

Tomorrow morning I will create a github repository for all you wonderful people to see so you can create your own visualization! The link will be in the next edit.

P.S. So far, this is the most upvotes I have on a single post so thank y’all!

**\[1\]** Sorry, another edit. The *next* edit will be a GitHub link.

A few commenters here and there has pointed out that my algorithm doesn’t really look right. I agree with them that there may be something wrong with my heuristic that I will fix in my next posting, maybe in a few weeks.
