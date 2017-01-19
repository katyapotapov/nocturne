% Katya Potapov
% MelodyMaker.t
% December 20, 2012
% Ms. Dyke
% This program runs a program that allows the user to create their own melodies.

import GUI

% Declaration Section

var mainWin := Window.Open ("position:centre;centre,graphics:800;400")

% coordX and coordY define the x and y coordinates of the current pixel the mouse is on; button defines whether or not the mouse button is being pressed.
var xCoord, yCoord, button : int := 0

% This variable contains the entire melody that the user inputs.
var melody : string := ""

% These variables define parameters of the note last entered by the user.
var note : string
var timeValue : string
var outputTimeValue : string
var octave : string := ""
var outputNoteValue : string

% This variable defines any adjustments that need to be made in the melody to define notes in different octaves.
var octaveValue : string := ""

var instructionsButton : int := 0
var playMelodyButton : int := 0
var quitButton : int := 0
var continueMelodyButton : int := 0
var newMelodyButton : int := 0
var mainMenuButton : int := 0

const buttonColour : int := 23
var playedMelody : boolean := false
var key : string (1)
var font1 := Font.New ("Adobe Garamond Pro:15")
var pictureID : int

forward proc mainMenu
forward proc userInput


% displays title
proc title
    Pic.ScreenLoad ("nocturne.jpg", 0, 0, picCopy)
    colorback (21)
    color (30)
end title

% This proc deletes the instructions and playMelody
proc deleteButton
    GUI.Dispose (newMelodyButton)
    GUI.Dispose (continueMelodyButton)
    GUI.Dispose (instructionsButton)
    GUI.Dispose (playMelodyButton)
    GUI.Dispose (quitButton)
    userInput
end deleteButton

proc display
    title
    var enterMessage : string
    melody := melody + octaveValue + timeValue + note
    locate (5, 1)
    % sets enter message to the note and output time value that the user selected - if it is a sharp, this replaces "+" with "#" to make it understandable for the user
    if length (note) = 1 then
	enterMessage := note + " " + outputTimeValue + " note."
    else
	enterMessage := note (1) + "# note."
    end if
    Font.Draw ("Your last entered note:", 315, 290, font1, 30)
    Font.Draw (enterMessage, 345, 250, font1, 30)
    var enterAnotherNoteButton := GUI.CreateButtonFull (20, 100, 0, "[e] Enter another note", userInput, 0, "e", true)
    GUI.SetColour (enterAnotherNoteButton, buttonColour)
    mainMenuButton := GUI.CreateButtonFull (650, 100, 0, "[m] Main Menu", mainMenu, 0, "m", false)
    GUI.SetColour (mainMenuButton, buttonColour)
end display

