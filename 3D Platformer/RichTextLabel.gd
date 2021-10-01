extends RichTextLabel

var ms = 0
var sek = 0 
var minutes = 0

func _process(delta):
	if ms > 9:
		sek += 1
		ms = 0
		
	if sek > 59:
		minutes += 1
		sek = 0
		
	set_text("%02d:%02d:%02d" % [minutes,sek,ms])
		  

func _on_counter_timeout():
	ms += 01
	pass # Replace with function body.
