extends Node

@export var stationRecipies: Dictionary[Station,StationRecipies]

func get_result_for(item: Item, station: Station) -> Item:
	var recipes:Array[Recipe]=get_recipies(station)
	for recipe in recipes:
		if recipe.require == item :
			return recipe.result
	return null

func get_recipe(item: Item, station: Station) -> Recipe:
	var recipes:Array[Recipe]=get_recipies(station)
	for recipe in recipes:
		if recipe.require == item and recipe.station == station:
			return recipe[station.name]
	return null

func get_recipies(station:Station)->Array[Recipe]:
		return stationRecipies[station].recipies
