local ITEM = FindMetaTable("MPItem")

function ITEM:SetGroupBAdmin(usergroup,user)
    ba.data.SetRank(user, usergroup, usergroup, 0)
end