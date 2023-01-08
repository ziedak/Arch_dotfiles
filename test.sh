#!/bin/env bash
source ./utils/colors.sh   
source ./utils/select_unique.sh   
source ./utils/select_multiples.sh   

# if [ -e ./menu.sh ]; then
#     source ./menu.sh
# else
#     echo "script menu.sh introuvable dans le répertoire courant"
#     exit
# fi


# echo -ne "
# $(yellowprint 'SUB-SUBMENU')
# $(greenprint '1)') GOOD MORNING
# $(greenprint '2)') GOOD AFTERNOON
# $(blueprint '3)') Go Back to SUBMENU
# $(magentaprint '4)') Go Back to MAIN MENU
# $(redprint '0)') Exit
# Choose an option:  "

options=("Yes" "No" "${array[@]}") # join arrays to add some variable array
case `select_opt "${options[@]}"` in
    0) echo "selected Yes";;
    1) echo "selected No";;
    *) echo "selected ${options[$?]}";;
esac


my_options=(   "Option 1"  "Option 2"  "Option 3" )
preselection=( "true"      "true"      "false"    )

multiselect "true" result my_options preselection

idx=0
for option in "${my_options[@]}"; do
    echo -e "$option\t=> ${result[idx]}"
    ((idx++))
done