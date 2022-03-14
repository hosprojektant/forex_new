
from datetime import datetime
from glob import glob
from math import radians
from operator import index
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


class arguments():
    tp: int
    sl: int
    days: int
    overlap: int 
    size_frame: int
    tp_list: list 
    sl_list: list
    sl_tp_zip: bool 

ar = arguments()
ar.tp, ar.sl, ar.days, ar.overlap, ar.size_frame, ar.tp_list, ar.sl_list, ar.sl_tp_zip = 70.0, 70.0, 1, 1800, 10800, [], [], True
opts, args = getopt.getopt(sys.argv[1:],"t:s:z:f:d:o:",["tp=","sl=","z","fr=","dy=","ol="])
for i in opts:  
    if i[0] == "-o":
        ar.overlap = int(i[1][2:])
    if i[0] == "-z":
        ar.sl_tp_zip = False
    if i[0] == "-f":
        ar.size_frame = int(i[1][2:])
    if i[0] == "-d":
        ar.days = int(i[1][2:])
    if i[0] == "-t":
        if ":" in i[1]:
            q=i[1][2:].split(":")
            for y in range(int(q[0]),int(q[1])+1,int(q[2])):
                ar.tp_list.append(y)
        else:
            ar.tp=y[1][2:]
    if i[0] == "-s":
        if ":" in i[1]:
            q=i[1][2:].split(":")
            for i in range(int(q[0]),int(q[1])+1,int(q[2])):
                ar.sl_list.append(i)
        else:
            ar.sl=i[1][2:]




print(ar.tp_list)
print(ar.sl_list)




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





def fill_data():
    global data_frame_edit
    now = datetime.now()
    timezone = pytz.timezone("Etc/UTC")
    # create 'datetime' objects in UTC time zone to avoid the implementation of a local time zone offset
    days=ar.days ## how many days before we want to look
    
    if now.month == 1:
        x = (date(now.year-1, 12, 1) - date(now.year, now.month, 1)).days
    else:
        x = (date(now.year, now.month, 1) - date(now.year, now.month-1, 1)).days
    if days >= now.day:
        utc_from = datetime(now.year, now.month-1, now.day-days+x, now.hour, now.minute, tzinfo=timezone)
    else:
        utc_from = datetime(now.year, now.month, now.day-days, now.hour, now.minute, tzinfo=timezone)
    
    utc_to = datetime(now.year, now.month, now.day+1, now.hour, now.minute, tzinfo=timezone)

    for i in range(0,len(ticker_names)):
        if ticker_names[i] == "":
            ticker_names.pop(i)
            break
    print(ticker_names)
    print(utc_from)
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
