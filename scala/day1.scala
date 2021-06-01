val empty = 0
val x = 1
val o = 2
var isXTurn = true
var shouldContinue = true
val pieceArray = Array(' ', 'x', 'o')
var board = Array.ofDim[Int](3, 3)
def main(args: Array[String]) : Unit = 
{
    while(shouldContinue)
    {
        printBoard()
        println("Enter x move for player " + (if (isXTurn)  "x" else "o") + " [0, 2]")
        var xMove = scala.io.StdIn.readInt()
        println("Enter y move for player " + (if (isXTurn)  "x" else "o") + " [0, 2]")
        var yMove = scala.io.StdIn.readInt()
        if(validMove(xMove, yMove)){
            board(xMove)(yMove) = if (isXTurn) x else o
            isXTurn = !isXTurn
        }
        if(win()){
            shouldContinue = false
            printBoard()
        }
    }
}

def validMove(x : Int, y : Int) : Boolean = 
{
    board(x)(y) == empty
}

def win() : Boolean = 
{
    (board(0)(0) == board(0)(1) && board(0)(0) == board(0)(2) && board(0)(0) != empty) ||
    (board(1)(0) == board(1)(1) && board(1)(0) == board(1)(2) && board(1)(0) != empty) ||
    (board(2)(0) == board(2)(1) && board(2)(0) == board(2)(2) && board(2)(0) != empty) ||
    (board(0)(0) == board(1)(1) && board(0)(0) == board(2)(2) && board(0)(0) != empty) || 
    (board(2)(0) == board(1)(1) && board(2)(0) == board(0)(2) && board(2)(0) != empty)
}

def valToPiece(pieceValue : Int) : Char = {
    pieceArray(pieceValue)
}

def printBoard() : Unit = {
    for(x<-0 until board.length)
    {
        for(y<-0 until board(0).length)
        {
            print(valToPiece(board(x)(y)) + "|")
        }
        println()
        println("-------")
    }
}
main(null)