# On Mac keyboards enable the number pad to control the cursor keys.
# I'm told you can do this with Karabiner Elements, but I'm too paranoid to install
# a third-party keyboard driver.

# Uses the keyboard usage IDs documented in https://developer.apple.com/library/archive/technotes/tn2450/_index.html.
# The lines below, respectively, map:
#   Keypad 2 and Down Arrow -> Keyboard Down Arrow
#   Keypad 4 and Left Arrow -> Keyboard Left Arrow
#   Keypad 6 and Right Arrow -> Keyboard Right Arrow
#   Keypad 8 and Up Arrow -> Keyboard Up Arrow
#
#   Keypad 1 and End -> Keyboard End
#   Keypad 3 and Page Down -> Keyboard Page Down
#   Keypad 7 and Home -> Keyboard Home
#   Keypad 9 and Page Up -> Keyboard Page Up

hidutil property --set '{"UserKeyMapping": [
{"HIDKeyboardModifierMappingSrc":0x70000005A,"HIDKeyboardModifierMappingDst":0x700000051},
{"HIDKeyboardModifierMappingSrc":0x70000005C,"HIDKeyboardModifierMappingDst":0x700000050},
{"HIDKeyboardModifierMappingSrc":0x70000005E,"HIDKeyboardModifierMappingDst":0x70000004F},
{"HIDKeyboardModifierMappingSrc":0x700000060,"HIDKeyboardModifierMappingDst":0x700000052},

{"HIDKeyboardModifierMappingSrc":0x700000059,"HIDKeyboardModifierMappingDst":0x70000004D},
{"HIDKeyboardModifierMappingSrc":0x70000005B,"HIDKeyboardModifierMappingDst":0x70000004E},
{"HIDKeyboardModifierMappingSrc":0x70000005F,"HIDKeyboardModifierMappingDst":0x70000004A},
{"HIDKeyboardModifierMappingSrc":0x700000061,"HIDKeyboardModifierMappingDst":0x70000004B}
]}'


