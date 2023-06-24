
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
import plotly.express as px
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

opts, args = getopt.getopt(sys.argv[1:],"t:s:z:f:d:o:p:c:",["tp=","sl=","z","fr=","dy=","ol=","p","ch=","plot"])
for i in opts:  
    if i[0]+i[1] == "-plot": 
        ar.plot = True
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







def algo(past_data,frame_to_move_on,point):
    global founded_value
    m = mean(past_data)
    for i in frame_to_move_on:
        if m < i:
            founded_value = i
            return frame_to_move_on.index(i),"sell"
    return 0,None


# it replace every x mins data 
def frame_data_buy(past_data,frame_to_move_on,index):
    global data_frame_edit 
    global profit,lost
    global founded_value
    symbol = ticker_names[index] 
    point=mt5.symbol_info(symbol).point
    data_frame_edit[index] = data_frame_edit[index][len(past_data):]+past_data
    start_point,state = algo(data_frame_edit[index],frame_to_move_on,point)
    if  founded_value != 0:
        for z in frame_to_move_on[start_point:]:
            if state == "sell" and z < founded_value-point*ar.tp:
                profit += 1
            elif state == "sell" and z > founded_value+point*ar.sl:
                lost += 1 
            elif state == "buy" and z > founded_value+point*ar.tp:
                profit += 1
            elif state == "buy" and z < founded_value-point*ar.sl:
                lost += 1


def start_loop(i):
    data_time_last=data_time[i][0]
    past_data = []
    program_starts = time.time()
    for t in data_time[i]:
        if  data_time_last + ar.overlap < t:
            if past_data != []:
                frame_data_buy(past_data,data_buy[i][data_time[i].index(data_time_last):data_time[i].index(t)],i)
            past_data = data_buy[i][data_time[i].index(data_time_last):data_time[i].index(t)]
            data_time_last = t
    print("It has been {0} seconds since the loop started".format(time.time() - program_starts))
    global profit,lost,founded_value
    lost = 0
    profit = 0
    founded_value = 0

def algo_stoch(rate_frame,point):
    spread = rate_frame["spread"].copy(order='C')
    if spread[-1] > 10:
            return 
    time = rate_frame["time"].copy(order='C')
    open = rate_frame["open"].copy(order='C')
    close = rate_frame["close"].copy(order='C')
    high = rate_frame["high"].copy(order='C')
    low = rate_frame["low"].copy(order='C')
    k,y = ti.stoch(high,low,close,st.k_period,st.k_slowing_period,st.d_period)
    var = ti.var(open, len(rate_frame)-3)
    if k > 80 and y > k and var[-1] < 0.00001 :
        take_profit = close[-1]-point*float(ar.tp)
        stop_lose = close[-1]+point*float(ar.sl)
        tr = trade(time[-1],open[-1],close[-1],high[-1],low[-1],spread[-1],"sell",take_profit,stop_lose) 
        return tr
    if  k < 20 and y < k and var[-1] > 0.00001  :
        take_profit = close[-1]+point*float(ar.tp)
        stop_lose = close[-1]-point*float(ar.sl)
        tr = trade(time[-1],open[-1],close[-1],high[-1],low[-1],spread[-1],"buy",take_profit,stop_lose) 
        return tr
   
profit = 0 
profit_trades = 0
lose_trades = 0

class to_plot():
    def __init__(self,start_time, start_value, end_time, end_value,  state):
        self.start_time = start_time
        self.start_value = start_value
        self.end_time = end_time
        self.end_value = end_value
        self.state = state


