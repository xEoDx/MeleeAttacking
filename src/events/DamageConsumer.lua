DamageConsumer = {
    EventId = "DamageEvent",
    AllowedEvents = {
        COMBAT_LOG_EVENT_UNFILTERED = true
    }
}
DamageConsumer.__index = DamageConsumer


function DamageConsumer:Create(frame)
    for k, v in pairs(self.AllowedEvents) do
        frame:RegisterEvent(k);
    end

    local consumer = {}
    setmetatable(consumer, DamageConsumer)

    return consumer
end


function DamageConsumer:Dispatch(event, ...)
    if (self.AllowedEvents[event] == nil) then return end

    local _, subevent,_,_,sourceName = CombatLogGetCurrentEventInfo()


    if(sourceName ~= UnitName("player")) then return end

    local couldDamage = false

    if (subevent == "SWING_DAMAGE" or subevent == "SPELL_DAMAGE") then
        couldDamage = true
    end

    Event.Trigger(self.EventId, couldDamage)
end
