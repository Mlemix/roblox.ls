local rs = game:GetService('RunService')
local ts = game:GetService("TweenService")
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer
local mouse = lp:GetMouse()
local cam = workspace.CurrentCamera

local collection = {
    noClip = false,
}

collection.tweenTP = function(to, t, back, callback, callbackonback)
        if collection.noClip then sbnc = true end
        local hrp = lp.Character.HumanoidRootPart
        local op = CFrame.new(hrp.Position)
        
        collection.noClip = true
        
        ts:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = to}):Play()
        wait(t + 0.1)
        if callback then callback() end
	wait(0.2)
	if not sbnc then collection.noClip = false end
	if not back then return end
        ts:Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = op}):Play()
	wait(t + 0.1)
	if callbackonback then callbackonback() end
end

collection.findCharacterInFOV = function(fov, wallcheck, othercheck) 
    local plr = nil
    local sdis = math.huge
    for _, v in pairs(plrs:GetPlayers()) do
        if v.Character and v.Character:FindFirstChild("Head") and v ~= lp and (othercheck and othercheck(v) or true) then
            local pos, vis = cam:WorldToViewportPoint(v.Character:FindFirstChild("Head").Position)
            if (vis and not wallcheck or vis) then
                local magnitude = (Vector2.new(pos.X, pos.Y) - Vector2.new(mouse.X, mouse.Y)).magnitude
                if magnitude < sdis and magnitude <= fov then
                    plr = v
                    sdis = magnitude
                end
            end
        end
    end  
    return plr
end

rs.Stepped:Connect(function()
    if collection.noClip and lp.Character then
		for _, v in pairs(lp.Character:GetDescendants()) do
			if v:IsA("BasePart") and v.CanCollide == true then
				v.CanCollide = false
			end
		end
    end
end)

return collection
