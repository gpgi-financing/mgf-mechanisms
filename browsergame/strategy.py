

def defaultStrategies():
    strategies = []
    for i in range(12):
        strat = Strategy(.5, .5, 0, [1/6, 1/6, 1/6, 1/6, 1/6, 1/6], [])
        strategies.append(strat)
    return strategies


class Strategy:

    def __init__(self, proportionNonAllocated, proportionDirect, proportionMatching, directSplit, matchingComp):
        self.proportionNonAllocated = proportionNonAllocated
        self.proportionDirect = proportionDirect
        self.proportionMatching = proportionMatching
        self.directSplit = directSplit
        self.matchingComp = matchingComp