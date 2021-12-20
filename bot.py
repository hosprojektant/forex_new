import os
import time
import tkinter as tk
from datetime import date, datetime
from logging import NullHandler
from statistics import mean
from tkinter import Canvas, messagebox
from tkinter.constants import FALSE, LEFT

import MetaTrader5 as mt5
import pandas as pd
import pytz
from guppy import hpy
from matplotlib.backends.backend_tkagg import (FigureCanvasTkAgg,
                                               NavigationToolbar2Tk)
from matplotlib.figure import Figure
from numpy.lib.function_base import average, median
from pandas.core import frame

import fileworker

data_sell=[]
data_buy=[]
data_time=[]
ticks=[]
ticks_frame=[]
toolbar=0
ticker_names = 0
top =0
text_widget=0
is_pressed=1
lot=1.0

def printSomething(input):
    # if you want the button to disappear:
    # button.destroy() or button.pack_forget()
    label = tk.Label(top, text= input)
    #this creates a new label to the GUI
    label.pack() 


    




def request_error_buy(result,symbol,lot,price,deviation):
    print_text_field("1. order_send(): by {} {} lots at {} with deviation={} points".format(symbol,lot,price,deviation))
    if result.retcode != mt5.TRADE_RETCODE_DONE:
        print_text_field("2. order_send failed, retcode={}".format(result.retcode))
        # request the result as a dictionary and display it element by element
        result_dict=result._asdict()
        for field in result_dict.keys():
            print_text_field("   {}={}".format(field,result_dict[field]))
            # if this is a trading request structure, display it element by element as well
            if field=="request":
                traderequest_dict=result_dict[field]._asdict()
                for tradereq_filed in traderequest_dict:
                    print_text_field("       traderequest: {}={}".format(tradereq_filed,traderequest_dict[tradereq_filed]))

def sent_sell(ticker_name):
    symbol = ticker_name
    symbol_info = mt5.symbol_info(symbol)
    if symbol_info is None:
        print_text_field(symbol, "not found, can not call order_check()")
        mt5.shutdown()
        quit()
    
    # if the symbol is unavailable in MarketWatch, add it
    if not symbol_info.visible:
        print_text_field(symbol+ "is not visible, trying to switch on")
        if not mt5.symbol_select(symbol,True):
            print_text_field("symbol_select({}}) failed, exit"+symbol)
            mt5.shutdown()
            quit()
    
    global lot
    price = mt5.symbol_info_tick(symbol).ask
    spread = mt5.symbol_info(symbol).spread
    deviation=20
    request = {
        "action": mt5.TRADE_ACTION_DEAL,
        "symbol": symbol,
        "volume": lot,
        "tp": mt5.symbol_info_tick(symbol).ask-price*0.0005,
        "sl": mt5.symbol_info_tick(symbol).ask+price*0.0005,
        "type": mt5.ORDER_TYPE_SELL,
        "price": price,
        "comment": "sell",
        "type_time": mt5.ORDER_TIME_GTC,
        
    }
    if spread < 30:
        result = mt5.order_send(request)
        print_text_field(result)
        request_error_buy(result,symbol,lot,price,deviation)
        print_text_field(symbol)
        fileworker.rewrite_info_bot(ticker_name,str(int(time.time())))
    else:
        print_text_field("spread is higher than 30 for "+ symbol)


def sent_buy(ticker_name):
    print_text_field(ticker_name)
     # add time stamp info file cuz we 
    symbol = ticker_name
    symbol_info = mt5.symbol_info(symbol)
    if symbol_info is None:
        print_text_field(symbol+ "not found, can not call order_check()")
        mt5.shutdown()
        quit()
    
    # if the symbol is unavailable in MarketWatch, add it
    if not symbol_info.visible:
        print_text_field(symbol+ "is not visible, trying to switch on")
        if not mt5.symbol_select(symbol,True):
            print_text_field("symbol_select({}}) failed, exit"+symbol)
            mt5.shutdown()
            quit()
    
    global lot
    price = mt5.symbol_info_tick(symbol).ask
    spread = mt5.symbol_info(symbol).spread
    deviation=20
    request = {
        "action": mt5.TRADE_ACTION_DEAL,
        "symbol": symbol,
        "volume": lot,
        "tp": mt5.symbol_info_tick(symbol).ask+price*0.0005,
        "sl": mt5.symbol_info_tick(symbol).ask-price*0.0005,
        "type": mt5.ORDER_TYPE_BUY,
        "price": price,
        "comment": "buy",
        "type_time": mt5.ORDER_TIME_GTC,
        
    }

    if spread < 30:
        result = mt5.order_send(request)
        print_text_field(result)
        request_error_buy(result,symbol,lot,price,deviation)
        print_text_field(symbol)
        fileworker.rewrite_info_bot(ticker_name,str(int(time.time())))
    else:
        print_text_field("spread is higher than 30 for "+ symbol)





