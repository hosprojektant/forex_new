
from datetime import datetime
from logging import NullHandler
from tkinter.constants import FALSE, LEFT
import MetaTrader5 as mt5
import time
from numpy.lib.function_base import average, median
import statistics
from pandas.core import frame
import pytz
import pandas as pd
import tkinter as tk
from datetime import date
from statistics import mean
from tkinter import Canvas, messagebox
from matplotlib.figure import Figure
from matplotlib.backends.backend_tkagg import (FigureCanvasTkAgg, 
NavigationToolbar2Tk)
import fileworker
import numpy as np
from statsmodels.tsa.seasonal import seasonal_decompose


data_sell=[]
data_buy=[]
data_time=[]
data_time_new=[]
ticks=[]
ticks_frame=[]
data_profit=[]
ticker_names = 0
rates = []





def fill_data():
    now = datetime.now()
    timezone = pytz.timezone("Etc/UTC")
    # create 'datetime' objects in UTC time zone to avoid the implementation of a local time zone offset
    q=1 ## how many days before we want to look
    
    if now.month == 1:
        x = (date(now.year-1, 12, 1) - date(now.year, now.month, 1)).days
    else:
        x = (date(now.year, now.month, 1) - date(now.year, now.month-1, 1)).days
    if q >= now.day:
        utc_from = datetime(now.year, now.month-1, now.day-q+x, now.hour, now.minute, tzinfo=timezone)
    else:
        utc_from = datetime(now.year, now.month, now.day-q, now.hour, now.minute, tzinfo=timezone)
    
    utc_to = datetime(now.year, now.month, now.day+1, now.hour, now.minute, tzinfo=timezone)

    for i in range(0,len(ticker_names)):
        if ticker_names[i] == "":
            ticker_names.pop(i)
            break
    print(ticker_names)
    print(utc_from)
    # fill data_sell and buy
    for i in range(0,len(ticker_names)):
        
        ticks.append(mt5.copy_ticks_range(ticker_names[i], utc_from, utc_to, mt5.COPY_TICKS_ALL))
       
        ticks_frame.append(pd.DataFrame(ticks[i]))
        ticks_frame[i].drop_duplicates(subset ="time",keep = False, inplace = True)

    for i in range(0,len(ticker_names)):

        data_buy.append(ticks_frame[i]['ask'])
        data_sell.append(ticks_frame[i]['bid'])
        data_time.append(ticks_frame[i]['time'])

        #removing duplicates in one second for faster manupilation 
     





def test_suite_main():
    pd.set_option('display.max_columns', None)  # or 1000
    pd.set_option('display.max_rows', None)  # or 1000
    pd.set_option('display.max_colwidth', None)  # or 199
    # establish connection to MetaTrader 5 terminal
    if not mt5.initialize():
        print("initialize() failed, error code =",mt5.last_error())
        quit()
    # acount and server information    
    global login
    login=fileworker.load_setings("login")
    global password
    password=fileworker.load_setings("password")
    global server
    server=fileworker.load_setings("server")
    global ticker_names
    ticker_names=fileworker.load_setings("ticker_names")
    mt5.login(login,password,server)
    fill_data()






test_suite_main()
print(len(data_buy[0]))
