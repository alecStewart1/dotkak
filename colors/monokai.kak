# Classic Monokai Theme for Kakoune

evaluate-commands %sh{
    set -u
    bg="rgb:272822"
    bgtwo="rgb:1D1E19"
    fg="rgb:F8F8F2"

    gray="rgb:767679"
    gray_light="rgb:CFC0C5"

    blue="rgb:268bd2"
    dark_blue="rgb:727280"

    cyan="rgb:66D9EF"
    dark_cyan="rgb:8FA1B3"

    green="rgb:A6E22E"

    orange="rgb:FD971F"

    magenta="rgb:F92660"

    purple="rgb:9C91E4"

    red="rgb:E74C3C"

    yellow="rgb:E6DB74"

    echo "
        # Code
        face global value          ${purple}
        face global type           ${cyan}
        face global variable       ${fg}
        face global identifier     ${orange}
        face global module         ${blue}
        face global function       ${green}
        face global string         ${yellow}
        face global keyword        ${magenta}
        face global operator       ${green}
        face global attribute      ${magenta}
        face global comment        ${gray}
        face global documentation  ${dark_cyan}
        face global meta           ${dark_blue}
        face global builtin        default+b

        # Markup
        face global title         ${red}+b
        face global header        ${magenta}+b
        face global bold          default,${orange}+ba
        face global italic        default,${cyan}+ia
        face global underline     default,${blue}+ufa
        face global strikethrough default+bfg
        face global mono          ${green}
        face global block         ${purple}
        face global link          ${cyan}+u
        face global bullet        ${dark_cyan}
        face global list          ${dark_cyan}

        # Builtin faces
        face global Default            ${fg},${bg}

        face global PrimarySelection   ${gray},${fg}+bfg
        face global SecondarySelection ${gray},${fg}+bfg

        face global PrimaryCursor      ${bg},${magenta}+fg
        face global SecondaryCursor    ${bg},${blue}+fg
        face global PrimaryCursorEol   ${bg},${magenta}+fg
        face global SecondayCursorEol  ${bg},${magenta}+fg

        face global LineNumbers        ${gray_light},${bgtwo}
        face global LineNumberCursor   ${yellow}+b

        face global MenuForeground     ${dark_blue}+bf
        face global MenuBackground     ${purple}+bfg
        face global MenuInfo           ${orange}+i

        face global Information        ${green}

        face global Error              ${bg},${red}+bg

        face global StatusLine         ${dark_cyan},${bgtwo}
        face global StatusLineMode     ${dark_cyan}
        face global StatusLineInfo     ${dark_cyan}
        face global StatusLineValue    ${cyan}
        face global StatusCursor       ${bg},${fg}+bg

        face global Prompt             ${purple},${bgtwo}

        face global MatchingChar       default,${magenta}+b

        face global Whitespace         ${bg}+f

        face global BufferPadding      default,${bg}+f

        face global WrapMarker         ${bg}+f
    "
}
