AttackConsumer = {
    EventId = "AttackEvent",
    AllowedEvents = {
        PLAYER_ENTER_COMBAT = true,
        PLAYER_LEAVE_COMBAT = true
    }
}
AttackConsumer.__index = AttackConsumer


function AttackConsumer:Create(frame)
    for k, v in pairs(self.AllowedEvents) do
        frame:RegisterEvent(k);
    end

    local consumer = {}
    setmetatable(consumer, AttackConsumer)

    return consumer
end


function AttackConsumer:Dispatch(event, ...)
    if (self.AllowedEvents[event] == nil) then return end

    local isAttacking = false;

    if(event == "PLAYER_ENTER_COMBAT") then
        isAttacking = true
    end

    Event.Trigger(self.EventId, isAttacking)
end
