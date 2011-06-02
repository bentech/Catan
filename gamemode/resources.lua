
local Prefix = string.sub(GM.Folder, 11)
local PrefixContent = "../gamemodes/"..Prefix.."/content"

function addResourceDirectory(Dir)
	Msg("AddResourceDirectory: "..Dir.."...\n")
	local FoundDir = false
 	for k,v in pairs(file.Find(PrefixContent.."/"..Dir.."/*")) do
		local File = Dir.."/"..v
		if(file.IsDir(PrefixContent.."/"..File)) then
			FoundDir = true
			self:AddResourceDirectory(File)
		elseif(!string.find(v, ".bz2", 1, true) and !string.find(v, ".bat", 1, true)) then
			Msg("\tresource.AddFile "..File..":")
			resource.AddFile(File)
			Msg("Successful\n")
		end
 	end
	if(!FoundDir) then
		Msg("AddResourceDirectory: Successful\n")
	end
end

for k,v in pairs(file.Find(PrefixContent.."/*")) do
	if(file.IsDir(PrefixContent.."/"..v)) then
		addResourceDirectory(v)
	end
end
