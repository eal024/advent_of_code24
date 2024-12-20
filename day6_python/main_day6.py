from Rute import Rute
from Player import Player
from Nett import Nett

class main:

    test = Nett( ) # Create a obect nett
    test.readNett(fileName = "data/day6_nett_full.txt")     # import data

    n = 3    # For counting iterations
    t = "ok" # Condtion for cont.
    # THe while loop 
    while t == "ok" and n < 10000:
        n = n+1
        t =  test.setNextNett()  # create next nett (based on > < ^ )
        if n % 1000 == 0:
            print( "n: " + str(n) + " " + t)   # Printing to see the progress
        print( "n: " + str(n) + " " + t)
        test.setNewNett(new_nett= test.giveNextNett()) # For set the new net 


    # Look at the result
    print(test.givePositionPlayer()) # Find the player
    print( "Antall X: " + str( test.countX()) + " + " + str(1) )
    test.printNett() # look at the net
    print(" ")
    print("Number of iterations is: " + str(n))