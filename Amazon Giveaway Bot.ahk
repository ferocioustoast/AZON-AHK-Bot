BlockInput On
Input=0
Amount=0
Win=0
run http://giveawaylisting.com/
sleep 500

coordmode, pixel, client
coordmode, mouse, client

;get loop count
inputbox, Input, , Make sure you are already signed into Amazon!`rHow many giveaways do you want to enter?

winwait, List
WinMove, , , 0, 0, 1121, 831

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
	Pixelsearch, px, py, 637, 512,910, 694, 0xC1976B, , fast rgb
		if (px > 1) {
			tooltip, %Amount% out of %Input%, 
			mousemove, %px%, %py%
			mouseclick
			sleep 7500
		}
	Pixelsearch, px, py, 648, 246,746, 410, 0xF3F3F3, , fast rgb
		if (px > 1) {
			tooltip, %Amount% out of %Input%, 
			send ^w
			sleep 500
			loop 3 {
			send {tab}
			}
		}
		else {
			Win++
			send ^+{Tab}
			sleep 500
			loop 3 {
				send {tab}
			}
		}
}
tooltip 
send ^w
BlockInput Off
if (Win > 0) {
	msgbox, , Finished, Tried to Enter %Amount% Giveaways. It looks like you won %Win% Giveaways! Check your browser for open tabs.
}
else {
	msgbox, , Finished, Tried to Enter %Amount% Giveaways. Looks like you didn't win any this time. :(
}