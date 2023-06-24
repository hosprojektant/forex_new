import subprocess
import datetime


class output_data:
    def __init__(self,profit,win_trades,lose_trades,take_profit,stop_lose,start_day,end_day):
        self.profit = profit
        self.win_trades=win_trades
        self.lose_trades=lose_trades
        self.take_profit=take_profit
        self.stop_lose=stop_lose
        self.start_day=start_day
        self.end_day=end_day

output_list=[]


def get_non_weekends(y,x):
    output = x -y 
    i = y
    while i < x - y:
        day = datetime.datetime.today()- datetime.timedelta(days=i)
        week = day.weekday()
        if week == 5:
            output+=1
        if week == 6:
            i+=1
            output+=2
        i+=1
    return output



print(get_non_weekends(0,3))

for s in range(13,30,5):
    for k in range(3,30,5):
         for u in range(3,30,5):
            if abs(u - s)  >  4 * s or abs(k - s)  >  4 * s:
                continue
            command = "python3.9 back_tester.py -tp=100 -sl=100 -dy=20 -ch="+str(s)+":"+str(k)+":"+str(u)
            output =  subprocess.run(command,  capture_output=True, shell=True).stdout
            output = str(output) [2:-5]
            print(output,command)

exit()
for i in range(100,300,10): #tp sl
    output =  subprocess.run("python3.9 back_tester.py -tp="+str(i)+" -sl="+str(i)+" -dy=2",  capture_output=True, shell=True).stdout
    output = str(output) [2:-5]

    print(output)