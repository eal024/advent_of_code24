



        row_nr = -1
        for row in self.nett:
            row_nr = row_nr + 1
            col_nr = -1
            for col in row:
                col_nr = col_nr + 1
                v = col.giveValue()
                if v == "^" or  v == ">" or v == "v":                
                    self.playerPosition = col.getPosition()
                    self.history = [row_nr, col_nr]
                    if  v == "^":
                        if (col_nr + 1) > len(col):
                            self.game_end = True
                        else:     
                            self.playerNextPostion = [row_nr, col_nr+1]
                    if  v == ">":
                        if (col_nr +1) > len(col):
                            self.game_end = True
                        else: 
                            self.playerNextPostion = [row_nr, col_nr+1]
                    if  v == "v":
                        if (row_nr + 1) > len(row):
                            self.game_end = True
                        else:
                            self.playerNextPostion = [row_nr+1, col_nr]
