import os
import time
import tkinter as tk
from datetime import date, datetime
from logging import NullHandler
from statistics import mean
from tkinter import Canvas, messagebox
from tkinter.constants import FALSE, LEFT
import statistics
import MetaTrader5 as mt5
import pandas as pd
import pytz
from guppy import hpy
from matplotlib.backends.backend_tkagg import (FigureCanvasTkAgg,
                                               NavigationToolbar2Tk)
from matplotlib.figure import Figure
from numpy.lib.function_base import average, median
from pandas.core import frame
import pandas_ta as ta
import file_worker as fileworker
import tradingview_ta
from tradingview_ta import TA_Handler, Interval, Exchange


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
spread_war=0
time_stamp=0
low = []
high = []
high_bool = []
low_bool = []
time_stamp_ticker = []





def printSomething(input):
    # if you want the button to disappear:
    # button.destroy() or button.pack_forget()
    label = tk.Label(top, text= input)
    #this creates a new label to the GUI
    label.pack() 




def trading_view(ticker):
    min =  TA_Handler(
        symbol=ticker,
        exchange="FX_IDC",
        screener="forex",
        interval="1m",
        timeout=None
    )
    hour =  TA_Handler(
        symbol=ticker,
        exchange="FX_IDC",
        screener="forex",
        interval="1h",
        timeout=None
    )




    a= min.get_analysis().__dict__
    ind_min = a.get("moving_averages")
    buy_ind_min = ind_min.get("BUY")
    sell_ind_min = ind_min.get("SELL")
    print_text_field("MINUTE   SELL: "+str(sell_ind_min)+"    BUY: "+ str(buy_ind_min))

    a= hour.get_analysis().__dict__
    ind_hour = a.get("moving_averages")
    buy_ind_hour = ind_hour.get("BUY")
    sell_ind_hour = ind_hour.get("SELL")
    print_text_field("MINUTE   SELL: "+str(sell_ind_hour)+"    BUY: "+ str(buy_ind_hour))

    if buy_ind_min > sell_ind_min*1.3 and buy_ind_hour > sell_ind_hour :
        return 0
    if buy_ind_min *1.3 < sell_ind_min and buy_ind_hour < sell_ind_hour:
        return 1
    return -1
    




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
    point=mt5.symbol_info(symbol).point
    deviation=20
    request = {
        "action": mt5.TRADE_ACTION_DEAL,
        "symbol": symbol,
        "volume": lot,
        "tp": mt5.symbol_info_tick(symbol).ask-point*120.0,
        "sl": mt5.symbol_info_tick(symbol).ask+point*120.0,
        "type": mt5.ORDER_TYPE_SELL,
        "price": price,
        "comment": "sell",
        "type_time": mt5.ORDER_TIME_GTC,
        
    }
    if spread < 30 and trading_view(symbol) == 1:
        if fileworker.load_info_bot(ticker_name) != None and fileworker.load_info_bot(ticker_name) !="":
            if int(time.time())-int(fileworker.load_info_bot(ticker_name)) > 7200: ##7200 means 2 hours 
                result = mt5.order_send(request)
                print_text_field(result)
                request_error_buy(result,symbol,lot,price,deviation)
                print_text_field(symbol)
                fileworker.rewrite_info_bot(ticker_name,str(int(time.time())))
            else:
                print_text_field(ticker_name+" cannot sell cooldown is "+str(7200-int(time.time())+int(fileworker.load_info_bot(ticker_name)))+"s")
        else:
            result = mt5.order_send(request)
            print_text_field(result)
            request_error_buy(result,symbol,lot,price,deviation)
            print_text_field(symbol)
            fileworker.rewrite_info_bot(ticker_name,str(int(time.time())))
    
    #error messages         
    else:
        if spread_war == 0:
            print_text_field("spread is higher than 30 for "+ symbol)
        if trading_view(symbol) != 1:
            print_text_field("indicators not allowing sell "+ symbol)




def sent_buy(ticker_name):
   
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
    point=mt5.symbol_info(symbol).point
    deviation=20
    request = {
        "action": mt5.TRADE_ACTION_DEAL,
        "symbol": symbol,
        "volume": lot,
        "tp": mt5.symbol_info_tick(symbol).ask+point*120.0,
        "sl": mt5.symbol_info_tick(symbol).ask-point*120.0,
        "type": mt5.ORDER_TYPE_BUY,
        "price": price,
        "comment": "buy",
        "type_time": mt5.ORDER_TIME_GTC,
        
    }

    if spread < 30 and trading_view(symbol) == 0:
        if fileworker.load_info_bot(ticker_name) != None and fileworker.load_info_bot(ticker_name) !="":
            if int(time.time())-int(fileworker.load_info_bot(ticker_name)) > 7200: ##7200 means 2 hours 
                result = mt5.order_send(request)
                print_text_field(result)
                request_error_buy(result,symbol,lot,price,deviation)
                print_text_field(symbol)
                fileworker.rewrite_info_bot(ticker_name,str(int(time.time())))
            else:
                print_text_field(ticker_name+" cannot buy cooldown is "+str(7200-int(time.time())+int(fileworker.load_info_bot(ticker_name)))+"s")

        else:
            result = mt5.order_send(request)
            print_text_field(result)
            request_error_buy(result,symbol,lot,price,deviation)
            print_text_field(symbol)
            fileworker.rewrite_info_bot(ticker_name,str(int(time.time())))

    #error messages 
    else:
        if spread_war == 0:
            print_text_field("spread is higher than 30 for "+ symbol)
        if trading_view(symbol) != 0:
            print_text_field("indicators not allowing buy "+ symbol)





