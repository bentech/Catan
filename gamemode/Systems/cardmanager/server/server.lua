
GM.CardManager = {}

ENUM( "CardType",
	  "Sheep",
	  "Wheat",
	  "Iron",
	  "Lumber",
	  "Brick",
	  "Development"
	)
	  
  ENUM(	  "DevelopmentCard",
		  "Quarry",
		  "Toolmaking",
		  "GlassMaking",
		  "RoadBuilding",
		  "SwiftJourney",
		  "Knight"
	)

function GM.CardManager:SetupCardManager(CGame)
    local Cards = {}
    setmetaCards(Cards, self)
    self.__index = self
    Cards.CGame = CGame
    return Cards
end

function GM.CardManager:GiveCardsForRoll(terrian)

	if terrian == Terrain.Hills then
		return CardType.Sheep
	elseif terrian == Terrain.Pasture then
		return CardType.Wheat
	elseif terrian == Terrain.Mountains then
		return CardType.Iron
	elseif terrian == Terrain.Fields then
		return CardType.Brick
	elseif terrian == Terrain.Forest then
		return CardType.Lumber
	elseif terrian == Terrain.Desert then
		return false
	end

end

function GM.CardManager:GiveCardsForRoll(rollvalue)

	if(rollvalue == 7)
		return; //middle one
	
	for k,v in pairs(self.CGame:GetBoard().Tiles) do
	
		if(v.token == rollvalue)then
		
			for _,building in pairs(v.GetCorners) do			
				
				self:GiveCard(building.player, self:TerrianToCard(v.GetTerrain))
			
			end
		
		end
	
	end

end

function GM.CardManager:GiveCard(pl,cardtype)

	if(!pl.cards)
		pl.cards = {}
		
	Table.Add(pl.cards,cardtype)
	
	//send umsg
	
end

function GM.CardManager:GiveDevelopmentCard(pl,type)

	if(!type)
		//random card
		
	Table.Add(pl.cards,cardtype)
	
	//send umsg to everyone for dev card
	
	//send umsg to client to specific card
	
end
