
from datetime import datetime
from re import S
from symtable import Symbol
from tkinter.constants import FALSE, LEFT
import MetaTrader5 as mt5
import time
from numpy.lib.function_base import average, median
import statistics
from pandas.core import frame
import pytz
import pandas as pd
import tkinter as tk
import matplotlib.pyplot as plt
from datetime import date
from statistics import mean
from tkinter import Canvas, messagebox
from matplotlib.figure import Figure
from matplotlib.backends.backend_tkagg import (FigureCanvasTkAgg, 
NavigationToolbar2Tk)
import file_worker as fw
import numpy as np
from statsmodels.tsa.seasonal import seasonal_decompose
import getopt
import sys
import tulipy as ti
import plotly.graph_objects as go
from plotly.subplots import make_subplots
from datetime import timedelta, date



data_sell=[]
data_buy=[]
data_frame_edit=[]
founded_value =  0
data_time=[]
data_time_new=[]
ticks=[]
ticks_frame=[]
data_profit=[]
ticker_names = 0
rates = []
profit,lost = 0,0

class trade():
    def __init__(self, time, open, close,  high, low, spread, state, take_profit, stop_lose):
        self.time = time
        self.open = open
        self.close = close
        self.high = high
        self.low = low 
        self.spread = spread 
        self.state = state 
        self.take_profit = take_profit
        self.stop_lose = stop_lose

class stoch_params():
    k_period: int 
    k_slowing_period: int 
    d_period: int 

class arguments():
    tp: int
    sl: int
    fr: int
    to: int
    overlap: int 
    size_frame: int
    tp_list: list 
    sl_list: list
    sl_tp_zip: bool 
    plot: bool


ar = arguments()
ar.tp, ar.sl, ar.to, ar.overlap, ar.size_frame, ar.tp_list, ar.sl_list, ar.sl_tp_zip = 70.0, 70.0, 1, 1800, 10800, [], [], True
ar.plot = False
st = stoch_params()
st.k_period,st.k_slowing_period,st.d_period = 10,30,5
ar.fr = -1

opts, args = getopt.getopt(sys.argv[1:],"t:s:z:f:d:o:p:c:",["tp=","sl=","z","fr=","dy=","ol=","p","ch="])
for i in opts:  
    if i[0] == "-c":
        q=i[1][2:].split(":")
        st.k_period = int(q[0])
        st.k_slowing_period = int(q[1])
        st.d_period = int(q[2])
    if i[0] == "z":
        ar.plot = True
    if i[0] == "-o":
        ar.overlap = int(i[1][2:])
    if i[0] == "-z":
        ar.sl_tp_zip = False
    if i[0] == "-f":
        ar.size_frame = int(i[1][2:])
    if i[0] == "-d":
        if ":" in i[1]:
            q=i[1][2:].split(":")
            ar.fr = int(q[0])
            ar.to = int(q[1])
        else:
            ar.to = int(i[1][2:])
    if i[0] == "-t":
        if ":" in i[1]:
            q=i[1][2:].split(":")
            for y in range(int(q[0]),int(q[1])+1,int(q[2])):
                ar.tp_list.append(y)
        else:
            ar.tp=i[1][2:]
    if i[0] == "-s":
        if ":" in i[1]:
            q=i[1][2:].split(":")
            for i in range(int(q[0]),int(q[1])+1,int(q[2])):
                ar.sl_list.append(i)
        else:
            ar.sl=i[1][2:]

lot = 1.0
def request_error_buy(result,symbol,lot,price):
    print("1. order_send(): by {} {} lots at {}  points".format(symbol,lot,price))
    if result.retcode != mt5.TRADE_RETCODE_DONE:
        print("2. order_send failed, retcode={}".format(result.retcode))
        # request the result as a dictionary and display it element by element
        result_dict=result._asdict()
        for field in result_dict.keys():
            print("   {}={}".format(field,result_dict[field]))
            # if this is a trading request structure, display it element by element as well
            if field=="request":
                traderequest_dict=result_dict[field]._asdict()
                for tradereq_filed in traderequest_dict:
                    print("       traderequest: {}={}".format(tradereq_filed,traderequest_dict[tradereq_filed]))





