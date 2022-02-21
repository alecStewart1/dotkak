# TRON Legacy theme based on Emacs's TRON Legacy Theme

#declare-option bool tron-brighter-comments false
#declare-option bool tron-softer-bg false
#declare-option bool tron-vivid-cursor true

# TODO
#
#  Work with options.
# 
evaluate-commands %sh{
    set -eu

    bg="rgb:000000"
    bg2="rgb:0e1926"
    bg3="rgb:1b324b"
    fg="rgb:5a7387"
    fg2="rgb:bbccdd"
    fg3="rgb:bbf0ef"

    black="rgb:000000"
    brblack="rgb:17181b"

    red="rgb:b62d66"
    brred="rgb:ff7dbb"

    green="rgb:4bb5be"
    brgreen="rgb:abdcdf"

    yellow="rgb:deb45b"
    bryellow="rgb:f9cc6e"

    blue="rgb:5ec4ff"
    brblue="rgb:a0dcfc"

    orange="rgb:db8e73"
    brorange="rgb:f48e6b"

    magenta="rgb:b62d66"
    brmagenta="rgb:e8337e"

    cyan="rgb:4bb5be"
    brcyan="rgb:80dfe7"

    white="rgb:bbccdd"
    brwhite="rgb:a5bad0"

    str="rgb:387aaa"
    var="rgb:5a7387"
    key="rgb:aaaaaa"
    keyw="rgb:8fd4ff"
    doc="rgb:6a8397"
    cursor="rgb:eec45B"
    
    printf %s "
        # Code highlighting
        face global value ${brwhite}
        face global type ${cyan}
        face global variable ${var}
        face global module ${brmagenta}
        face global function ${yellow}
        face global string ${str}
        face global error ${bg},${red}+ba
        face global warning ${bg},${orange}+ba
        face global keyword ${keyw}+b
        face global operator ${bg2}
        face global method ${bryellow}
        face global attribute ${var}
        face global comment ${fg}+da
        face global documentation ${doc}
        face global meta ${brblue}
        face global builtin ${keyw}+b

        # Markup
        face global title ${cyan}
        face global header ${white} 
        face global bold ${cyan}+ba 
        face global italic ${key}+ia 
        face global underline ${cyan}+ufa 
        face global strikethrough ${green}
        face global mono ${brwhite}+b
        face global block ${white} 
        face global link ${blue}+u 
        face global bullet ${magenta} 
        face global list ${brcyan}
        
        face global Default ${fg},${bg}     
        face global PrimarySelection ${bg},${fg}+fg
        face global SecondarySelection ${bg},${fg}+fg 
        face global PrimaryCursor ${bg},${cursor}+bfg 
        face global SecondaryCursor ${bg},${magenta}+fg
        face global PrimaryCursorEol ${bg},${cursor}+fg
        face global SecondaryCursorEol ${bg},${cursor}+fg
        face global LineNumbers ${blue}
        face global LineNumberCursor ${brblue},${bg}+b 
        face global LineNumbersWrapped ${bryellow},default+b
        face global MenuForeground ${brcyan},${bg}
        face global MenuBackground ${brcyan},${bg}
        face global MenuInfo ${fg},${bg}+i
        face global Information ${fg},${bg2}
        face global Error ${fg},${red} 
        face global StatusLine ${fg2},${bg2}      
        face global StatusLineMode ${bg},${cyan}
        face global StatusLineInfo ${fg},${bg2}
        face global StatusLineValue ${bg3},${bg} 
        face global StatusCursor ${fg},${brcyan}+bg     
        face global Prompt ${green},${bg}
        face global MatchingChar ${orange}+b     
        face global BufferPadding ${bg2},$bg    
        face global Whitespace ${bg2},${bg}+fg
        face global WrapMarker ${bg2}+f

        # Custom faces
        face global Numbers ${brmagenta},${bg}+b
        add-highlighter global/numbers regex '\b(\+|-)?[0-9]+(\.[0-9]+)?(/[0-9]+(\.[0-9]+)?)?( ?%|\b)' 0:Numbers
    "

}
