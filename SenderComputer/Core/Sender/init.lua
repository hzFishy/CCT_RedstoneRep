local function OpenConnection()
    rednet.CHANNEL_BROADCAST = Config.channelId;
    rednet.open(Config.modemSide);
    print("Channel opened");
end


local function SendMessage(...)
    rednet.broadcast(...);
    print("Broadcasted: ", ...)
end


local function ListenForRedstoneChange()
    while true do
        local strength = redstone.getAnalogInput(Config.redstoneSide);
        if strength > 0 then
            SendMessage("On");
        else
            SendMessage("Off");
        end

        sleep(0.2);
    end
end


return
{
    OpenConnection = OpenConnection,
    ListenForRedstoneChange = ListenForRedstoneChange
}
