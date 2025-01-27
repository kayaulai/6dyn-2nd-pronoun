


plot(hypothesis(model, c("muQing_PowerEqual - muQing_PowerListener = 0", "muQing_PowerSpeaker - muQing_PowerListener = 0", "muQing_IntimateY - muQing_IntimateN = 0")))
plot(hypothesis(model, "muQing_PowerSpeaker - muQing_PowerListener = 0"))
plot(hypothesis(model, "muQing_IntimateY - muQing_IntimateN = 0"))

hypothesis(model, c("muQing_StanceSPos = 0", "muQing_StanceHPos + muQing_PowerEqual:StanceHPos = 0", "muQing_StanceHPos + muQing_PowerSpeaker:StanceHPos = 0", "muQing_StanceHNeg + muQing_PowerEqual:StanceHNeg = 0", "muQing_StanceHNeg + muQing_PowerSpeaker:StanceHNeg = 0"))

hypothesis(model, c("muQing_StanceSPos = 0"))
plot(hypothesis(model, "muQing_StanceHPos + muQing_PowerEqual:StanceHPos + muQing_IntimateN:StanceHPos = 0"))
plot(hypothesis(model, "muQing_StanceHPos + muQing_PowerEqual:StanceHPos + muQing_IntimateY:StanceHPos = 0"))
plot(hypothesis(model, "muQing_StanceHPos + muQing_PowerSpeaker:StanceHPos + muQing_IntimateN:StanceHPos = 0"))
plot(hypothesis(model, "muQing_StanceHPos + muQing_PowerSpeaker:StanceHPos + muQing_IntimateY:StanceHPos = 0"))

plot(hypothesis(model, "muQing_StanceHNeg + muQing_PowerEqual:StanceHNeg + muQing_IntimateN:StanceHNeg = 0"))
plot(hypothesis(model, "muQing_StanceHNeg + muQing_PowerEqual:StanceHNeg + muQing_IntimateY:StanceHNeg = 0"))
plot(hypothesis(model, "muQing_StanceHNeg + muQing_PowerSpeaker:StanceHNeg + muQing_IntimateN:StanceHNeg = 0"))
plot(hypothesis(model, "muQing_StanceHNeg + muQing_PowerSpeaker:StanceHNeg + muQing_IntimateY:StanceHNeg = 0"))
plot_grid(plot_pos, plot_neg, labels = c('Pos', 'Neg'), label_size = 12)

plot(hypothesis(model, "muQing_StanceHNeg + muQing_PowerSpeaker:StanceHNeg + muQing_IntimateY:StanceHNeg = 0"))
plot(hypothesis(model, "muQing_StanceHNeg + muQing_PowerSpeaker:StanceHNeg + muQing_IntimateY:StanceHNeg = 0"))


plot(hypothesis(model, c("muRu_PowerSpeaker - muRu_PowerListener = 0", "muRu_IntimateY - muRu_IntimateN+ muRu_KinYes = 0")))
plot(hypothesis(model, c("muGong_PowerListener - muGong_PowerSpeaker = 0", "muGong_StanceHPos + muGong_PowerListener:StanceHPos = 0")))
plot(hypothesis(model, c("muGong_StanceHPos = 0")))


hypothesis(model, "muQing_PowerListener:StanceHNeg - muQing_PowerEqual:StanceHNeg = 0")
hypothesis(model, "muQing_PowerSpeaker:StanceHNeg - muQing_PowerEqual:StanceHNeg = 0")
hypothesis(model, "muQing_PowerListener:StanceHPos - muQing_PowerEqual:StanceHPos = 0")
hypothesis(model, "muQing_PowerSpeaker:StanceHPos - muQing_PowerEqual:StanceHPos = 0")
