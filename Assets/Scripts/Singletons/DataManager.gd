extends Node
"""
Code that works as a Singleton to store general variables of the game
"""
#Score of the players
var Player1Score : int = 0
var Player2Score : int = 0

#Time that the ball is stopped when a point is scored
var waitSecs : int = 2

#Max points to win the match (7 by default)
var MaxPoints : int = 7

#Ball position
var BallPos : Vector2 = Vector2(0,0)

#Ball direction
var BallDir : Vector2 = Vector2(0,0)
