

# 
class Player:

    def __init__(self, nett):

        self.nett = nett
        self.history = None
        self.direction = None
        self.position = None
        self.findPlayer()

    #    self.finePlayer()
    
    def setNett(self, nett):
        self.nett = nett


    def findPlayer(self):

        row_nr = -1
        for row in self.nett.getNett():
            row_nr = row_nr + 1
            col_nr = -1
            for col in row:
                col_nr = col_nr + 1
                # V er objekt Rute
                v = col.giveValue()
                if v == "^" or  v == ">" or v == "v" or v == "<":

                    self.direction = v
                    self.position = [row_nr, col_nr]
                    self.history = [row_nr, col_nr]


    def givePosition(self):
        return self.position 
   
    
    def giveDirection(self):
        return self.direction
