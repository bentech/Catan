// Shared file

AddCSLuaFile"cl_init.lua"
AddCSLuaFile"includes.lua"
include"cl_init.lua"

GM.Name 	= "Settlers of GMod"
GM.Author 	= "Sassafrass, Overv, and Spacetech"
GM.Email 	= ""
GM.Website 	= ""

GM.PlayerMeta = FindMetaTable("Player")
GM.EntityMeta = FindMetaTable("Entity")

ENUM( "TEAMS",
	"JOINING",
	"PLAYERS",
	"SPECTATORS"
	)

team.SetUp(TEAMS.JOINING, "Initializing", Color(80, 80, 80, 255))
team.SetUp(TEAMS.PLAYERS, "Players", Color(220, 20, 20, 255))
team.SetUp(TEAMS.SPECTATORS, "Players", Color(220, 20, 20, 255))

print("###################################")
print("#        Settlers of GMod         #")

include"includes.lua"

print("###################################")