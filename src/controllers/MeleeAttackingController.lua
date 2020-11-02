MeleeAttackingController = {}
MeleeAttackingController.__index = MeleeAttackingController


function MeleeAttackingController:Create(frame)
    local controller = {
        model = MeleeAttackingModel:Create(),
        vm = {},
        consumers = {}
    }
    controller.vm = MeleeAttackingVM:Create(frame, controller.model)
    controller.consumers["position"] = PositionConsumer:Create(frame)
    controller.consumers["target"] = TargetConsumer:Create(frame)
    controller.consumers["attack"] = AttackConsumer:Create(frame)
    controller.consumers["damage"] = DamageConsumer:Create(frame)

    Event.Register(controller, PositionConsumer.EventId)
    Event.Register(controller, TargetConsumer.EventId)
    Event.Register(controller, AttackConsumer.EventId)
    Event.Register(controller, DamageConsumer.EventId)

    setmetatable(controller, MeleeAttackingController)
    return controller
end

function MeleeAttackingController:OnEvent(event, ...)
    for _, consumer in pairs(self.consumers) do
        consumer:Dispatch(event, ...)
    end
end

function MeleeAttackingController:UpdateModel()
    self.vm:UpdateModel(self.model)
end

function MeleeAttackingController:WrongPositionEvent(eventname, ...)
    self.model.canAttack = false
    self:UpdateModel()
end

function MeleeAttackingController:TargetChangedEvent(eventname, ...)
    local isTargetEnemy = ...

    if (not isTargetEnemy) then
        self.model.canAttack = false
    end

    self.model.shouldShow = isTargetEnemy
    self:UpdateModel()
end

function MeleeAttackingController:AttackEvent(eventname, ...)
    local isAttacking = ...

    local shouldShow = isAttacking

    if (self.model.isTargetingEnemy) then
        shouldShow = true
    end

    self.model.shouldShow = shouldShow
    self.model:OnModelUpdate()
end

function MeleeAttackingController:DamageEvent(eventname, ...)
    local couldDamage = ...

    if (couldDamage) then
        self.model.canAttack = true
    end
    self:UpdateModel()
end

