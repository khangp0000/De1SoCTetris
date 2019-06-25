set_global_assignment -entity "pll_74" -library "lib_pll_74" -name IP_TOOL_NAME "altera_pll"
set_global_assignment -entity "pll_74" -library "lib_pll_74" -name IP_TOOL_VERSION "17.0"
set_global_assignment -entity "pll_74" -library "lib_pll_74" -name IP_TOOL_ENV "mwpim"
set_global_assignment -library "lib_pll_74" -name SPD_FILE [file join $::quartus(sip_path) "pll_74.spd"]

set_global_assignment -library "lib_pll_74" -name MISC_FILE [file join $::quartus(sip_path) "pll_74_sim/pll_74.vo"]
