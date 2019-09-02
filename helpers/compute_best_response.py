
import numpy as np


nbOfGpgis = 6

current_strategy_profile = np.array([
  [1.0000, 2.0400, 1.0000, -1.0000, 2.0200, -1.0000, 1.0000, 4.1000, -1.0000, -1.0000, 1.0000, 2.1000],
  [1.0000, 1.0000, 1.0000, 1.0000,  .0000,  1.0000,  1.0000, 1.0000, 1.0000,  1.0000,  1.0000, 1.0000],
  [1.0000, 1.0000, 0.2000, 0,       1.0000, 0,       1.0000, 1.0000, 0,       0,       0.8000, 0.2000]
])

player = 2
c1 = 2
c2 = 1
C3 = 1

np.array([
  [1.0000, 2.0000, 1.0000, -1.0000, 2.0200, -1.0000, 1.0000, 4.1000, -1.0000, -1.0000, 1.0000, 2.1000],
  [1.0000, 1.0000, 1.0000, 1.0000,  .0000,  1.0000,  1.0000, 1.0000, 1.0000,  1.0000,  1.0000, 1.0000],
  [1.0000, 1.0000, 0.2000, 0,       1.0000, 0,       1.0000, 1.0000, 0,       0,       0.8000, 0.2000]
])


tax_revenues = np.array(12 * [1/12])


print(current_strategy_profile)
currentPlayer = 1

def compute_best_response():

  return null


def get_row1_strategy_type():
  pmf_discretisation = 10
  row = [-1, 0, 1]

  for i in range(2, nbOfGpgis - 1):
    for j in range (1, pmf_discretisation):
      row += [i + 0.1 * j / pmf_discretisation]

  return row

def get_row2_strategy_type():
  gpgi_discretisation = 10
  row = []

  for i in range (0, gpgi_discretisation + 1):
    row += [i / gpgi_discretisation]

  return row

def get_row3_strategy_type():
  allocation_discretisation = 10
  row = []

  for i in range (0, allocation_discretisation + 1):
    row += [i / allocation_discretisation]

  return row


def get_total_free_funds(strategy_profile):
    


def get_final_allocation(strategy_profile):
  total_free_funds = get_total_free_funds(strategy_profile) 


def get_payoff(new_strategy, player):
  new_strategy_profile = np.copy(current_strategy_profile)
  new_strategy_profile[:, player] = new_strategy

  get_final_allocation(new_strategy_profile)

get_payoff([2, 1, 1], 2)






def compute_best_strategy(player):
  row1_strategy_types = get_row1_strategy_type()
  row2_strategy_types = get_row2_strategy_type()
  row3_strategy_types = get_row3_strategy_type()
  

  print(row1_strategy_types)
  print(row2_strategy_types)
  print(row3_strategy_types)

  # c1_strategy is the first component of the strategy
  for c1_strategy in row1_strategy_types:
    # c2_strategy is the second component of the strategy
    for c2_strategy in row2_strategy_types:
      # c3_strategy is the third component of the strategy
      for c3_strategy in row3_strategy_types:
        
        print([c1_strategy, c2_strategy, c3_strategy])
        get_payoff([c1_strategy, c2_strategy, c3_strategy], player)


  


#compute_best_strategy(2)