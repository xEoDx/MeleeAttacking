TargetConsumer = {
    EventId = "TargetChangedEvent",
    AllowedEvents = {
        PLAYER_TARGET_CHANGED = true
    }
}
TargetConsumer.__index = TargetConsumer


function TargetConsumer:Create(frame)
    for k, v in pairs(self.AllowedEvents) do
        frame:RegisterEvent(k);
    end

    local consumer = {}
    setmetatable(consumer, TargetConsumer)

    return consumer
end


function TargetConsumer:Dispatch(event, ...)
    if (self.AllowedEvents[event] == nil) then return end

    local isTargetEnemy = false
    if (UnitIsEnemy("player", "target")) then
        isTargetEnemy = true
    end

    Event.Trigger(self.EventId, isTargetEnemy)
end
