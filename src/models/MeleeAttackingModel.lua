MeleeAttackingModel = {canAttack = false, shouldShow = false}
MeleeAttackingModel.__index = MeleeAttackingModel

function MeleeAttackingModel:Create()
    local model = {}

    setmetatable(model, MeleeAttackingModel)

    return model
end