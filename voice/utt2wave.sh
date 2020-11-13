#/bin/bash

# echo "Halló allir. Hvað er eiginlega að frétta?" | python3 normalize.py - - | /usr/local/src/festival/bin/text2wave -eval festvox/lvl_is_v0_clunits.scm -eval '(voice_lvl_is_v0_clunits)' > full_path.wav
/opt/festival/bin/text2wave -eval festvox/lvl_is_v0_clunits.scm -eval '(voice_lvl_is_v0_clunits)' $1
