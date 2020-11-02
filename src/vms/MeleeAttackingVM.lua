MeleeAttackingVM = {}
MeleeAttackingVM.__index = MeleeAttackingVM

function MeleeAttackingVM:Create(frame, model)
    local vm = {}

    vm.model = model
    local size = 64

    frame:SetSize(size, size) -- not sure if this is needed when you set absolute sizes on the textures
    frame:SetPoint("CENTER")
    frame:SetMovable(true)
    frame:EnableMouse(true)
    frame:RegisterForDrag("LeftButton")
    frame:SetScript("OnDragStart", frame.StartMoving)
    frame:SetScript("OnDragStop", frame.StopMovingOrSizing)

    local texture = frame:CreateTexture()
    texture:SetTexture([[Interface\AddOns\MeleeAttacking\textures\melee-attack-overlay.blp]])
    texture:SetPoint("CENTER")
    texture:SetSize(size, size)

    vm.frame = frame
    vm.texture = texture

    setmetatable(vm, MeleeAttackingVM)

    return vm
end

function MeleeAttackingVM:UpdateModel(model)
    self.model = model

    if (self.model.canAttack) then
        self:SetGreen()
    else
        self:SetRed()
    end
end

function MeleeAttackingVM:SetRed()
    self.texture:SetColorTexture(255, 0, 0, self:GetAlpha())
end

function MeleeAttackingVM:SetGreen()
    self.texture:SetColorTexture(0, 255, 0, self:GetAlpha())
end

function MeleeAttackingVM:GetAlpha()
    local alpha = 0

    if (self.model.shouldShow) then
        alpha = 1
    end

    return alpha
end

function MeleeAttackingVM:StopMovingFrame()
    print("DRAG STOP CALLED")
    self.frame:StopMovingOrSizing()

    local from, _, _, x, y = self.frame:GetPoint()

    self.texture.position.relativeTo = from
    self.texture.position.x = x
    self.texture.position.y = y
end