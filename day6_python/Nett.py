
from ReadNett import ReadNett
from Player import Player

# Rute-nett/grid net
class Nett:
    def __init__(self, ):
        self.nett = None
        self.player = None
        self.nRow = None
        self.nCol = None
        self.nextNett = None


    def readNett( self, fileName:str):
        input = ReadNett(fileName = fileName)
        self.nett = input
        self.player = Player( nett = self.nett)
        self.nRow = None
        self.nCol = None
        self.getNettInfo()
        self.nextNett = self.nett



    def setNewNett(self, new_nett):
        self.nett = new_nett
        self.player = Player( nett = self.nett)
        self.game_end = False
        self.nRow = None
        self.nCol = None
        self.getNettInfo()
        self.nextNett = self.nett

    def getNettInfo(self):
        nRow = -1
        for line in self.nett.getNett():    
            nRow = nRow +1
            nC = -1   
            for v in line:       
                nC = nC +1
        self.nRow = nRow
        self.nCol = nC    

    def givePlayer(self):
        return self.player

    def givePositionPlayer(self):
        return self.player.givePosition()


    def setNextNett(self):

        dir = self.player.giveDirection()
        pos = self.player.givePosition()
        
        # grid limits 
        nRow = self.nRow
        nCol = self.nCol
        
#        print( self.giveValue( 0, 1))

        if self.giveValue( rad = pos[0], col = pos[1]) == "^" and self.giveValue( rad = pos[0]-1, col = pos[1]) == "#":
            self.changeValue( rad= pos[0], col = pos[1]+1, newValue = ">" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 
        
        if self.giveValue( rad = pos[0], col = pos[1]) == "^" and self.giveValue( rad = pos[0]-1, col = pos[1]) == ".":
            self.changeValue( rad= pos[0]-1, col = pos[1], newValue = "^" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 

        if self.giveValue( rad = pos[0], col = pos[1]) == "^" and self.giveValue( rad = pos[0]-1, col = pos[1]) == "X":
            self.changeValue( rad= pos[0]-1, col = pos[1], newValue = "^" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 
        #
        if self.giveValue( rad = pos[0], col = pos[1]) == ">" and self.giveValue( rad = pos[0], col = pos[1]+1) == ".":
            self.changeValue( rad= pos[0], col = pos[1]+1, newValue = ">" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 
        #
        if self.giveValue( rad = pos[0], col = pos[1]) == ">" and self.giveValue( rad = pos[0], col = pos[1]+1 ) == "#":
            self.changeValue( rad= pos[0]+1, col = pos[1], newValue = "v" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 

        if self.giveValue( rad = pos[0], col = pos[1]) == ">" and self.giveValue( rad = pos[0], col = pos[1]+1 ) == "X":
            self.changeValue( rad= pos[0], col = pos[1]+1, newValue = ">" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 
        
        #
        if self.giveValue( rad = pos[0], col = pos[1]) == "v" and self.giveValue( rad = pos[0]+1, col = pos[1] ) == ".":
            self.changeValue( rad= pos[0]+1, col = pos[1], newValue = "v" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 

        #
        if self.giveValue( rad = pos[0], col = pos[1]) == "v" and self.giveValue( rad = pos[0]+1, col = pos[1] ) == "#":
            self.changeValue( rad= pos[0], col = pos[1]-1, newValue = "<" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 
        
        if self.giveValue( rad = pos[0], col = pos[1]) == "<" and self.giveValue( rad = pos[0], col = pos[1]-1 ) == ".":
            self.changeValue( rad= pos[0], col = pos[1]-1, newValue = "<" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 

        if self.giveValue( rad = pos[0], col = pos[1]) == "<" and self.giveValue( rad = pos[0], col = pos[1]-1 ) == "X":
            self.changeValue( rad= pos[0], col = pos[1]-1, newValue = "<" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 


        if self.giveValue( rad = pos[0], col = pos[1]) == "<" and self.giveValue( rad = pos[0], col = pos[1]-1 ) == "#":
            self.changeValue( rad= pos[0]-1, col = pos[1], newValue = "^" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 

        if self.giveValue( rad = pos[0], col = pos[1]) == "v" and self.giveValue( rad = pos[0]+1, col = pos[1] ) == "X":
            self.changeValue( rad= pos[0]+1, col = pos[1], newValue = "v" ) 
            self.changeValue( rad = pos[0], col = pos[1], newValue= "X" ) 

        if pos[0] +1 > nRow:
            return "STOP"
        if pos[1] +1 > nCol:
            return "STOP"
        if pos[0] -1 < 0:
            return "STOP"
        if pos[1] -1 < 0:
            return "STOP"            
        else: return"ok" 


    def countX(self):

        n = 0
        for rad in self.nett.getNett():
            for celle in rad:
                if celle.giveValue() == "X":
                    n = n + 1
        
        return n


    def printNett(self):
        for rad in self.nett.getNett():       
            for celle in rad:       
                print(celle.giveValue(), end=" ")  
            print()    


    def getNett(self):
        return self.nett


    def giveValue(self, rad, col):

        n = -1
        for line in self.nett.getNett():
            n = n+1
            k = -1
            for v in line:
                k = k +1
                if rad == n and col == k:
                    return v.giveValue() 
    
 
    def changeValue(self, rad, col, newValue):
        
        next_nett = self.nextNett
        
        n = -1
        for line in next_nett.getNett():
            n = n+1
            k = -1
            for v in line:
                k = k +1
                if rad == n and col == k:
                    v.setNewValue( value = newValue)
        

        
    

    def printNextNett(self):
        for rad in self.nextNett.getNett():       
            for celle in rad:       
                print(celle.giveValue(), end=" ")  
            print()
    

    def giveNextNett(self):
        return self.nextNett