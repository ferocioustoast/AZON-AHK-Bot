BlockInput On
Input=0 ;blank number for input to use for number of giveaways to enter
Amount=0 ;numer of giveaways entered
Win=0 ;number of giveaways won
run http://giveawaylisting.com/ ;third party giveaway list
sleep 500

coordmode, pixel, client ;set pixel and mouse reletive to client so it works with more things
coordmode, mouse, client

;get number of giveaways to enter
inputbox, Input, , Make sure you are already signed into Amazon!`rHow many giveaways do you want to enter?

winwait, List
WinMove, , , 0, 0, 1121, 831 ;move to top left of screen so pixelsearchs work

;get to first checkbox
loop 6 {
	send {Tab}
}

;select checkboxs
loop 8 {
	send {Space}
	send {Tab}
}

;tab to fist giveaway
send {Tab}

sleep 500

;loop through giveaways
loop %Input% {
	Amount++
	send {Enter}
	Sleep 5500
	Pixelsearch, px, py, 637, 512,910, 694, 0xC1976B, , fast rgb ;look for box to click
		if (px > 1) {
			tooltip, %Amount% out of %Input%, ;tell number we are on and how manys left
			mousemove, %px%, %py% ;move mouse to box
			mouseclick
			sleep 7500
		}
	Pixelsearch, px, py, 648, 246,746, 410, 0xF3F3F3, , fast rgb ;look for grey color that is only there when loseing
		if (px > 1) {
			tooltip, %Amount% out of %Input%, 
			send ^w
			sleep 500
			loop 3 {
			send {tab}
			}
		}
		else { ;greys not there must have won
			Win++
			send ^+{Tab}
			sleep 500
			loop 3 {
				send {tab}
			}
		}
}
tooltip ;close tooltip
send ^w ;close tab
BlockInput Off
if (Win > 0) {
	msgbox, , Finished, Tried to Enter %Amount% Giveaways. It looks like you won %Win% Giveaways! Check your browser for open tabs.
}
else {
	msgbox, , Finished, Tried to Enter %Amount% Giveaways. Looks like you didn't win any this time. :(
}
