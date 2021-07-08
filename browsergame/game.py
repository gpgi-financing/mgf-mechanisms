import random
from flask import Flask

class Game:
    #Start a game
    def __init__(self, uids, name, settings):
        self.players = random.shuffle(uids)
        self.resources = settings.resources
        self.strategies = settings.defaultStrategies
        self.currPlayer = random.choice(uids)
        self.period = 0
        self.payoffs = [0 for p in self.players]
        self.finalRound = settings.finalRound
        self.funds = settings.funds
        self.name = name

    def __init__(self, players, resources, strategies, currPlayer, period, payoffs, finalRound, funds, name):
        self.players = players
        self.resources = resources
        self.strategies = strategies
        self.currPlayer = currPlayer
        self.period = period
        self.payoffs = payoffs
        self.finalRound = finalRound
        self.funds = funds
        self.name = name
    def end(self):
       #TODO: Update players' scores, ranks, and reference scores.
       return None

    def getRoundPayoffs(self):
        payoffs = [0 for p in self.players]
        allocations = [0 for f in self.funds]
        matchingWeights = [0 for p in self.players]
        totalNonAllocated = sum([self.strategies[i].proportionNonAllocated * self.resources[i] for i in range(len(self.strategies))] )
        for i in range(len(self.players)):
            strat = self.strategies[i]
            totalDirectAllocated = strat.proportionDirect * self.resources[i]
            matchingWeights[i] = self.resources[i] * strat.proportionMatching * len(strat.matchingComp)
            for j in range(len(self.funds)):
                allocations[j] += totalDirectAllocated * strat.directSplit[j] + strat.proportionMatching * self.resources[i]/len(strat.matchingComp)
        matchingWeights = [weight/sum(matchingWeights) for weight in matchingWeights]
        for i in range(len(self.players)):
            strat = self.strategies[i]
            for fund in strat.matchingComp:
                fundIndex = self.funds.index(fund)
                allocations[fundIndex] += matchingWeights[i] * totalNonAllocated
        for i in range(self.funds):
            payoffs = [payoffs[j] + self.funds[i].utilities[j] * allocations[i] for j in range(len(self.players))]
        return payoffs




