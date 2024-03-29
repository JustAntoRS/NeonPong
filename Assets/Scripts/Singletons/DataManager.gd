extends Node
"""
Code that works as a Singleton to store general variables of the game
"""
#Score of the players
var Player1Score : int = 0
var Player2Score : int = 0

#Player (1 or 2) who won the match
var Winner : int

#Time that the ball is stopped when a point is scored
var waitSecs : int = 3

#Max points to win the match
var MaxPoints : int = 7

#Difficulty Chosen
var Difficulty : String = "god"

#Ball position
var BallPos : Vector2 = Vector2(0,0)

#Ball direction
var BallDir : Vector2 = Vector2(0,0)

#Scene to load next
var sceneToLoad : String 
