from datetime import datetime
from logging import NullHandler
from tkinter.constants import FALSE, LEFT
import MetaTrader5 as mt5
import time
from numpy.lib.function_base import average, median
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




data_sell=[]
data_buy=[]
data_time=[]
ticks=[]
ticks_frame=[]
data_profit=[]
ticker_names_settings=[]
profit_cnt = 0
minus_cnt =0
toolbar=0
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
login=fileworker.load_setings("login")
password=fileworker.load_setings("password")
server=fileworker.load_setings("server")
ticker_names=fileworker.load_setings("ticker_names")


mt5.login(login,password,server)









def frame_algo(tmp_buy,index_ticker,tmp_time,plot1):
    frame_buy=[]
    frame_buy_info=[]
    frame_time=[]
    cnt_buy =0
    cnt_sell = 0
    len_of_frame=650
    size = len(tmp_buy)/len_of_frame
    for q in range(len_of_frame):
        frame_buy.append([])
        frame_buy_info.append([])
        frame_time.append([])
        for i in range(int(size*(q+1)-size),int(size*(q+1)),10):
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
            algo_test("sell",q,size,index_ticker,frame_buy[q+1][0],plot1)
            ##plot1.plot(frame_time[q+1],frame_buy[q+1],color="red")
            
        if cnt_buy==3 and q+1 < len(frame_buy_info):
            algo_test("buy",q,size,index_ticker,frame_buy[q+1][0],plot1)
            ##plot1.plot(frame_time[q+1],frame_buy[q+1],color="blue")







def algo_test(state,q,size,index_ticker,value,plot1):
    start = int(size*(q))
    global minus_cnt 
    global profit_cnt
    if state == "buy":
        for i in range(start,len(data_buy[index_ticker]),20):
            if value*0.0005+value < data_buy[index_ticker][i]: ## původní 155 159  160 aktualní
                data_profit.append(data_buy[index_ticker][i]-value) ## profit
                profit_cnt+=1
                plot1.plot((data_time[index_ticker][start:i]-data_time[index_ticker][0])/(3600*24),data_buy[index_ticker][start:i],color="blue")
                break
            if -value*0.0005+value > data_buy[index_ticker][i]: ## 155 původní  150     149 aktualní
                data_profit.append(data_buy[index_ticker][i]-value) ## jsme v mínusu 
                plot1.plot((data_time[index_ticker][start:i]-data_time[index_ticker][0])/(3600*24),data_buy[index_ticker][start:i],color="yellow")
                minus_cnt+=1
                break
    if state == "sell":
         for i in range(start,len(data_buy[index_ticker]),20):
            if value*0.0005+value < data_buy[index_ticker][i]: ## původní 155 159  160 aktualní
                data_profit.append(-data_buy[index_ticker][i]+value) ## jsme v mínusu
                minus_cnt+=1
                plot1.plot((data_time[index_ticker][start:i]-data_time[index_ticker][0])/(3600*24),data_buy[index_ticker][start:i],color="green")
                break
            if -value*0.0005+value > data_buy[index_ticker][i]:  ## 155 původní 150   149 aktualní
                data_profit.append(-data_buy[index_ticker][i]+value) ## profit
                profit_cnt+=1
                plot1.plot((data_time[index_ticker][start:i]-data_time[index_ticker][0])/(3600*24),data_buy[index_ticker][start:i],color="red")
                break



# naplní nám data 
def fill_data():
    now = datetime.now()
    timezone = pytz.timezone("Etc/UTC")
    # create 'datetime' objects in UTC time zone to avoid the implementation of a local time zone offset
    q=40

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

    for i in range(0,len(ticker_names)):
        if ticker_names[i] == "":
            ticker_names.pop(i)
            break
    print(ticker_names)

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
    global toolbar
    if toolbar != 0:
        toolbar.destroy()

    # the figure that will contain the plot
    fig = Figure(figsize = (10, 5),
                 dpi = 150)
  
    # list of squares
  
    # adding the subplot
    plot1 = fig.add_subplot(111)
  
    # plotting the graph
    plot1.plot((data_time[index_ticker][::2]-data_time[index_ticker][0])/(3600*24),data_buy[index_ticker][::2],color="black")
    first_time = data_time[index_ticker][0]

    frame_algo(data_buy[index_ticker],index_ticker,(data_time[index_ticker]-first_time)/(3600*24),plot1)

       #########################

    print(sum(data_profit))
    print(profit_cnt)
    print(minus_cnt)
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


def clear_text(x):
    x.delete(0, 'end')


