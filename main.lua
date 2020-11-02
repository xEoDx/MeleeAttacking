print("Starting MeleeAttackingController")
local frame = CreateFrame("Frame")
local meleeController = MeleeAttackingController:Create(frame)

frame:SetScript('OnEvent',
    function(self, event, ...)
        meleeController:OnEvent(event, ...)
    end)
