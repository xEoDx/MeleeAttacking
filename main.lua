--SLASH_CHECK1 = "/check"
--
--local function CheckDistance(msg)
--	if ( CheckInteractDistance("target", 3) ) then
--	  print("Ready to attack")
--	else
--	  print("Too far away")
--	end
--end
--
--SlashCmdList["CHECK"] = CheckDistance;
--
--
--ERR_BADATTACKFACING = "You are facing the wrong way!";
--ERR_BADATTACKPOS = "You are too far away!";
--
--local f = CreateFrame("Frame")
--f:RegisterEvent("UI_ERROR_MESSAGE")


print("Starting MeleeAttackingController")
local frame = CreateFrame("Frame")
local meleeController = MeleeAttackingController:Create(frame)

frame:SetScript('OnEvent',
    function(self, event, ...)
        meleeController:OnEvent(event, ...)
    end)
