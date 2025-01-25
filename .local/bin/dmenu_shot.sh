#!/usr/bin/env bash

#-------[ internal functions ]-------#
{
    # a function to get custom value as input. Gets one string as input to be
    # used as message.
    function func_get_input(){
        echo | dmenu -i -fn "UbuntuMono Nerd Font:size=11" \
                -nb "${config_colors_normal_background}" \
                -nf "${config_colors_normal_foreground}" \
                -sb "${config_colors_selection_background}" \
                -sf "${config_colors_selection_foreground}" \
                -p "${1}:"
    }

    # a function to read and parse config file. the input should be tha path to
    # the config file.
    function func_parse_config(){
        local line section key value
        local regex_empty="^[[:blank:]]*$"
        local regex_comment="^[[:blank:]]*#"
        local regex_section="^[[:blank:]]*\[([[:alpha:]][[:alnum:]]*)\][[:blank:]]*$"
        local regex_keyval="^[[:blank:]]*([[:alpha:]_][[:alnum:]_]*)[[:blank:]]*=[[:blank:]]*[\"\']?([^\"\']*)[\"\']?"

        # read the lines line-by-line and create variables using the config
        while IFS='= ' read -r line
        do
            # skip if the line is empty
            [[ "${line}" =~ ${regex_empty} ]] && continue
            # skip if the line is comment
            [[ "${line}" =~ ${regex_comment} ]] && continue
            # if the line matches regex for section
            if [[ "${line}" =~ ${regex_section} ]]
            then
                section="${BASH_REMATCH[1]}"
                # echo "section=${section}"
            # if the line matches regex for key-value pair
            elif [[ "${line}" =~ ${regex_keyval} ]]
            then
                key="${BASH_REMATCH[1]}"
                value="${BASH_REMATCH[2]}"
                # echo "${key} = ${value}"
            # if the line does not match any of the above
            else
                echo "The following line in config is invalid:"
                echo "${line}"
            fi

            # create varible synamically using the combination of section and key
            declare -g "config_${section}_${key}"="${value}"

        done < "${1}"
    }
}


#-------[ argument parsing ]-------#
{
    if [[ "${1}" == "--help" ]] || [[ "${1}" == "-h" ]] || [[ "${1}" == "help" ]]
    then
        cat << 'EOF'

dmenu_shot provides a menu with set of custom commands to
perform some simple automated image manipulation on screenshots
taken using Flameshot, and then putting them into clipboard.


Commands:
    -h, --help    To show this help


Menu:
    Trim:          It just trims the extra spaces around the
                    selected region.
    Remove_white:  Useful to remove the white background. It will
                    replace white with transparent.
    Negative:      Convert the image to negative colors.
    Bordered:      Add border around the captured screenshot.
    Scaled:        Resize the screenshot either by percentage
                    (e.g 75%) or specific dimention (e.g 200x300).
    Select_Window: Waits for user to select a window, then take
                    screenshot of it.


Author:
    Mehrad Mahmoudian


Git repository for bug report and contributions:
    https://codeberg.org/mehrad/dmenu_shot
EOF
        exit 0
    fi
}


#-------[ load config ]-------#
{
    #-------[ default values for config ]-------#
    ## define some default config so that we have something to fallback to if
    ## the user didn't have any config file.
    {
        #-------[ UI ]-------#
        ## stuff for look and feel of the user interface
        {
            config_colors_normal_foreground="#00faff"
            config_colors_normal_background="#000000"
            config_colors_selection_foreground="#000000"
            config_colors_selection_background="#00faff"
        }
        
        
        #-------[ action - Bordered ]-------#
        {
            config_action_bordered_line_color="LightGray"
            config_action_bordered_line_thickness=2
            config_action_bordered_corner_radius=7
        }
    }
    
    
    #-------[ read config file ]-------#
    {
        # get the config path from environmental variable, otherwise fall back to
        # the ~/.config/dmenu_shot/config.toml
        if [[ -v DMENU_SHOT_CONF_PATH ]]
        then
            CONF_PATH="${DMENU_SHOT_CONF_PATH}"
        else
            CONF_PATH="${HOME}/.config/dmenu_shot/config.toml"
        fi

        # if the config file do exist
        if [[ -f "${CONF_PATH}" ]]
        then
            func_parse_config "${CONF_PATH}"
        else
            echo "The config file was not found in ${CONF_PATH}"
            echo "Falling back to some defaults!"
        fi
    }
}


RET=$(echo -e "Trim\nRemove_white\nNegative\nBordered\nScaled\nSelect_Window\nCancel" \
    | dmenu -i -fn "UbuntuMono Nerd Font:size=11" \
        -nb "${config_colors_normal_background}" \
        -nf "${config_colors_normal_foreground}" \
        -sb "${config_colors_selection_background}" \
        -sf "${config_colors_selection_foreground}" \
        -p "Select screenshot type:")

case $RET in
    Trim)
        flameshot gui --raw \
            | convert png:- -trim png:- \
            | xclip -selection clipboard -target image/png
        ;;
    Remove_white)
        flameshot gui --raw \
            | convert png:- -transparent white -fuzz 90% png:- \
            | xclip -selection clipboard -target image/png
        ;;
    Negative) 
        flameshot gui --raw \
            | convert png:- -negate -channel RGB png:- \
            | xclip -selection clipboard -target image/png
        ;;
    Bordered)
	    flameshot gui --raw \
        | convert png:- \
            -format "roundrectangle 4,3 %[fx:w+0],%[fx:h+0] ${config_action_bordered_corner_radius},${config_action_bordered_corner_radius}" \
            -write info:tmp.mvg \
            -alpha set -bordercolor "${config_action_bordered_line_color}" -border ${config_action_bordered_line_thickness} \
            \( +clone -alpha transparent -background none \
                -fill white -stroke none -strokewidth 0 -draw @tmp.mvg \) \
            -compose DstIn -composite \
            \( +clone -alpha transparent -background none \
                -fill none -stroke "${config_action_bordered_line_color}" -strokewidth ${config_action_bordered_line_thickness} -draw @tmp.mvg \) \
            -compose Over -composite png:- \
	    | xclip -selection clipboard -target image/png
        ;;
    Scaled)
        tmp_size=$(func_get_input "input resize value (e.g 75% or 200x300)");

        if [[ -n "${tmp_size}" ]]
        then
            flameshot gui -r \
                | convert png:- -resize "${tmp_size}" png:- \
                | xclip -selection clipboard -target image/png
        fi
        ;;
    Select_Window)
        # get the window ID
        TMP_WINDOW_ID=$(xdotool selectwindow)
        
        
    
        unset WINDOW X Y WIDTH HEIGHT SCREEN
        # eval $(xdotool selectwindow getwindowgeometry --shell)
        eval $(xdotool getwindowgeometry --shell "${TMP_WINDOW_ID}")
        
        # Put the window in focus
        xdotool windowfocus --sync "${TMP_WINDOW_ID}"
        sleep 0.05
        
        # run flameshot in gui mode in the desired coordinates
        flameshot gui --region "${WIDTH}x${HEIGHT}+${X}+${Y}"
        
        ;;
	*) ;;
esac

