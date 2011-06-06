
GM.TurnManager = {}

ENUM_PLACEMENT_BACKWARD = 0
ENUM_PLACEMENT_FORWARD = 1

ENUM_TURN_GATHER = 0
ENUM_TURN_TRADE = 1
ENUM_TURN_BUILD = 2

function GM.TurnManager:GetTurnManager(CGame)
    local Table = {}
    setmetatable(Table, self)
    self.__index = self
    Table.CGame = CGame
	Table.Players = table.Copy(CGame:GetPlayers())
	Table.PlayerCount = table.Count(Table.Players)
	Table.Turn = 1
	Table.TurnPhase
	Table.Playing = false
	Table.InitilizationPhase = ENUM_PLACEMENT_BACKWARD
	Table.InitialRolls = {}
	for k,v in pairs(self.Players) do
		v:RollDie()
	end
    return Table
end

function GM.TurnManger:SetupOrder()
	table.sort(self.InitialRolls)
	
	for k,v in pairs(self.Players) do
		if(self.InitialRolls[self.PlayerCount] == v) then
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

function GM.TurnManager:OnDiceRolled(CPlayer, Result)
	self.InitialRolls[CPlayer] = Result
	if(table.Count(self.InitialRolls) == self.PlayerCount) then
		self:SetupOrder()
	end
end

function GM.TurnManager:StartTurn()
	if(self.Playing) then
		self.TurnPhase = ENUM_TURN_GATHER
		
	else // Setting up the board
		if(self.Turn == 0) then
			self.Turn = self.PlayerCount
		else if(self.Turn > self.PlayerCount) then
			self.Turn = 1
		end
		
		self.Players[self.Turn]:PlacePiece()
		
		if(self.InitilizationPhase == ENUM_PLACEMENT_FORWARD) then
			if(self.Turn == self.FirstTurn) then
				self.Playing = true
				return
			else
				self.Turn = self.Turn + 1
			end
		else
			if(self.Turn == self.LastTurn) then
				self.InitilizationPhase = ENUM_PLACEMENT_FORWARD
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