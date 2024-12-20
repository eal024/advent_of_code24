


# First create a Rute 
class Rute:
    def __init__(self, rows: int, cols: int, value = "."):
        self.rows = rows
        self.cols = cols
        self.value = value
        self.position = [self.rows, self.cols]

    def giveValue(self):
        return self.value
    
    def giveRow(self):
        return self.rows

    def getPosition(self):
        return self.position         

    def setNewValue(self, value: str):
        self.value = value


    def count_open_grid(self):
        if self.value == ".":
            return 1
        else:
            return 0