def calc_profit(rate_frame,point,symbol):
    sells = 0 
    buys = 0
    profit_trades_local = 0
    lose_trades_local = 0 
    global profit, profit_trades, lose_trades
    plot_vals = []
    starting_trades = [] 
    low = rate_frame["low"].copy(order='C')
    high = rate_frame["high"].copy(order='C')
    try: 
        q,q = ti.stoch(high,high,high,st.k_period,st.k_slowing_period,st.d_period) # used for calculace len of ignoring periods
    except:
        return
    len_to_slice = len(high)-len(q)+1
    for i in range(len(high)-len_to_slice):
        trade= algo_stoch(rate_frame[0+i:len_to_slice+i],point)
        for tr,q in zip(starting_trades,range(len(starting_trades))):
            if tr.state == "sell":
                if tr.take_profit > low[i+len_to_slice]:
                    sells+=1
                    profit_trades_local+=1
                    profit_trades+=1
                    profit += (tr.low - tr.take_profit)/point
                    profit -=  tr.spread 
                    tp=to_plot(tr.time,tr.close,rate_frame["time"][i+len_to_slice],rate_frame["low"][i+len_to_slice],"sell")
                    starting_trades.pop(q)
                    plot_vals.append(tp)
                    continue
                if tr.stop_lose < high[i+len_to_slice]:
                    sells+=1
                    lose_trades_local+=1
                    lose_trades+=1
                    profit -= (tr.stop_lose - tr.high)/point
                    profit -=  tr.spread
                    tp=to_plot(tr.time,tr.close,rate_frame["time"][i+len_to_slice],rate_frame["low"][i+len_to_slice],"sell")
                    starting_trades.pop(q)
                    plot_vals.append(tp)
                    continue
            if tr.state == "buy":
                if tr.take_profit < high[i+len_to_slice]:
                    buys+=1
                    profit_trades_local+=1
                    profit_trades+=1
                    profit += (tr.take_profit - tr.high)/point
                    profit -=  tr.spread
                    tp=to_plot(tr.time,tr.close,rate_frame["time"][i+len_to_slice],rate_frame["high"][i+len_to_slice],"buy")
                    starting_trades.pop(q)
                    plot_vals.append(tp)
                    continue
                if tr.stop_lose > low[i+len_to_slice]:
                    buys+=1
                    lose_trades_local+=1
                    lose_trades+=1
                    profit -= (tr.low - tr.stop_lose)/point
                    profit -=  tr.spread 
                    tp=to_plot(tr.time,tr.close,rate_frame["time"][i+len_to_slice],rate_frame["high"][i+len_to_slice],"buy")
                    starting_trades.pop(q)
                    plot_vals.append(tp)
                    continue

        if trade != None:
            starting_trades.append(trade)
    if ar.plot == True:
        time_to_show = [datetime.fromtimestamp(t) for t in rate_frame["time"]]
        fig = make_subplots(rows=2, cols=2,
                        specs=[[{"secondary_y": True}, {"secondary_y": True}],
                            [{"secondary_y": True}, {"secondary_y": True}]])

        fig.add_trace(go.Candlestick(x=time_to_show,
                    open=rate_frame["open"],
                    high=rate_frame["high"],
                    low=rate_frame["low"],
                    close=rate_frame["close"]),
                    row=1, col=2, secondary_y=False,
                    )
        for i in plot_vals:
            fig.add_trace(
            go.Scatter(x=[datetime.fromtimestamp(i.start_time),datetime.fromtimestamp(i.end_time)], y=[i.start_value,i.end_value], name=i.state),
            row=1, col=2, secondary_y=False,
            )
        fig.update_layout(
        width=1920,
        height=1080,
        margin=dict(l=20, r=20, t=20, b=20),
        title=symbol,
        xaxis_title="X Axis Title",
        yaxis_title="Y Axis Title",
        legend_title="Legend Title",
        font=dict(
            family="Courier New, monospace",
            size=18,
            color="RebeccaPurple"
        )
        )
        fig.show()
        print("profit:",profit,"profit_trades:",profit_trades_local,"lose_trades:",lose_trades_local,"buys:",buys,"sells:",sells,symbol)

    
    #print(profit,profit_trades,lose_trades)
    #exit()

   




def fill_data():
    global data_frame_edit
    now = datetime.now()
    timezone = pytz.timezone("Etc/UTC")
    # create 'datetime' objects in UTC time zone to avoid the implementation of a local time zone offset
    days=ar.to ## how many days before we want to look
    
    utc_to = datetime(now.year, now.month, now.day+1, now.hour, now.minute, tzinfo=timezone)



    utc_from = utc_to - timedelta(days=ar.to)
    if ar.fr != -1:
        utc_to = utc_to - timedelta(days=ar.fr)

    for i in range(0,len(ticker_names)):
        if ticker_names[i] == "":
            ticker_names.pop(i)
            break

    rates_frame=[]
    
    for i in ticker_names:
        rates= mt5.copy_rates_range(i,mt5.TIMEFRAME_M5,utc_from,utc_to)
        point=mt5.symbol_info(i).point
    
        calc_profit(rates,point,i)
        #rates_frame.append( pd.DataFrame(rates))
        #rates_frame[-1]['time']=pd.to_datetime(rates_frame[-1]['time'], unit='s')
    
    #print(len(rates)*len(ticker_names))





    return
    # fill data_sell and buy
    for i in range(0,len(ticker_names)):
        data_buy.append([])
        data_sell.append([])
        data_time.append([])
        data_frame_edit.append([])
        ticks.append(mt5.copy_ticks_range(ticker_names[i], utc_from, utc_to, mt5.COPY_TICKS_ALL))
       
        # this section removing some values for better manupilation 
        ticks_frame.append(pd.DataFrame(ticks[i]))
        ticks_frame[i].drop_duplicates(subset ="time",keep = False, inplace = True)  #removing duplicates in one second for faster manupilation 
        last_time_value= 0
        try:
            last_time_value_for_frame = ticks_frame[i]['time'][0]
        except:
            print(ticker_names[i],"ERROR")
        for q in ticks_frame[i].index:
            if last_time_value+10 < ticks_frame[i]['time'][q]:
                data_buy[i].append(ticks_frame[i]['ask'][q])
                data_sell[i].append(ticks_frame[i]['bid'][q])
                data_time[i].append(ticks_frame[i]['time'][q])
                last_time_value = ticks_frame[i]['time'][q]
            if last_time_value_for_frame+ar.size_frame > ticks_frame[i]['time'][q]:
                data_frame_edit[i].append(ticks_frame[i]['ask'][q])
            else:
                last_time_value_for_frame = -1
        if ar.sl_tp_zip == True:
            for sl, tp in zip(ar.sl_list,ar.tp_list): 
                ar.sl = sl
                ar.tp = tp 
                start_loop(i)
        if ar.sl_tp_zip == False:
            for tp in ar.tp_list:
                for sl in ar.sl_list: 
                    ar.sl = sl
                    ar.tp = tp 
                    start_loop(i)


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
    fill_data()






test_suite_main()

print(profit,str(profit_trades/(profit_trades+lose_trades)*100)[:-12]+"%",profit_trades+lose_trades )