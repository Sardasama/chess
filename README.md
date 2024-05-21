*WORK STILL IN PROGRESS : Game working as intended for now*

**Working features :**
- board display
- all chesspieces movements, except castling move (switching tower and king)
- collision check
- players take turn

**Fix needed**

**FIXED**
- if error is raised during the move_to function, the next turn shouldn't start
- refining of pawns movements : can move 2 squares on first move, can only take on a diagonal move

**Still missing :**
- winning conditions : verify for check and checkmate
- castling move
- save/load feature
- game menu (start, load)
- basic AI

**ADDED**
- promotion of a pawn

**Could/should be improved :**
- clean and improve code by replacing loops and limiting the use of arrays
- let players enter their names and choose their color
- manage stalemate and rules about repetition
- scoreboard
- pawn special move (taking en-passant)