def frame_algo(tmp_buy,tmp_time,ticker_name,line):
    frame_buy=[]
    frame_buy_info=[]
    frame_time=[]
    cnt_buy =0
    cnt_sell = 0
    len_of_frame=4
    every_x_remove=int(len(tmp_buy)*0.0004) # vyrovnává počet prvků v jednotlivých framech cuz metatrader je tam házi docela random 
    size = len(tmp_buy)/len_of_frame
    for q in range(len_of_frame):
        frame_buy.append([])
        frame_buy_info.append([])
        frame_time.append([])
        for i in range(int(size*(q+1)-size),int(size*(q+1)),every_x_remove):
            frame_buy[q].append(tmp_buy[i])
            frame_time[q].append(tmp_time[i])
        frame_buy_info[q].append(median(frame_buy[q])) ## median
        frame_buy_info[q].append(max(frame_buy[q])) ## highest value
        frame_buy_info[q].append(min(frame_buy[q])) ## lowest value
    for q in range(1,len(frame_buy_info)):
        if frame_buy_info[q][0] < frame_buy_info[q-1][0]:
            cnt_buy+=1
            cnt_sell=0
        if frame_buy_info[q][0] > frame_buy_info[q-1][0]:
            cnt_sell+=1
            cnt_buy=0

        if cnt_buy == 3: 
            sent_buy(ticker_name)
        if cnt_sell == 3:
            sent_sell(ticker_name)
    frame_buy.clear()
    frame_buy_info.clear()
    frame_time.clear()
def fill_data():

    now = datetime.now()
    timezone = pytz.timezone("Etc/UTC")
    # create 'datetime' objects in UTC time zone to avoid the implementation of a local time zone offset
    q=1

    # 
    
    utc_from = datetime(now.year, now.month, now.day, now.hour-3, now.minute, tzinfo=timezone) # last 4 hours
    utc_to = datetime(now.year, now.month, now.day+1, now.hour, now.minute, tzinfo=timezone)

    for i in range(0,len(ticker_names)):
        if ticker_names[i] == "":
            ticker_names.pop(i)
            break

    # fill data_sell and buy
    for i in range(0,len(ticker_names)):
        ticks.append(mt5.copy_ticks_range(ticker_names[i], utc_from, utc_to, mt5.COPY_TICKS_ALL))
            # check if we didnt add nothink to list 
        ticks_frame.append(pd.DataFrame(ticks[i]))
    for i in range(0,len(ticker_names)):
        data_buy.append(ticks_frame[i]['ask'])
        data_sell.append(ticks_frame[i]['bid'])
        data_time.append(ticks_frame[i]['time'])
        if fileworker.load_info_bot(ticker_names[i]) != None and fileworker.load_info_bot(ticker_names[i]) !="":
            if int(time.time())-int(fileworker.load_info_bot(ticker_names[i])) > 7200: ##7200 means 2 hours 
                frame_algo(data_sell[i],data_buy[i],ticker_names[i],i)
        else:
            frame_algo(data_sell[i],data_buy[i],ticker_names[i],i)
    data_buy.clear()
    data_sell.clear()
    data_time.clear()
    ticks_frame.clear()
    ticks.clear()
    print(ticks)
    print(ticks_frame)
    h = hpy()
    print(h.heap())
    top.after(5000, start_algo) 


def fill_butons(ticker_name,x_axis_tickers,index_ticker,y_axis_tickers):
    B = tk.Button(top,text =ticker_name)
    B.place(x=x_axis_tickers, y=y_axis_tickers,width=100, height=30)


def fill_butons_start():
    x=0
    x_axis_tickers=100
    y_axis_tickers=5
    for i in ticker_names:
        fill_butons(i,x_axis_tickers,x,y_axis_tickers)
        x_axis_tickers+=100
        if x_axis_tickers > 1500:
            x_axis_tickers=100
            y_axis_tickers+=30
        x+=1


def start_algo():
    if is_pressed == 0:
        fill_data()

def set_is_pressed(input):
    global is_pressed
    is_pressed = input  
    if(input == 0):
        print_text_field("bot started")
        top.after(5000, start_algo) 
    else:
        print_text_field("bot stopped")
    

def lib_main():
  
    
    pd.set_option('display.max_columns', None)  # or 1000
    pd.set_option('display.max_rows', None)  # or 1000
    pd.set_option('display.max_colwidth', None)  # or 199

    # establish connection to MetaTrader 5 terminal
     

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
    global top
    global text_widget
    top = tk.Tk()
    text_widget = tk.Text(top)
    text_widget.place(x=1920/2-750, y=150,width=1500, height=800)
    print_text_field("MetaTrader5 package author: "+mt5.__author__)
    print_text_field("MetaTrader5 package version: "+mt5.__version__)
    if not mt5.initialize():
        print_text_field("initialize() failed, error code ="+mt5.last_error())
        quit()
    top.geometry("1280x720")
    fill_butons_start()
    top.state('zoomed') #full screen 
    B1 = tk.Button(top,text ="Start algo",command = lambda: set_is_pressed(0)  )
    B1.place(x=1920/2-100, y=950,width=100, height=30)
    B2 = tk.Button(top,text ="Stop algo",command =  lambda: set_is_pressed(1))
    B2.place(x=1920/2-200, y=950,width=100, height=30)
    top.after(2000, start_algo) 
    top.mainloop()

def print_text_field(input):
    text_widget.insert('end',str(input)+"\n")
    text_widget.see('end')  
