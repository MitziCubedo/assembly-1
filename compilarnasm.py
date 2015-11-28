import os

print("***************************************************************************************************************")
print("* __    _  _______  _______  __   __    _______  _______  __   __  _______  ___   ___      _______  ______    *")
print("*|  |  | ||   _   ||       ||  |_|  |  |       ||       ||  |_|  ||       ||   | |   |    |       ||    _ |   *")
print("*|   |_| ||  |_|  ||  _____||       |  |       ||   _   ||       ||    _  ||   | |   |    |    ___||   | ||   *")
print("*|       ||       || |_____ |       |  |       ||  | |  ||       ||   |_| ||   | |   |    |   |___ |   |_||_  *")
print("*|  _    ||       ||_____  ||       |  |      _||  |_|  ||       ||    ___||   | |   |___ |    ___||    __  | *")
print("*| | |   ||   _   | _____| || ||_|| |  |     |_ |       || ||_|| ||   |    |   | |       ||   |___ |   |  | | *")
print("*|_|  |__||__| |__||_______||_|   |_|  |_______||_______||_|   |_||___|    |___| |_______||_______||___|  |_| *")
print("*                                                                                                             *")
print("***************************************************************************************************************")
print("Version 0.1 por Cristian Samaniego")
print("")

archivo = raw_input("Especifique el nombre del archivo (sin la extension .asm): \n")
liga = raw_input("Seleccione el linker: \n 1)gcc \n 2)ld \n")

try:
    os.system("nasm -f elf "+archivo+".asm")
    if liga == 1:
    	os.system("gcc "+archivo+".o -o "+archivo)
    	pass
    elif liga == 2:
    	os.system("ld -o "+archivo+" "+archivo+".o -melf_i386")
    
    pass
except OSError, e:
    print("Error inesperado: "+e)
    raise
