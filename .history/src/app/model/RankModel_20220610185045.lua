local RankModel = class("RankModel")

function RankModel:ctor(rank, nickname, score)
    self.rank = rank
    self.nickname = nickname
    self.score = score
end

function RankModel:data2Json()
    local rankModel = {
        rank = self.rank
        nickname = self.nickname,
        score = self.score
    }
    return rankModel
end

function RankModel:json2Data(rankModel)
    self.nickname = rankModel.nickname
    self.score = rankModel.score
end

return RankModel
