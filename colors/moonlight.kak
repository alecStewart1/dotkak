# Moonlight Theme taken from

evaluate-commands %sh{
    set -e

    bg="rgb:212337"
    fg="rgb:C8D3F5"
    bg_alt="rgb:303250"
    fg_alt="rgb:93A9EB"

    black="rgb:2F334D"
    brblack="rgb:444A73"

    red="rgb:FF5370"
    brred="rgb:"

    green="rgb:"
    brgreen="rgb:"

    yellow="rgb:"
    bryellow="rgb:"

    blue="rgb:"
    brblue="rgb:"

    magenta="rgb:"
    brmagenta="rgb:"

    cyan="rgb:"
    brcyan="rgb:"

    white="rgb:"
    brwhite="rgb:"

    echo "
        # Code highlighting
        face global value     
        face global type      
        face global variable  
        face global module    
        face global function  
        face global string    
        face global keyword   
        face global operator  
        face global attribute 
        face global comment   
        face global meta      
        face global builtin   

        # Markup
        face global title        
        face global header       
        face global bold         
        face global italic       
        face global underline    
        face global strikethrough
        face global mono         
        face global block        
        face global link         
        face global bullet       
        face global list         

        face global Default            
        face global PrimarySelection   
        face global SecondarySelection 
        face global PrimaryCursor      
        face global SecondaryCursor    
        face global PrimaryCursorEol   
        face global SecondaryCursorEol 
        face global LineNumbers        
        face global LineNumberCursor   
        face global LineNumbersWrapped 
        face global MenuForeground     
        face global MenuBackground     
        face global MenuInfo           
        face global Information        
        face global Error              
        face global StatusLine         
        face global StatusLineMode     
        face global StatusLineInfo     
        face global StatusLineValue   
        face global StatusCursor      
        face global Prompt            
        face global MatchingChar      
        face global BufferPadding     
        face global Whitespace        
        face global WrapMarker        
    "

}
