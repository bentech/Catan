
GM.TurnManager = {}

ENUM( "TurnPlacement",
	"Backward",
	"Forward"
	)

ENUM( "TurnState",
	"Gather",
	"Trade",
	"Build"
	)

function GM.TurnManager:GetTurnManager(CGame)
    local Table = {}
    setmetatable(Table, self)
    self.__index = self
    Table.CGame = CGame
	Table.Players = table.Copy(CGame:GetPlayers())
	Table.PlayerCount = table.Count(Table.Players)
	Table.Turn = 1
	Table.TurnPhase = TurnState.Gather
	Table.Playing = false
	Table.InitilizationPhase = TurnPlacement.Backward
	Table.InitialRolls = {}
    return Table
end

function GM.TurnManager:SetupOrder()
	table.SortByMember(self.InitialRolls, "Roll")
	
	for k,v in pairs(self.Players) do
		if(self.InitialRolls[1].ply == v) then
			self.FirstTurn = k
			break
		end
	end
	
	self.LastTurn = self.FirstTurn + 1
	if(self.LastTurn > self.PlayerCount) then
		self.LastTurn = 0
	end
	
	self.Turn = self.FirstTurn
	self:StartTurn()
end

function GM.TurnManager:OnGameStarted()
	
	for k,v in pairs(self.Players) do
		v:RollDie()
	end
	
end

function GM.TurnManager:OnDiceRolled(CPlayer, Result)
	table.insert(self.InitialRolls, {ply = CPlayer, Roll = Result})
	if(table.Count(self.InitialRolls) == self.PlayerCount) then
		self:SetupOrder()
	end
end

function GM.TurnManager:StartTurn()
	if(self.Playing) then
		self.TurnPhase = TurnState.Gather
		
	else // Setting up the board
		if(self.Turn == 0) then
			self.Turn = self.PlayerCount
		elseif(self.Turn > self.PlayerCount) then
			self.Turn = 1
		end
		
		self.Players[self.Turn]:PlacePiece()
		
		if(self.InitilizationPhase == TurnPlacement.Forward) then
			if(self.Turn == self.FirstTurn) then
				self.Playing = true
				return
			else
				self.Turn = self.Turn + 1
			end
		else
			if(self.Turn == self.LastTurn) then
				self.InitilizationPhase = TurnPlacement.Forward
			else
				self.Turn = self.Turn - 1
			end
		end
	end
end

function GM.TurnManager:Think()

end

function GM.TurnManager:EndTurn()

end