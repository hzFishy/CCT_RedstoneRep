local modem;


local function OpenConnection()
    rednet.CHANNEL_BROADCAST = Config.channelId;
    rednet.open(Config.modemSide);
    print("Channel opened");
end


local function WaitForMessage()
    local id, message = rednet.receive(nil, 20);
    print(("Computer %d sent message %s"):format(id, message));
    return message;
end


local function WaitForMessages()
    while true do
        local message = WaitForMessage();
        if message == "On" then
            redstone.setAnalogOutput(Config.redstoneSide, 15);
        elseif message == "Off" then
            redstone.setAnalogOutput(Config.redstoneSide, 0);
        end

        sleep(0.1);
    end
end

return
{
    OpenConnection = OpenConnection,
    WaitForMessages = WaitForMessages
}