body proc userInput
    Music.PlayFileStop
    note := ""
    timeValue := ""
    octaveValue := ""
    title
    Font.Draw ("Click a piano key:", 120, 350, font1, 30)
    % keyboard
    drawbox (120, 200, 680, 340, 1)
    % white keys
    drawfillbox (120, 200, 680, 340, 0)
    for x : 160 .. 680 by 40
	drawline (x, 200, x, 340, 1)
    end for
    % black keys
    drawfillbox (147, 250, 170, 340, 7)
    drawfillbox (187, 250, 210, 340, 7)

    drawfillbox (267, 250, 290, 340, 7)
    drawfillbox (307, 250, 330, 340, 7)
    drawfillbox (347, 250, 370, 340, 7)

    drawfillbox (427, 250, 450, 340, 7)
    drawfillbox (467, 250, 490, 340, 7)

    drawfillbox (547, 250, 570, 340, 7)
    drawfillbox (587, 250, 610, 340, 7)
    drawfillbox (627, 250, 650, 340, 7)

    loop
	mousewhere (xCoord, yCoord, button)
	if button = 1 then
	    if yCoord >= 200 and yCoord <= 250 then
		if xCoord >= 120 and xCoord <= 400 then
		    if octave = "2" or octave = "" then
			octaveValue := "<"
		    end if
		    octave := "1"
		    if xCoord >= 120 and xCoord <= 160 then
			note := "C"
		    elsif xCoord > 160 and xCoord <= 200 then
			note := "D"
		    elsif xCoord > 200 and xCoord <= 240 then
			note := "E"
		    elsif xCoord > 240 and xCoord <= 280 then
			note := "F"
		    elsif xCoord > 280 and xCoord <= 320 then
			note := "G"
		    elsif xCoord > 320 and xCoord <= 360 then
			note := "A"
		    else
			%if xCoord > 360 and xCoord <= 400 then
			note := "B"
			%end if
		    end if

		else
		    if xCoord > 400 and xCoord <= 680 then
			if octave = "1" then
			    octaveValue := ">"
			end if
			octave := "2"
			if xCoord > 400 and xCoord <= 440 then
			    note := "C"
			elsif xCoord > 440 and xCoord <= 480 then
			    note := "D"
			elsif xCoord > 480 and xCoord <= 520 then
			    note := "E"
			elsif xCoord > 520 and xCoord <= 560 then
			    note := "F"
			elsif xCoord > 560 and xCoord <= 600 then
			    note := "G"
			elsif xCoord > 600 and xCoord <= 640 then
			    note := "A"
			else
			    %if xCoord > 640 and xCoord <= 680 then
			    note := "B"
			    % end if
			end if
		    end if
		end if
	    else
		if yCoord > 250 and yCoord <= 340 then
		    if xCoord >= 147 and xCoord <= 370 then
			if octave = "2" or octave = "" then
			    octaveValue := "<"
			end if
			octave := "1"
			if xCoord >= 147 and xCoord <= 170 then
			    note := "C+"
			elsif xCoord > 187 and xCoord <= 210 then
			    note := "D+"
			elsif xCoord > 267 and xCoord <= 290 then
			    note := "F+"
			elsif xCoord > 307 and xCoord <= 330 then
			    note := "G+"
			else
			    if xCoord > 347 and xCoord <= 370 then
				note := "A+"
			    end if
			end if
		    else
			if xCoord > 400 and xCoord <= 720 then
			    if octave = "1" then
				octaveValue := ">"
			    end if
			    octave := "2"
			    if xCoord > 427 and xCoord <= 450 then
				note := "C+"
			    elsif xCoord > 467 and xCoord <= 490 then
				note := "D+"
			    elsif xCoord > 547 and xCoord <= 570 then
				note := "F+"
			    elsif xCoord > 587 and xCoord <= 610 then
				note := "G+"
			    else
				if xCoord > 627 and xCoord <= 650 then
				    note := "A+"
				end if
			    end if
			end if
		    end if
		end if
	    end if
	end if
	exit when note not= ""
    end loop
    Pic.ScreenLoad ("musicnotes.jpg", 0, 0, picCopy)
    Font.Draw ("Now click on a time value:", 310, 175, font1, 30)
    % time values
    locate (16, 5)
    put "Whole Note"
    locate (16, 25)
    put "Half Note"
    locate (16, 45)
    put "Quarter Note"
    locate (16, 65)
    put "Eighth Note"
    locate (16, 83)
    put "Sixteenth Note"
    for x : 0 .. 800 by 160
	drawbox (2 + x, 140, 144 + x, 160, 7)
    end for
    loop
	mousewhere (xCoord, yCoord, button)
	if button = 1 then
	    if yCoord >= 140 and yCoord <= 160 then
		if xCoord >= 2 and xCoord <= 144 then
		    timeValue := "1"
		    outputTimeValue := "whole"
		elsif xCoord >= 162 and xCoord <= 304 then
		    timeValue := "2"
		    outputTimeValue := "half"
		elsif xCoord >= 322 and xCoord <= 464 then
		    timeValue := "4"
		    outputTimeValue := "quarter"
		elsif xCoord >= 482 and xCoord <= 624 then
		    timeValue := "8"
		    outputTimeValue := "eighth"
		else
		    if xCoord >= 642 and xCoord <= 784 then
			timeValue := "6"
			outputTimeValue := "sixteenth"
		    end if
		end if
	    end if
	end if
	exit when timeValue not= ""
    end loop
    display
