import tkinter as tk
import back_tester_old as lib
import algorithm as bot
#Create an instance of Tkinter fram e
win = tk.Tk()
#Set the geometry of Tkinter frame
win.geometry("750x270")

def open_lib():
    lib.lib_main()
def open_bot():
    bot.lib_main()

tk.Label(win, text="Zvolte si co chcete dělat", font=('Helvetica 16 bold')).pack(pady=20)
#Create a button in the main Window to open the popup
btn = tk.Button(win, text= "Testovací program", command= open_lib, font=('Helvetica 14 bold'))
btn.place(x=750/2-100, y=270/2-50, width= 200 ,height= 50)
btn2 = tk.Button(win, text= "Zapnout bota", command= open_bot, font=('Helvetica 14 bold'))
btn2.place(x=750/2-100, y=270/2, width= 200 ,height= 50)
win.mainloop()
