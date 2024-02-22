game:GetService("Players").LocalPlayer.Idled:connect(function()
game:GetService("VirtualUser"):ClickButton2(Vector2.new())
end)

if game.PlaceId == 648362523 then
    repeat wait() until game:IsLoaded()
    game.StarterGui:SetCore(
        "SendNotification",
        {
            Title = "AutoFarm Credits Inf",
            Text = "Made by Zxyia | a.k.a Ray"
        }
    )
    
    
    
        pcall(function()
        game:GetService("ReplicatedStorage").RemoteEvent:FireServer(16, "public")
        end)
        wait()
        for i, v in pairs(game.Players:GetPlayers()) do
            if v.Name == game.Players.LocalPlayer.Name then
            else
                pcall(function()
                game:GetService("ReplicatedStorage").RemoteEvent:FireServer(30, v)
                end)
            end
        end
    end
else
    game:GetService("TeleportService"):Teleport(648362523, LocalPlayer)
end


if getgenv().ServerHop == true then
wait (1500)
game:GetService("TeleportService"):Teleport(648362523, LocalPlayer)
end