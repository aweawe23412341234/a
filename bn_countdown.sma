#include <amxmodx>
#include <amxmisc>
#include <engine>
#include <dhudmessage>

#define PLUGIN   "By_neo_countdown"
#define VERSION  "1.0"                
#define AUTHOR   "NEO"

new g_Seconds,g_blok[33]
new glight,gsecond,gshake

public plugin_init()
{                                               
    register_plugin(PLUGIN, VERSION, AUTHOR)                                  
    //register_event("ResetHUD", "round_start", "be");
    register_event("HLTV", "round_start", "a", "1=0", "2=0") 
    
    register_dictionary("bn_countdown.txt")
    set_cvar_string("bn_countdown",VERSION);
    
    glight = register_cvar("bn_light",          "0");
    gshake = register_cvar("bn_efect",          "0");
    gsecond = register_cvar("bn_seconds",       "0");
}

public plugin_cfg()                                                                             
{                                                                               
    new szCfgDir[64], szFile[192];                                                             
    get_configsdir(szCfgDir, charsmax(szCfgDir));
    formatex(szFile,charsmax(szFile),"%s/bn_plague/bn_countdown.cfg",szCfgDir); 
    if(file_exists(szFile))                 
        server_cmd("exec %s", szFile);        
}
                           
public plugin_precache()         
{                                                                                            
    precache_sound("7erva4ok/zmmod/countdown/one.wav") 
    precache_sound("7erva4ok/zmmod/countdown/two.wav")                               
    precache_sound("7erva4ok/zmmod/countdown/three.wav") 
    precache_sound("7erva4ok/zmmod/countdown/four.wav")               
    precache_sound("7erva4ok/zmmod/countdown/five.wav")
    precache_sound("7erva4ok/zmmod/countdown/six.wav")
    precache_sound("7erva4ok/zmmod/countdown/seven.wav")       
    precache_sound("7erva4ok/zmmod/countdown/eight.wav")
    precache_sound("7erva4ok/zmmod/countdown/nine.wav")
    precache_sound("7erva4ok/zmmod/countdown/ten.wav")
                                                                                                       
    precache_sound("7erva4ok/zmmod/countdown/NewRoundIn.wav")      
    precache_sound("7erva4ok/zmmod/countdown/You_are_attacking.wav")                                                              
    precache_sound("7erva4ok/zmmod/countdown/20_seconds.wav")                                  
    precache_sound("7erva4ok/zmmod/countdown/New_assault_in.wav")   
    precache_sound("7erva4ok/zmmod/countdown/start/start.mp3") 
    precache_sound("7erva4ok/zmmod/countdown/care_infection.wav")
    precache_sound("7erva4ok/zmmod/countdown/sirena.wav")                         
    precache_sound("7erva4ok/zmmod/countdown/30_seconds.wav")
}                                                                

public client_connect(id)
{
g_blok[id] = false 
}   
                                        
public round_start(id)
{     
count(id)
g_blok[id] = true
}                                                
                                                                                                          
public count(id)                                                            
{
    if(g_blok[id])
    {
    if (task_exists(41170))
        remove_task(41170)                               
    g_Seconds = floatround(get_pcvar_float(gsecond))                                                  
    new param[32]                  
    set_task(1.0,"count_rr",41170,param,31,"b",0)
    }
}

