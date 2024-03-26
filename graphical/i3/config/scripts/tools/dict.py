import subprocess, os;

pathStoredSearches = "~/nixos/modules/home-manager-modules/graphical/i3/config/scripts/storage/dict_searches.txt";

def runDictionary():
    inp = getRofiWithPreviousSearches();
    print(inp);
    if (inp != ""): 
        showMeaning(inp);
    saveLocally(inp);

def getRofiWithPreviousSearches():
    prevSearches = listPrevSearches();
    rofiCmd = "rofi -dmenu";
    return subprocess.getoutput(parseEchoCommand(prevSearches) + " | " + rofiCmd);

def listPrevSearches():
    cmd = "cat ~/nixos/modules/home-manager-modules/graphical/i3/config/scripts/storage/dict_searches.txt";
    return subprocess.getoutput(cmd);

def showMeaning(inp):
    cmdDict = "dict -h dict.org " + inp;
    cmdRofi = cmdDict + " | rofi -dmenu";
    subprocess.getoutput(cmdRofi);

def saveLocally(inp):
    if (os.path.isfile(pathStoredSearches)):
        cmd = "touch {path}/dict_searches.txt".format(pathStoredSearches);
        subprocess.getoutput(cmd);
    if (inp != ""):
        cmd = parseEchoCommand(inp) + " | cat - "+ pathStoredSearches + " > temp && mv temp " + pathStoredSearches;
        subprocess.getoutput(cmd);

def parseEchoCommand(inp):
    return 'echo "' + inp + '"';

runDictionary();