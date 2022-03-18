import numpy as np
import tulipy as ti
from backtesting import Backtest, Strategy
from backtesting.lib import crossover

from backtesting.test import SMA, GOOG





high = np.array([81.59, 81.06, 82.87,81.59, 81.06, 82.87, 83,    83.61,
                 83.15, 82.84, 83.99, 84.55, 84.36,
                 85.53, 86.54, 86.89, 87.77,81.59, 81.06, 82.87,81.59, 81.06, 82.87, 83,    83.61,
                 83.15, 82.84, 83.99, 84.55, 84.36,
                 85.53, 86.54, 86.89, 87.77, 87.29])
low = np.array([81.59, 81.06, 82.87,81.59, 81.06, 82.87, 83,    83.61,
                 83.15, 82.84, 83.99, 84.55, 84.36,
                 85.53, 86.54, 86.89, 87.77,81.59, 81.06, 82.87,81.59, 81.06, 82.87, 83,    83.61,
                 83.15, 82.84, 83.99, 84.55, 84.36,
                 85.53, 86.54, 86.89, 87.77, 87.29])
close = np.array([81.59, 81.06, 82.87,81.59, 81.06, 82.87, 83,    83.61,
                 83.15, 82.84, 83.99, 84.55, 84.36,
                 85.53, 86.54, 86.89, 87.77,81.59, 81.06, 82.87,81.59, 81.06, 82.87, 83,    83.61,
                 83.15, 82.84, 83.99, 84.55, 84.36,
                 85.53, 86.54, 86.89, 87.77, 87.29])

def print_info(indicator):
    print("Type:", indicator.type)
    print("Full Name:", indicator.full_name)
    print("Inputs:", indicator.inputs)
    print("Options:", indicator.options)
    print("Outputs:", indicator.outputs)


k,y = ti.stoch(high,low,close,4,4,4)
print(len(k),len(high))