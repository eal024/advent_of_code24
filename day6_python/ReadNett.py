from Rute import Rute


class ReadNett:
    def __init__(self, fileName: str ):
        
        file = open(fileName) 
        self.list_nett = []

        row_nr = -1
        for line in file:
            row_nr = row_nr +1
            
            row = []
            values = line.strip()
            col_nr = -1
            for v in values:
                col_nr = col_nr + 1
                rute = Rute( rows = row_nr, cols = col_nr, value = v)   
                row.append( rute )

            self.list_nett.append(row)
        
    def getNett(self):
        return self.list_nett

    # def giveValue(self, rad, col):

    #     nr_i = -1
    #     for i in self.list_nett:
    #         nr_i = nr_i +1
    #         nr_j = -1
    #         for j in i:
    #             nr_j = nr_j + 1
    #             if rad == nr_i and col == nr_j:
    #                 return j.giveValue()


