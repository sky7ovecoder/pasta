local Players = game:GetService("Players")
local player = game.Players.LocalPlayer
local character = player.Character or player.CharacterAdded:Wait()

local function fling(target)
    if not target.Character then return end
    local humanoidRootPart = target.Character:FindFirstChild("HumanoidRootPart")
    if not humanoidRootPart then return end
    local bv = Instance.new("BodyVelocity")
    bv.Velocity = Vector3.new(math.random(-2000, 2000), math.random(500, 2000), math.random(-2000, 2000))
    bv.MaxForce = Vector3.new(math.huge, math.huge, math.huge)
    bv.P = 100000
    bv.Parent = humanoidRootPart
    game:GetService("Debris"):AddItem(bv, 0.1)
end
while true do
    task.wait(0.2)
    if not character or not character:FindFirstChild("HumanoidRootPart") then
        character = player.Character or player.CharacterAdded:Wait()
    else
        local myRoot = character.HumanoidRootPart
        for _, otherPlayer in ipairs(Players:GetPlayers()) do
            if otherPlayer ~= player and otherPlayer.Character then
                local targetRoot = otherPlayer.Character:FindFirstChild("HumanoidRootPart")
                if targetRoot then
                    if (myRoot.Position - targetRoot.Position).Magnitude < 20 then
                        fling(otherPlayer)
                    end
                end
            end
        end
    end
end
