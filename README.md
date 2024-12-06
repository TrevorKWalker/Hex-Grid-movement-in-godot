# Hex-Grid-movement-in-godot
The Movement and tile creation for a Hex Based grid system for the godot game engine. 
This project implements a Cube Coordinate based hex grid system. 
The reason for using a custom hex tiling system over using Godots built in hexagonal tile map layer is due to the way the Godot stores the tiles in thier implentation. Cube Coords allow for easier neighbor finding and distance and pathfinding calculations. It also give more flexiblity on how the class and maps are dealt with. 
The research and development of this project is based of `(Red Blog Games hex guide)[https://www.redblobgames.com/grids/hexagons/]` which lays out the theory behind implementing a hex grid for a game. 

## My implementation

This project can be split into 3 main sections: `Hexgrid class`, `Hexcell class` and `player class`