end userInput

proc newMelodyConfirm
    % This variable opens a new window displaying the new melody message.
    var newMelodyWin := Window.Open ("position:centre;centre,graphics:400,100")
    drawfillbox (0, 0, maxx, maxy, 21)
    % This variable defines the key that the user enters to choose whether or not to create a new melody.
    Font.Draw ("Are you sure you want to create a new melody?", 0, 80, font1, 30)
    Font.Draw ("Type 'y' for yes or 'n' for no.", 0, 50, font1, 30)
    % This loop repeats the getch command until the user inputs a valid value.
    loop
	getch (key)
	exit when key = chr (121) or key = chr (110)
    end loop
    Window.Close (newMelodyWin)
    % This if structure determines what to do when the user presses a key (either n or y).
    if key = chr (121) then
	melody := ""
	deleteButton
    else
	mainMenu
    end if
end newMelodyConfirm

proc playMelody
    title
    locate (5, 36)
    put "Enjoy your beautiful melody!"
    % this if structure fixes
    if octave = "1" and playedMelody = false then
	melody := melody + ">"
	playedMelody := true
    end if
    play (melody)
    locate (7, 39)
    put "Your melody has ended."
    GUI.Dispose (continueMelodyButton)
    mainMenuButton := GUI.CreateButtonFull (340, 100, 0, "[m] Main Menu", mainMenu, 0, "m", false)
    GUI.SetColour (mainMenuButton, buttonColour)
end playMelody

proc playMelodyConfirm
    var playMelodyWin := Window.Open ("position:centre;centre,graphics:550,100")
    drawfillbox (0, 0, maxx, maxy, 21)
    Font.Draw ("Are you sure you want to finish editing your melody and play it?", 0, 80, font1, 30)
    Font.Draw ("Type 'y' for yes or 'n' for no.", 0, 40, font1, 30)
    loop
	getch (key)
	exit when key = chr (121) or key = chr (110)
    end loop
    Window.Close (playMelodyWin)
    if key = chr (121) then
	playMelody
    else
	mainMenu
    end if
end playMelodyConfirm

proc instructions
    title
    Pic.ScreenLoad ("i-side.jpg", 600, 0, picMerge)
    locate (5, 1)
    Font.Draw ("Click 'New Melody' to create a new melody.", 20, 300, font1, 30)
    Font.Draw ("Next, click on any piano key, and then click on any note value ", 20, 280, font1, 30)
    Font.Draw ("to input the first note of your melody.", 20, 260, font1, 30)
    Font.Draw ("To continue entering notes, click 'enter another note.'", 20, 240, font1, 30)
    Font.Draw ("To play your melody, go to the main menu and click 'Play Melody.'", 20, 220, font1, 30)
    mainMenuButton := GUI.CreateButtonFull (340, 100, 0, "[m] Main Menu", mainMenu, 0, "m", false)
    GUI.SetColour (mainMenuButton, buttonColour)
end instructions

% This proc runs the menu from which the user can tell the program what to do.
body proc mainMenu
    title
    newMelodyButton := GUI.CreateButtonFull (340, 300, 140, "[n] New Melody", newMelodyConfirm, 0, "n", false)
    GUI.SetColour (newMelodyButton, buttonColour)
    continueMelodyButton := GUI.CreateButtonFull (340, 270, 140, "[c] Continue Melody", deleteButton, 0, "c", false)
    GUI.SetColour (continueMelodyButton, buttonColour)
    playMelodyButton := GUI.CreateButtonFull (340, 240, 140, "[p] Play Melody", playMelodyConfirm, 0, "p", false)
    GUI.SetColour (playMelodyButton, buttonColour)
    instructionsButton := GUI.CreateButtonFull (340, 210, 140, "[i] Instructions", instructions, 0, "i", false)
    GUI.SetColour (instructionsButton, buttonColour)
    quitButton := GUI.CreateButtonFull (340, 180, 140, "[q] Quit", GUI.Quit, 0, "q", false)
    GUI.SetColour (quitButton, buttonColour)
    if melody = "" then
	GUI.Disable (playMelodyButton)
    end if
