PositionConsumer = {
    EventId = "WrongPositionEvent",
    AllowedEvents = {
        UI_ERROR_MESSAGE = true
    }
}
PositionConsumer.__index = PositionConsumer


function PositionConsumer:Create(frame)
	for k, v in pairs(self.AllowedEvents) do
        frame:RegisterEvent(k);
	end

	local consumer = {}
	setmetatable(consumer, PositionConsumer)

	return consumer
end


function PositionConsumer:Dispatch(event, ...)
    if (self.AllowedEvents[event] == nil) then return end

    local subError = select(2, ...)
    if (subError == nil) then return end

    if (subError == ERR_BADATTACKPOS or subError == ERR_BADATTACKFACING) then
        Event.Trigger(self.EventId, false)
    end
end
