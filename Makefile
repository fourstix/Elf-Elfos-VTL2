PROJECT = vtl2

elfos: $(PROJECT).asm bios.inc
	../dateextended.pl > date.inc
	../build.pl > build.inc
	rcasm -l -v -x -d 1802 -DELFOS $(PROJECT) 2>&1 | tee  $(PROJECT).lst
	cat $(PROJECT).prg | sed -f adjust.sed > x.prg
	rm $(PROJECT).prg
	mv x.prg $(PROJECT).prg

dload: $(PROJECT).asm bios.inc
	rcasm -l -v -x -d 1802 -DDLOAD $(PROJECT) 2>&1 | tee  $(PROJECT).lst

mchip: $(PROJECT).asm bios.inc
	rcasm -l -v -x -d 1802 -DMCHIP $(PROJECT) 2>&1 | tee  $(PROJECT).lst

hex: $(PROJECT).prg
	cat $(PROJECT).prg | ../tointel.pl > $(PROJECT).hex

bin: $(PROJECT).prg
	../tobinary $(PROJECT).prg

install: $(PROJECT).prg
	cp $(PROJECT).prg ../..
	cd ../.. ; ./run -R $(PROJECT).prg

clean:
	-rm $(PROJECT).prg