public count_rr()            
{                                               
    g_Seconds--;                                    
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.39, 0, 6.0, 0.001, 0.1, 1.0)
    show_dhudmessage(0, "%L",0,"msg1", g_Seconds)                                                        
    if (g_Seconds == 30)
    {                                     
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/30_seconds")
    if(get_pcvar_num(glight))
    {                                                      
    set_lights("l")
    }
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 2.1)
    show_dhudmessage(0, "%L",0,"msg30sec")
    }                                                    
    if (g_Seconds == 28)
    {                                           
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/sirena")
    if(get_pcvar_num(glight))
    {                                                      
    set_lights("l")
    }
    if(get_pcvar_num(gshake))                                            
    {                                                 
    {
        for(new i = 0; i <= get_maxplayers(); i++)
        {
            if(is_user_connected(i))
            {
                message_begin(MSG_ONE, get_user_msgid("ScreenFade"), _, i)
                write_short((1<<12)) // duration 
                write_short(0)     
                write_short(0x0000)
                write_byte(0)
                write_byte(0)
                write_byte(50)          
                write_byte(255)
                message_end()
            }
        }
    }
    }
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 2.1)
    show_dhudmessage(0, "%L",0,"msg2")
    }                                
    if (g_Seconds == 26)
    {                           
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/care_infection")
    if(get_pcvar_num(glight))
    {                                                      
    set_lights("l")
    }
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 2.1)
    show_dhudmessage(0, "%L",0,"msg3")
    }                                                         
    if (g_Seconds == 25)
    { 
    client_cmd(0, "mp3 play sound/7erva4ok/zmmod/countdown/start/start.mp3")
    if(get_pcvar_num(glight))
    {                                                      
    set_lights("l")
    }
    }
    if (g_Seconds == 23)        
    { 
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/New_assault_in")
    if(get_pcvar_num(glight))
    {                                                      
    set_lights("l")
    }
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 2.1)
    show_dhudmessage(0, "%L",0,"msg4")
    }                    
    if (g_Seconds == 20)
    {                         
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/20_seconds")
    if(get_pcvar_num(gshake))                                            
    {
    message_begin(MSG_BROADCAST, get_user_msgid("ScreenFade"))
    write_short((1<<12)*4)
    write_short((1<<12)*1)    
    write_short(0x0001)    
    write_byte (255)
    write_byte (255)
    write_byte (255)
    write_byte (255)
    message_end()
    }
    if(get_pcvar_num(glight))
    {                                                      
    set_lights("l")
    }
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 2.1)
    show_dhudmessage(0, "%L",0,"msg20sec")
    if(get_pcvar_num(gshake))
    {               
    message_begin(MSG_BROADCAST, get_user_msgid("ScreenShake"))
    write_short((1<<12)*4) // amplitude
    write_short((1<<12)*2) // duration
    write_short((1<<12)*10) // frequency
    message_end()
    }
    }                                          
    if (g_Seconds == 18)
    { 
    client_cmd(0, "spk fvox/biohazard_detected")
    if(get_pcvar_num(glight))
    {                                                      
    set_lights("l")
    }
    }                   
    if (g_Seconds == 15)
    { 
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/You_are_attacking")
    if(get_pcvar_num(glight))
    {                                                      
    set_lights("l")       
    }
    if(get_pcvar_num(gshake))
    {
    message_begin(MSG_BROADCAST, get_user_msgid("ScreenShake"))
    write_short((1<<12)*4) // amplitude
    write_short((1<<12)*3) // duration
    write_short((1<<12)*12) // frequency
    message_end()
    }
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 2.1)
    show_dhudmessage(0, "%L",0,"msg5")
    }                                                                                                            
    if (g_Seconds == 13)      
    { 
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/NewRoundIn")
    if(get_pcvar_num(glight))
    {                                                      
    set_lights("l")
    }                          
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 2.1)
    show_dhudmessage(0, "%L",0,"msg6")         
    }
//--------------------------------------------------------------------|    
    if (g_Seconds == 10)
    {                        
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/ten")
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 2.1)
    show_dhudmessage(0, "%L",0,"msg10sec")
    if(get_pcvar_num(gshake)) 
    {
    message_begin(MSG_BROADCAST, get_user_msgid("ScreenShake"))
    write_short((1<<12)*5) // amplitude
    write_short((1<<12)*4) // duration
    write_short((1<<12)*15) // frequency
    message_end()
    }
    if(get_pcvar_num(gshake))                                            
    {
    message_begin(MSG_BROADCAST, get_user_msgid("ScreenFade"))
    write_short((1<<12)*4)
    write_short((1<<12)*1)      
    write_short(0x0001)    
    write_byte (255)
    write_byte (0)
    write_byte (0)
    write_byte (255)
    message_end()
    }
    if(get_pcvar_num(glight))                                                                                  
    {
    set_lights("k")                            
    }                                               
    }                                                                                                       
    if (g_Seconds == 9)
    { 
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/nine")
    if(get_pcvar_num(glight))
    {
    set_lights("j")
    }                             
    }
    if (g_Seconds == 8)
    { 
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/eight")
    if(get_pcvar_num(glight))
    {    
    set_lights("i")
    }
    }     
    if (g_Seconds == 7)
    { 
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/seven")    
    if(get_pcvar_num(glight))
    {
    set_lights("h")
    }
    }    
    if (g_Seconds == 6)
    {                              
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/six")
    if(get_pcvar_num(glight))
    {   
    set_lights("g")                                  
    }
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 2.1)
    show_dhudmessage(0, "%L",0,"msg7")
    }
    if (g_Seconds == 5)
    { 
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/five")
    if(get_pcvar_num(glight))                
    {                                                                                                                       
    set_lights("f")
    }    
    }                                                                          
    if (g_Seconds == 4)
    {                                                                                 
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/four")
    if(get_pcvar_num(glight))
    {
    set_lights("e")
    }  
    }
    if (g_Seconds == 3)                                                
    { 
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/three")
    if(get_pcvar_num(glight))
    {      
    set_lights("d")
    } 
    }
    if (g_Seconds == 2)
    { 
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/two")
    if(get_pcvar_num(glight))
    {    
    set_lights("b")
    }
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 2.1)
    show_dhudmessage(0, "%L",0,"msg8")
    }   
    if (g_Seconds == 1)
    {                                                                      
    client_cmd(0, "spk 7erva4ok/zmmod/countdown/one")
    if(get_pcvar_num(glight))                
    {
    set_lights("a")             
    }                                          
    }                                 
                                                                              
    if (g_Seconds == 0)                                       
    {                                                                                                     
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.20, 0, 6.0, 0.001, 0.1, 10.0)
    show_dhudmessage(0, "%L",0,"msg7")
    set_dhudmessage(random_num(57, 255), random_num(0, 255), random_num(0, 255), -1.0, 0.25, 0, 6.0, 0.001, 0.1, 10.0)
    show_dhudmessage(0, "%L",0,"msg8")                                           
    if(get_pcvar_num(glight))   
    {                                                                                                   
    set_lights("d")                                          
    }
    remove_task(41170)                                           
    }
} 
