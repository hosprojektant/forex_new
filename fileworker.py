


ticker_names=[]
settings_names=[]
ticker_name_input='AHOJ'


def carka(data):
    for i in data:
        if i == ",":
            return 1 
    return 0 


def load_setings(input):
    with open("setings.txt") as file:
        while (line := file.readline().rstrip()):
            case,data = line.split('=', 1)
            if case=="login" and input == "login": 
                return data
            if case=="password" and input == "password":
                return data
            if case=="server" and input == "server":
                return data
            if case=="ticker_names" and input == "ticker_names":
                global ticker_names
                ticker_names.clear()                
                while (carka(data)==1):
                    tmp_tickers,data = data.split(',', 1)
                    ticker_names.append(tmp_tickers)
                ticker_names.append(data)
                ticker_names = list(dict.fromkeys(ticker_names))
                return ticker_names
            if case=="settings_names" and input == "settings_names":
                global settings_names
                settings_names.clear()
                print("dsad")
                while (carka(data)==1):
                    tmp_tickers,data = data.split(',', 1)
                    settings_names.append(tmp_tickers)
                    settings_names = list(dict.fromkeys(settings_names))
                return settings_names


def add_new_ticker(ticker_name_input):
    with open('setings.txt', 'r+') as f: #r+ does the work of rw
        lines = f.readlines()
        for i, line in enumerate(lines):
            if line.startswith('ticker_names'):
                lines[i] = lines[i].strip() + ','+ ticker_name_input +'\n'
        f.seek(0)
        for line in lines:
            f.write(line)

def rewrite_remove(input,line):
    tmp_write=""
    with open("setings.txt", "r+") as f:
        d = f.readlines()
        f.seek(0)
        x=0
        for i in d:
            if x != line:
                f.write(i)
            else:
                case,data = i.split('=', 1)
                if case=="login": 
                    f.write("login="+input+'\n')
                if case=="password":
                    f.write("password="+input+'\n')
                if case=="server":
                    f.write("server="+input+'\n')
                if case=="ticker_names":
                    while (carka(data)==1):
                        tmp_tickers,data = data.split(',', 1)
                        if tmp_tickers != input:
                            tmp_write=tmp_write+tmp_tickers+','
                    f.write("ticker_names="+tmp_write+'\n')
                if case=="settings_names":
                    while (carka(data)==1):
                        tmp_tickers,data = data.split(',', 1)
                        if tmp_tickers != input:
                            tmp_write=tmp_write+tmp_tickers+','
                    f.write("settings_names="+tmp_write+'\n')
            x+=1
        f.truncate()