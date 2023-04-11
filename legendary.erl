import String
defmodule M2 do
	def main do
		ceil_map = %{ 1 => [4],
					  2 => [3,5],
					  3 => [2],
					  4 => [1,7],
					  5 => [2,6,8],
					  6 => [5,9],
					  7 => [4,8],
					  8 => [5,7],
					  9 => [6]
		}

		_matrix_of_sum = [["na","na",15],
						 ["na","na",12],
						 ["na",10,"na"],
		]


		start_position=1
		_end_position=3
		list_of_locations = [2,3,6,8]

	IO.write "Start location: "
	IO.inspect start_position
	IO.write "List of locations to visit: "
	IO.inspect list_of_locations
	final(start_position,list_of_locations,ceil_map)
		
	end

	def final(start_position,list_of_locations,ceil_map) do
		unless list_of_locations==[] do
			spaths_to_each_unfound_locations = spaths(start_position,list_of_locations,ceil_map)
		#IO.write "Shortest path's index is: "
		#IO.inspect spaths_to_each_unfound_locations
		start_position = Enum.at(list_of_locations,spaths_to_each_unfound_locations)
		IO.write "Next location to go: "
		IO.inspect start_position
		list_of_locations = List.delete_at(list_of_locations,spaths_to_each_unfound_locations)
		final(start_position,list_of_locations,ceil_map)
		end
	end

	def spaths(start,list_of_locations,ceil_map,mini,index,count) do
		unless list_of_locations==[] do
			len = String.length(any_direction_from_to(start,hd(list_of_locations),ceil_map))
			if len<mini do
				spaths(start,tl(list_of_locations),ceil_map,len,count,count+1)
			else
				spaths(start,tl(list_of_locations),ceil_map,mini,index,count+1)
			end
		else
			index
		end	
	end

	def spaths(start,list_of_locations,ceil_map) do
		spaths(start,list_of_locations,ceil_map,10000,0,0)
	end

	def any_direction_from_to(start,end_pos,ceil_map) do
		mapi = generate_map(%{},ceil_map,26,[start],1,[])
		#IO.write start
		actual_index = custom_bfs(mapi,end_pos,[start],1)

		#position_to_conquer = decide_whom_to_conquer_first(not_visited,)

		#readable = index_to_human_readable(Integer.to_string(actual_index,2),mapi,1,mapi[start],actual_index,[])
		Integer.to_string(actual_index,2)
	end

	def make_2_elements(l,i) do
		if i==2 do
			l
		else
			make_2_elements(l ++ [-1],i+1)
		end
	end

	#custom_bfs(mapp,x,[start_position],1)
	#Map.put(mapi,hd(start_list),mapp[hd(start_list)])'

	def get_length(list,i) do
		if list==[] or hd(list)==nil do
			i
		else
			get_length(tl(list),i+1)
			
		end
	end

	def get_length(list) do
		get_length(list,0)
	end

	def generate_map(mapi,mapp,element_to_find,start_list,index,visited) do
		if Enum.count(mapi)==9 do
			mapi
		else
			if hd(start_list)==-1 do
				generate_map(mapi,mapp,element_to_find,tl(start_list) ++ [-1,-1],index+1,visited)
			else
				unless Enum.member?(visited,hd(start_list)) do
					new_list = mapp[hd(start_list)] -- visited
					new_list = make_2_elements(new_list,get_length(new_list))

					generate_map(Map.put(mapi,hd(start_list),new_list),mapp,element_to_find,tl(start_list) ++ mapp[hd(start_list)],index+1,visited ++ [hd(start_list)])
				else
					generate_map(mapi,mapp,element_to_find,tl(start_list) ++ mapp[hd(start_list)],index+1,visited)
				end
			end
		end
	end




	def index_to_human_readable(string,mapp,index,list,max_index,store) do
		
		if at(string,index)=="0" do
			#IO.write " --> "
			#IO.write hd(list)
			index_to_human_readable(string,mapp,index+1,mapp[hd(list)],max_index,store ++ [hd(list)])
		end
			
		if at(string,index)=="1" do
			#IO.write " --> "
			#IO.write hd(tl(list))
			index_to_human_readable(string,mapp,index+1,mapp[hd(tl(list))],max_index,store ++ [hd(tl(list))])
		end
	
	end

	def custom_bfs(mapp,element_to_find,start_list,index) do
		
		if hd(start_list)==element_to_find do
			index
		else
			if hd(start_list)==-1 do
				custom_bfs(mapp,element_to_find,tl(start_list) ++ [-1,-1],index+1)
			else
				custom_bfs(mapp,element_to_find,tl(start_list) ++ mapp[hd(start_list)],index+1)
			end
		end
	end

end