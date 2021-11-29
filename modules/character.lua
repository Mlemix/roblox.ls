local rs = game:GetService('RunService')
local plrs = game:GetService("Players")
local lp = plrs.LocalPlayer

local collection = {
    noClip = false,
}

collection.tweenTP = function(to, t, back, callback)
        if collection.noClip then sbnc = true end
        local hrp = lp.Character.HumanoidRootPart
        local op = CFrame.new(hrp.Position)
        
        collection.noClip = true
        
        game:GetService("TweenService"):Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = to}):Play()
        wait(t + 0.1)
        if callback then callback() end
        if back then game:GetService("TweenService"):Create(hrp, TweenInfo.new(t, Enum.EasingStyle.Linear), {CFrame = op}):Play() end
        if not sbnc then collection.noClip = false end
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
