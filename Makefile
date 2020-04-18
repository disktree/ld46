
PROJECT = ld46
CFLAGS=-std=c11

build_ld46/linux-hl/ld46:
	cd build_ld46/linux-hl-build/Release && make $(CFLAGS)
	cp build_ld46/linux-hl-build/Release/ld46 build_ld46/linux-hl

develop:
	$(EDITOR) .
	blender ld46.blend

clean:
	rm -rf build_ld46

.PHONY: clean develop