end mainMenu


process playThemeSong
    Music.PlayFile ("alone.mp3")
end playThemeSong

proc animation
    fork playThemeSong
    drawfillbox (0, 0, 800, 400, 21)
    % the logo of the program
    var screenLogo := Pic.FileNew ("logo.jpg")
    % the crescent moon that moves across the screen
    var crescentMoon := Pic.FileNew ("crescent.jpg")
    % defines the random number used to determine whether a star will show or not - allows for random twinkling
    var twinkleStars : int
    for x : 0 .. 270
	Pic.Draw (crescentMoon, 0 + x, 0 + x, picMerge)
	delay (5)
    end for
    for x : 0 .. 100
	Pic.Draw (crescentMoon, 270 + x, 270, picMerge)
	delay (15)
    end for
    for x : 0 .. 90
	Pic.Draw (crescentMoon, 370 + x, 270 - x, picMerge)
	delay (15)
    end for
    delay (500)
    for x : 0 .. 270
	Pic.Draw (screenLogo, 270, 170, picMerge)
	drawfillbox (270, 170, 540 - x, 260, 21)
	delay (15)
    end for
    delay (1000)
    for x : 0 .. 35
	drawfillbox (0, 0, 800, 400, 21)
	Pic.Draw (screenLogo, 270, 170, picMerge)
	randint (twinkleStars, 0, 100)
	if twinkleStars >= 0 and twinkleStars < 10 then
	    drawfillstar (100, 100, 120, 120, 30)
	elsif twinkleStars >= 10 and twinkleStars < 20 then
	    drawfillstar (150, 200, 170, 220, 30)
	elsif twinkleStars >= 20 and twinkleStars < 30 then
	    drawfillstar (700, 300, 720, 320, 30)
	elsif twinkleStars >= 30 and twinkleStars < 40 then
	    drawfillstar (50, 350, 70, 370, 30)
	elsif twinkleStars >= 40 and twinkleStars < 50 then
	    drawfillstar (600, 250, 620, 270, 30)
	elsif twinkleStars >= 50 and twinkleStars < 60 then
	    drawfillstar (500, 370, 520, 390, 30)
	elsif twinkleStars >= 60 and twinkleStars < 70 then
	    drawfillstar (200, 20, 220, 40, 30)
	elsif twinkleStars >= 70 and twinkleStars < 80 then
	    drawfillstar (650, 330, 670, 350, 30)
	elsif twinkleStars >= 80 and twinkleStars < 90 then
	    drawfillstar (770, 60, 790, 80, 30)
	else
	    if twinkleStars >= 90 and twinkleStars <= 100 then
		drawfillstar (300, 120, 320, 140, 30)
	    end if
	end if
	delay (200)
    end for


end animation

% Introduction of program - contains intro animation
proc introduction
    animation
    title
    locate (5, 20)
    Font.Draw ("Welcome to Nocturne, where you can create your own melodies!", 140, 300, font1, 30)
    mainMenuButton := GUI.CreateButtonFull (345, 10, 0, "[m] Main Menu", mainMenu, 0, "m", false)
    GUI.SetColour (mainMenuButton, buttonColour)
end introduction

% Goodbye - end screen of program
proc goodBye
    title
    Pic.ScreenLoad ("jack-frost.jpg", 290, 40, picCopy)
    Font.Draw ("Thanks for using this program!", 270, 320, font1, 30)
    Font.Draw ("Program by Katya Potapov.", 285, 290, font1, 30)
    Font.Draw ("Press any key to exit.", 310, 260, font1, 30)
    Font.Draw ("A Dumbledyke Army of Kittens (DAK) Production.", 10, 10, font1, 30)
    loop
	exit when hasch
    end loop
    Window.Close (mainWin)
end goodBye

% Main Program
introduction
loop
    exit when GUI.ProcessEvent
end loop
goodBye
% End Main Program
