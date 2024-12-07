# Hex-Grid-movement-in-godot
The Movement and tile creation for a Hex Based grid system for the godot game engine. 
This project implements a Cube Coordinate based hex grid system. 
The reason for using a custom hex tiling system over using Godots built in hexagonal tile map layer is due to the way the Godot stores the tiles in thier implentation. Cube Coords allow for easier neighbor finding and distance and pathfinding calculations. It also give more flexiblity on how the class and maps are dealt with. 
The research and development of this project is based of [Red Blog Games hex guide](https://www.redblobgames.com/grids/hexagons/) which lays out the theory behind implementing a hex grid for a game. 

## My implementation

This project can be split into 3 main sections: `Hexgrid class`, `Hexcell class` and `player class`. lets start with the `HexCell` class.

### HexCell class
The HexCell class serves as the basis of our grid. It contains all the information that is unique to each cell such as the cube coords, pixel coords, walkability, and movement cost. When created it will istantiate all of its variables and that is it. The class also contains functions to convert between pixel and cube coords and back.

## HexGrid Class
This class contains an array of HexCell objs that make up the map. it has a function that will read in a .json file (that must be set up properly) and then create and add to the scene all of the hexes that are in the json file. This class also has the ability to find hex based of of pixel coords(important for the player class) , and a function find path that will find the shorest path ( based on movement cost) between two hexes. the find path algorithm is based off of dijkstras algorithm. Dijkstras is neccassary over other search algorithms such as BFS because of the possibility of the hexes having a different movement cost to cross.