def sent_sell(ticker_name):
    symbol = ticker_name
    symbol_info = mt5.symbol_info(symbol)
    if symbol_info is None:
        mt5.shutdown()
        quit()
    
    # if the symbol is unavailable in MarketWatch, add it
    if not symbol_info.visible:
        if not mt5.symbol_select(symbol,True):
            mt5.shutdown()
            quit()
    
    global lot
    price = mt5.symbol_info_tick(symbol).ask
    point=mt5.symbol_info(symbol).point
    request = {
        "action": mt5.TRADE_ACTION_DEAL,
        "symbol": symbol,
        "volume": lot,
        "tp": mt5.symbol_info_tick(symbol).ask-point*300.0,
        "sl": mt5.symbol_info_tick(symbol).ask+point*300.0,
        "type": mt5.ORDER_TYPE_SELL,
        "price": price,
        "comment": "sell",
        "type_time": mt5.ORDER_TIME_GTC,
        
    }
    if fw.load_info_bot(ticker_name) != None and fw.load_info_bot(ticker_name) !="":
 
        result = mt5.order_send(request)
        print(result)
        request_error_buy(result,symbol,lot,price)
        print(symbol)
        fw.rewrite_info_bot(ticker_name,str(int(time.time())))


    else:
        result = mt5.order_send(request)
        print(request)
        print(result,symbol)
        request_error_buy(result,symbol,lot,price)
        print(symbol)
        fw.rewrite_info_bot(ticker_name,str(int(time.time())))




def sent_buy(ticker_name):
   
     # add time stamp info file cuz we 
    symbol = ticker_name
    symbol_info = mt5.symbol_info(symbol)
    if symbol_info is None:
        mt5.shutdown()
        quit()
    
    # if the symbol is unavailable in MarketWatch, add it
    if not symbol_info.visible:
        if not mt5.symbol_select(symbol,True):
            mt5.shutdown()
            quit()
    
    global lot
    price = mt5.symbol_info_tick(symbol).ask
    point=mt5.symbol_info(symbol).point
    request = {
        "action": mt5.TRADE_ACTION_DEAL,
        "symbol": symbol,
        "volume": lot,
        "tp": mt5.symbol_info_tick(symbol).ask+point*300.0,
        "sl": mt5.symbol_info_tick(symbol).ask-point*300.0,
        "type": mt5.ORDER_TYPE_BUY,
        "price": price,
        "comment": "buy",
        "type_time": mt5.ORDER_TIME_GTC,
        
    }
    if fw.load_info_bot(ticker_name) != None and fw.load_info_bot(ticker_name) !="":
        if int(time.time())-int(fw.load_info_bot(ticker_name)) > 7200: ##7200 means 2 hours 
            result = mt5.order_send(request)
            print(result)
            request_error_buy(result,symbol,lot,price)
            print(symbol)
            fw.rewrite_info_bot(ticker_name,str(int(time.time())))
        else:
            print(ticker_name+" cannot buy cooldown is "+str(7200-int(time.time())+int(fw.load_info_bot(ticker_name)))+"s")
    else:
        result = mt5.order_send(request)
        print(result)
        request_error_buy(result,symbol,lot,price)
        print(symbol)
        fw.rewrite_info_bot(ticker_name,str(int(time.time())))









def algo_stoch(rate_frame,point,symbol):
    spread = mt5.symbol_info(symbol).spread
    if spread > 10:
            return 
    open = rate_frame["open"].copy(order='C')
    close = rate_frame["close"].copy(order='C')
    high = rate_frame["high"].copy(order='C')
    low = rate_frame["low"].copy(order='C')
    k,y = ti.stoch(high,low,close,st.k_period,st.k_slowing_period,st.d_period)
    var = ti.var(open, len(rate_frame)-3)
    try:
        k = k[-1]
        y = y[-1]
    except:
        pass
    if k > 75 and y > k and var[-1] < 0.001 :
        sent_sell(symbol)
        return 
    if  k < 15 and y < k and var[-1] > 0.001 :
        sent_buy(symbol)
        return




   




def fill_data():
    global data_frame_edit
    now = datetime.now()
    timezone = pytz.timezone("Etc/UTC")
    # create 'datetime' objects in UTC time zone to avoid the implementation of a local time zone offset
    days=ar.to ## how many days before we want to look
    
    utc_to = datetime(now.year, now.month, now.day+1, now.hour, now.minute, tzinfo=timezone)
    utc_from = now - timedelta(145/(60*24)) 

  

    for i in range(0,len(ticker_names)):
        if ticker_names[i] == "":
            ticker_names.pop(i)
            break
    
    rates_frame=[]
    
    for i in ticker_names:
        rates= mt5.copy_rates_range(i,mt5.TIMEFRAME_M5,utc_from,utc_to)
        point=mt5.symbol_info(i).point
        algo_stoch(rates,point,i)

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
    login=fw.load_setings("login")
    global password
    password=fw.load_setings("password")
    global server
    server=fw.load_setings("server")
    global ticker_names
    ticker_names=fw.load_setings("ticker_names")
    mt5.login(login,password,server)
    while 1:
        time.sleep(300)
        fill_data()






test_suite_main()