def set_spread_warning():
    global spread_war
    if spread_war == 1:
        spread_war = 0
        print_text_field("spread warning is enabled")
    else:
        spread_war = 1 
        print_text_field("spread warning is disabled")

def cykle_action(ticker_name,index):
    if mt5.symbol_info_tick(ticker_name) == None:
        return
    global high
    global low
    time_stamp_act =  int(time.time())
    print(len(high),index,ticker_name)
    print(high[index],"high")
    print(low[index],"low")
    lasttick=mt5.symbol_info_tick(ticker_name)._asdict()
    act_price = 0
    global high_bool
    global low_bool
    for prop in lasttick:
        if prop == "ask":
             act_price = lasttick[prop]
    print(act_price,"act")
    if act_price != 0:
        if act_price > high[index]:
            high_bool[index] =1 
            time_stamp_ticker[index] = time_stamp_act
        if act_price < low[index]: 
            low_bool[index] = 1 
            time_stamp_ticker[index] = time_stamp_act          
        if act_price > low[index] and low_bool[index] == 1 and time_stamp_ticker[index] - time_stamp_act < -120:
            sent_buy(ticker_name)
            low_bool[index] = 0
        if act_price < high[index] and high_bool[index] == 1:
            sent_sell(ticker_name)
            high_bool[index] = 0 


def frame_algo(tmp_buy,ticker_name,line):
    global low
    global high
    global high_bool
    global low_bool
    if len(tmp_buy) < 10:
        print_text_field(ticker_name+" error no data, remove ticker from trading list please metatrader didnt sent data")
        set_is_pressed()
        return
    high.append(statistics.mean(tmp_buy)+statistics.stdev(tmp_buy)*3)
    low.append(statistics.mean(tmp_buy)-statistics.stdev(tmp_buy)*3)
    low_bool.append(0)
    high_bool.append(0)
    time_stamp_ticker.append(0)
    cykle_action(ticker_name,line)
    

def fill_data():

    now = datetime.now()
    timezone = pytz.timezone("Etc/UTC")
    # create 'datetime' objects in UTC time zone to avoid the implementation of a local time zone offset
    q=1

    # 

    utc_from = datetime(now.year, now.month, now.day, now.hour, now.minute, tzinfo=timezone) # last 4 hours
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
        print(ticks)
    for i in range(0,len(ticker_names)):
        data_buy.append(ticks_frame[i]['ask'])
        data_sell.append(ticks_frame[i]['bid'])
        data_time.append(ticks_frame[i]['time'])
        print(len(data_buy[i]),ticker_names[i])

        frame_algo(data_buy[i],ticker_names[i],i)


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
    time_stamp_act = int(time.time())
    global time_stamp
    if is_pressed == 0:
        if time_stamp == 0 or time_stamp_act  - time_stamp > 3600:
            data_buy.clear()
            data_sell.clear()
            data_time.clear()
            ticks_frame.clear()
            ticks.clear()
            high.clear()
            high_bool.clear()
            low_bool.clear()
            low.clear()
            fill_data()

            time_stamp = int(time.time())
        else:
            x=0
            
            for i in ticker_names:
                cykle_action(i,x)
                x+=1
      


    top.after(1000, start_algo) 



def set_is_pressed():
    global is_pressed
    if is_pressed == 0:
        is_pressed = 1 
    else:
        is_pressed = 0 
    if(is_pressed == 0):
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
    ticker_names = list(dict.fromkeys(ticker_names))
    print(ticker_names)
    mt5.login(login,password,server)
    global top
    global text_widget
    top = tk.Tk()
    text_widget = tk.Text(top)
    text_widget.place(x=1920/2-750, y=150,width=1500, height=800)
    print_text_field("MetaTrader5 package author: "+mt5.__author__)
    print_text_field("MetaTrader5 package version: "+mt5.__version__)
    if not mt5.initialize():
        print(mt5.last_error())
        quit()
    top.geometry("1280x720")
    fill_butons_start()
    top.state('zoomed') #full screen 
    B1 = tk.Button(top,text ="Start/Stop",command = lambda: set_is_pressed()  )
    B1.place(x=1920/2-750, y=950,width=100, height=30)
    B3 = tk.Button(top,text ="Spread warning",command = lambda: set_spread_warning())
    B3.place(x=1920/2-650, y=950,width=100, height=30)
    top.after(2000, start_algo) 
    top.mainloop()



def print_text_field(input):
    text_widget.insert('end',str(input)+"\n")
    text_widget.see('end')  