def account_settings():
     
    # Toplevel object which will
    # be treated as a new window
    settings= tk.Toplevel(top)
    ## section for user server info
    user_input_name = tk.StringVar(settings)
    user_input_password = tk.StringVar(settings)
    user_input_server = tk.StringVar(settings)
    label_user_name = tk.Label(settings, text="User Name")
    label_user_name.place(x=5, y=5)
    entry_user_name = tk.Entry(settings, bd =5,textvariable=user_input_name)
    entry_user_name.place(x=80, y=5)
    label_password = tk.Label(settings, text="Password")
    label_password.place(x=5, y=40)
    entry_password = tk.Entry(settings, bd =5,textvariable=user_input_password)
    entry_password.place(x=80, y=40)
    label_server = tk.Label(settings, text="Server")
    label_server.place(x=5, y=75)
    entry_server = tk.Entry(settings, bd =5,textvariable=user_input_server)
    entry_server.place(x=80, y=75)
    btn = tk.Button(settings,text ="Save",command = lambda: [clear_text(entry_user_name),clear_text(entry_password),clear_text(entry_server),
    fileworker.rewrite_remove(user_input_name.get(),0),fileworker.rewrite_remove(user_input_password.get(),1),fileworker.rewrite_remove(user_input_server.get(),2)])
    global login
    global password
    login=fileworker.load_setings("login")
    password=fileworker.load_setings("password")
    btn.place(x=100, y=110)
    ## end of section for user server info
    
    



    # sets the title of the
    # Toplevel widget
    settings.title("User info")
 
    # sets the geometry of toplevel
    settings.geometry("250x150")


def remove_account_settings(tickers_gui):
    for widget in top.winfo_children():
        widget.destroy()
    tickers_gui.destroy()
    tickers_gui= tk.Toplevel(top)
    tickers_gui.geometry("1280x720")
    tickers_gui.state('zoomed') #full screen 
    update_ticker_settings(tickers_gui)
    fill_data()
    fill_butons_start()
    menu()



def update_ticker_settings(tickers_gui):
  
    ticker_names_settings=fileworker.load_setings("settings_names")

    ## removing items that dont need to be add bs they already are in ticker_names
    for i in ticker_names[:]:
        if i in ticker_names_settings:
            ticker_names_settings.remove(i)

    # adding butons for adding
    x_axis_tickers=20
    y_axis_tickers=50
    print(y_axis_tickers,"Y")
    print(x_axis_tickers,"X")
    for i in ticker_names_settings:
        add_ticker_setings(i,x_axis_tickers,y_axis_tickers,tickers_gui)
        y_axis_tickers+=30
        if y_axis_tickers > 900:
            x_axis_tickers+=100
            y_axis_tickers=50
    # adding butons for removing
    x_axis_tickers=800
    y_axis_tickers=50
    for i in ticker_names:
        if i != "":
            remove_ticker_setings(i,x_axis_tickers,y_axis_tickers,tickers_gui)
            y_axis_tickers+=30
            if y_axis_tickers > 900:
                x_axis_tickers+=100
                y_axis_tickers=50

    B= tk.Button(tickers_gui,text ="Update",command = lambda: remove_account_settings(tickers_gui) )
    B.place(x=450, y=20,width=100, height=30)


def add_ticker_settings_action(ticker_name):
    global ticker_names
    global ticker_names_settings
    fileworker.add_new_ticker(ticker_name)
    ticker_names_settings=fileworker.load_setings("settings_names")
    ticker_names=fileworker.load_setings("ticker_names")

def remove_ticker_settings_action(ticker_name):
    global ticker_names
    global ticker_names_settings
    fileworker.rewrite_remove(ticker_name,3) # 3 for ticker_name
    ticker_names_settings=fileworker.load_setings("settings_names")
    ticker_names=fileworker.load_setings("ticker_names")


def add_ticker_setings(ticker_name,x_axis_tickers,y_axis_tickers,gui):
    B = tk.Button(gui,text =ticker_name, command = lambda: add_ticker_settings_action(ticker_name))
    B.place(x=x_axis_tickers, y=y_axis_tickers, width=100, height=30)

def remove_ticker_setings(ticker_name,x_axis_tickers,y_axis_tickers,gui):
    B = tk.Button(gui,text =ticker_name, command = lambda: remove_ticker_settings_action(ticker_name))
    B.place(x=x_axis_tickers, y=y_axis_tickers, width=100, height=30)


def add_tickers():  
    tickers_gui= tk.Toplevel(top)
    tickers_gui.geometry("1280x720")
    tickers_gui.state('zoomed') #full screen 
    update_ticker_settings(tickers_gui)



 
 
def menu():
    ##section menu
    menu = tk.Menu(top)
    top.config(menu=menu)
    fileMenu = tk.Menu(menu)
    menu.add_cascade(label="Settings", menu=fileMenu)
    fileMenu.add_command(label="Account", command=account_settings)
    fileMenu.add_command(label="Add tickers", command=add_tickers)
    editMenu = tk.Menu(menu)
    menu.add_cascade(label="Edit", menu=editMenu)
    ## end of menu section


menu()









# přidáme tlačítka na plohu společně s jejich vlastnostmi 
def fill_butons(ticker_name,x_axis_tickers,index_ticker,y_axis_tickers):
    B = tk.Button(top,text =ticker_name, command = lambda: plot(index_ticker))
    B.place(x=x_axis_tickers, y=y_axis_tickers,width=100, height=30)


def fill_butons_start():
    x=0
    x_axis_tickers=400
    y_axis_tickers=5
    for i in ticker_names:
        fill_butons(i,x_axis_tickers,x,y_axis_tickers)
        x_axis_tickers+=100
        if x_axis_tickers > 1500:
            x_axis_tickers=400
            y_axis_tickers+=30
        x+=1

fill_butons_start()
top.mainloop()



