from datetime import datetime
import MetaTrader5 as mt5
import time
from numpy.lib.function_base import average, median
from pandas.core import frame
import pytz
import pandas as pd
import tkinter as tk
from datetime import date
from statistics import mean
from tkinter import messagebox
from matplotlib.figure import Figure
from matplotlib.backends.backend_tkagg import (FigureCanvasTkAgg, 
NavigationToolbar2Tk)
ticker_names=['AUDCAD',
'AUDJPY',
'AUDNZD',
'AUDCHF',
'AUDUSD',
'GBPAUD',
'GBPCAD',
'GBPJPY'
]
data_sell=[]
data_buy=[]
data_time=[]
ticks=[]
ticks_frame=[]
data_profit=[]


print("MetaTrader5 package author: ",mt5.__author__)
print("MetaTrader5 package version: ",mt5.__version__)
 
pd.set_option('display.max_columns', None)  # or 1000
pd.set_option('display.max_rows', None)  # or 1000
pd.set_option('display.max_colwidth', None)  # or 199

 




# establish connection to MetaTrader 5 terminal
if not mt5.initialize():
    print("initialize() failed, error code =",mt5.last_error())
    quit()

# acount and server information    
login=1090045834
password="ECMUGKT6DZ"
server="FTMO-Server"

mt5.login(login,password,server)




def frame_algo(tmp_buy,index_ticker,big_frame_size,tmp_time,plot1):
    frame_buy=[]
    frame_buy_info=[]
    frame_time=[]
    cnt_buy =0
    cnt_sell = 0
    len_of_frame=100
    size = len(tmp_buy)/len_of_frame
    for q in range(len_of_frame):
        frame_buy.append([])
        frame_buy_info.append([])
        frame_time.append([])
        for i in range(int(size*(q+1)-size),int(size*(q+1))):
            frame_buy[q].append(tmp_buy[i])
            frame_time[q].append(tmp_time[i])
        #frame_buy_info[q].append(mean(frame_buy[q])) ## mean
        frame_buy_info[q].append(median(frame_buy[q])) ## median
        frame_buy_info[q].append(max(frame_buy[q])) ## highest value
        frame_buy_info[q].append(min(frame_buy[q])) ## lowest value
        #frame_buy_info[q].append((frame_buy[q][0])) ## start value
        #frame_buy_info[q].append((frame_buy[q][-1])) ## last value
    for q in range(1,len(frame_buy_info)):
        if frame_buy_info[q][0] < frame_buy_info[q-1][0]:
            cnt_buy+=1
            cnt_sell=0
        if frame_buy_info[q][0] > frame_buy_info[q-1][0]:
            cnt_sell+=1
            cnt_buy=0
            
        if cnt_sell==3 and q+1 < len(frame_buy_info):
            algo_test("sell",q,size,index_ticker,frame_buy[q+1][0],big_frame_size,plot1)
            ##plot1.plot(frame_time[q+1],frame_buy[q+1],color="red")
            
        if cnt_buy==3 and q+1 < len(frame_buy_info):
            algo_test("buy",q,size,index_ticker,frame_buy[q+1][0],big_frame_size,plot1)
            ##plot1.plot(frame_time[q+1],frame_buy[q+1],color="blue")







def algo_test(state,q,size,index_ticker,value,big_frame_size,plot1):
    start = int(size*(q+1))+big_frame_size
    if state == "buy":
        for i in range(start,len(data_buy[index_ticker]),20):
            if value*0.0010+value < data_buy[index_ticker][i]:
                data_profit.append(data_buy[index_ticker][i]-value) ## profit
                plot1.plot((data_time[index_ticker][start:i]-data_time[index_ticker][0])/(3600*24),data_buy[index_ticker][start:i],color="yellow")
                break
            if -value*0.0010+value > data_buy[index_ticker][i]:
                data_profit.append(data_buy[index_ticker][i]-value) ## jsme v mínusu 
                plot1.plot((data_time[index_ticker][start:i]-data_time[index_ticker][0])/(3600*24),data_buy[index_ticker][start:i],color="green")
                break
    if state == "sell":
         for i in range(start,len(data_buy[index_ticker]),20):
            if value*0.0010+value < data_buy[index_ticker][i]:
                data_profit.append(-data_buy[index_ticker][i]+value) ## jsme v mínusu
                #plot1.plot((data_time[index_ticker][start:i]-data_time[index_ticker][0])/(3600*24),data_buy[index_ticker][start:i],color="green")
                break
            if -value*0.0010+value > data_buy[index_ticker][i]:
                data_profit.append(-data_buy[index_ticker][i]+value) ## profit
                #plot1.plot((data_time[index_ticker][start:i]-data_time[index_ticker][0])/(3600*24),data_buy[index_ticker][start:i],color="yellow")
                break



