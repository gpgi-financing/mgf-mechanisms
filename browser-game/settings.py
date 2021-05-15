from .strategy import defaultStrategies
from .fund import Fund


class Settings:

    def __init__(self, resources, defaultStrategies, funds):
        self.resources = resources
        self.defaultStrategies = defaultStrategies
        self.funds = funds

def getDefaultSettings():
    defaultFunds = [Fund("CDM", [0.0676, 0.4818, 0.4179, -0.0188, 0.2986, 0.1195, 0.1250, -0.4446, 0.0785, -0.1825, 0.2440, 0.3130]),
                    Fund("CEPI", [0.0379, 0.2307, 0.3564, 0.0115, 0.0490, 0.0918, 0.1116, 0.0534, 0.1023, 0.0297, 0.3656, 0.0601]),
                    Fund("GFATBM", [0.6800, 0.0200, 0, 0.0300, 0.0500, 0, 0.0400, 0.0500, 0, 0.0100, 0, 0.1200]),
                    Fund("FCPCF", [0.3182, 0.1238, 0.0563, 0.0083, 0.1345, 0.0029, 0.4507, 0.0955, 0.0220, 0.0047, 0.0332, 0.2498]),
                    Fund("ITER", [0.0754, 0.3070, 0.4380, -0.0054, 0.2106, 0.0871, 0.0614, -0.1227, 0.1020, -0.0144, 0.1919, 0.1692]),
                    Fund("CPRF", [0.2382, 0.3197, 0.3097, -0.0298, 0.4442, 0.0973, 0.0668, -0.4783, 0.0387, -0.1734, 0.1624, 0.4045])],
    defaultResources = [.0373, .0531, .3172, .0118, .0278, .0323, .0562, .0939, .0659, .0156, .1366, .1524]
    return Settings(defaultResources, defaultStrategies(), defaultFunds)