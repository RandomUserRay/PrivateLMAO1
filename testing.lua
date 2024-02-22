local Library = loadstring(game:HttpGet("https://raw.githubusercontent.com/xHeptc/Kavo-UI-Library/main/source.lua"))()
local Window = Library.CreateLib("BreakHub | BP Dupe", "BloodTheme")
local Tab = Window:NewTab("Dupes")
local Section = Tab:NewSection("BP Dupe Prices:")
Section:NewLabel("/E Rain = 3 Credits")
Section:NewLabel("Ice Crown = 10K Credits")
Section:NewLabel("Royal Red = 10K Credits")
Section:NewLabel("Knife Antlers = 10K Credits")
Section:NewDropdown("BP Dupe", "Use This Script!", {"/E Rain", "Ice Crown", "Royal Red", "Knife Antlers"}, function(Value)
    game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "BreakHub";
	Text = "Duping, "..(Value).."...";
	Icon = "rbxthumb://type=Asset&id=11002973134&w=150&h=150"})
Duration = 5;
wait(5)
    game:GetService("StarterGui"):SetCore("SendNotification", { 
	Title = "BreakHub";
	Text = "Duped, "..(Value).."!";
	Icon = "rbxthumb://type=Asset&id=11002973134&w=150&h=150"})
Duration = 5;
--Dupes
if (Value) == "/E Rain" then
local args = {
    [1] = 66,
    [2] = "Animations",
    [3] = "Exclusive"
}

game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
end
if (Value) == "Ice Crown" then
local args = {
    [1] = 66,
    [2] = "Knife Skins",
    [3] = "Winter"
}

game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
end
if (Value) == "Royal Red" then
local args = {
    [1] = 66,
    [2] = "Chair Skins",
    [3] = "Winter"
}

game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
end
if (Value) == "Knife Antlers" then
local args = {
    [1] = 66,
    [2] = "Accessories",
    [3] = "Knife Antlers"
}

game:GetService("ReplicatedStorage").RemoteFunction:InvokeServer(unpack(args))
end
end)