# naplní nám data 
def fill_data():
    now = datetime.now()
    timezone = pytz.timezone("Etc/UTC")
    # create 'datetime' objects in UTC time zone to avoid the implementation of a local time zone offset
    q=30

    # 
    if now.month == 1:
        x = (date(now.year-1, 12, 1) - date(now.year, now.month, 1)).days
    else:
        x = (date(now.year, now.month, 1) - date(now.year, now.month-1, 1)).days
    if q >= now.day:
        utc_from = datetime(now.year, now.month-1, now.day-q+x, now.hour, now.minute, tzinfo=timezone)
    else:
        utc_from = datetime(now.year, now.month, now.day-q, now.hour, now.minute, tzinfo=timezone)
    
    utc_to = datetime(now.year, now.month, now.day+1, now.hour, now.minute, tzinfo=timezone)
    

    # fill data_sell and buy
    for i in range(0,len(ticker_names)):
        ticks.append(mt5.copy_ticks_range(ticker_names[i], utc_from, utc_to, mt5.COPY_TICKS_ALL))
            # check if we didnt add nothink to list 
        ticks_frame.append(pd.DataFrame(ticks[i]))
    for i in range(0,len(ticker_names)):
        data_buy.append(ticks_frame[i]['ask'])
        data_sell.append(ticks_frame[i]['bid'])
        data_time.append(ticks_frame[i]['time'])
    
# vygeneruje graf na ploše
def plot(index_ticker):
    tmp_buy=[]
    tmp_time=[]
    # the figure that will contain the plot
    fig = Figure(figsize = (10, 5),
                 dpi = 150)
  
    # list of squares
  
    # adding the subplot
    plot1 = fig.add_subplot(111)
  
    # plotting the graph
    plot1.plot((data_time[index_ticker][::500]-data_time[index_ticker][0])/(3600*24),data_buy[index_ticker][::500],color="black")
    avarage = min(data_buy[index_ticker][::500])
    lengh_of_state = 6
    first_time = data_time[index_ticker][0]
    size = len(data_buy[index_ticker])/lengh_of_state
    for q in range(0,lengh_of_state):
        for i in range(int((size*(q+1)-size)), int(size*(q+1)),15):
            tmp_buy.append(data_buy[index_ticker][i])
            tmp_time.append(data_time[index_ticker][i])
        
        value_start= tmp_buy[0]
        value_end = tmp_buy[-1]

        frame_algo(tmp_buy,index_ticker,int((size*(q+1)-size)),(tmp_time-first_time)/(3600*24),plot1)


        for i in range(len(tmp_buy)):
            tmp_buy[i]=avarage
       #########################
        
        tmp_buy.clear()
        tmp_time.clear()
    print(sum(data_profit))
    data_profit.clear()
    # creating the Tkinter canvas
    # containing the Matplotlib figure
    canvas = FigureCanvasTkAgg(fig,top)  
    canvas.draw()
    # placing the canvas on the Tkinter window
    canvas.get_tk_widget().place(x=400, y=220)
    
    # creating the Matplotlib toolbar
    toolbar = NavigationToolbar2Tk(canvas,top)
    toolbar.update()
    # placing the toolbar on the Tkinter window





top = tk.Tk()
fill_data()


top.geometry("1280x720")
top.state('zoomed') #full screen 
label_user_name = tk.Label(top, text="User Name")
label_user_name.place(x=5, y=5)
entry_user_name = tk.Entry(top, bd =5)
entry_user_name.place(x=80, y=5)
label_password = tk.Label(top, text="Password")
label_password.place(x=5, y=40)
entry_password = tk.Entry(top, bd =5)
entry_password.place(x=80, y=40)


# přidáme tlačítka na plohu společně s jejich vlastnostmi 
def fill_butons(ticker_name,x_axis_tickers,index_ticker,y_axis_tickers):

    B = tk.Button(text =ticker_name, command = lambda: plot(index_ticker))
    B.place(x=x_axis_tickers, y=y_axis_tickers)


def fill_butons_start():
    x=0
    x_axis_tickers=400
    y_axis_tickers=5
    for i in ticker_names:
        fill_butons(i,x_axis_tickers,x,y_axis_tickers)
        x_axis_tickers+=60
        if x_axis_tickers > 1500:
            x_axis_tickers=400
            y_axis_tickers+=30
        x+=1

fill_butons_start()
top.mainloop()



