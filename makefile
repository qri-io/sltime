.PHONY : list-deps install-deps
define GOPACKAGES 
github.com/360EntSecGroup-Skylar/excelize \
github.com/PuerkitoBio/goquery \
github.com/andybalholm/cascadia \
github.com/mohae/deepcopy \
github.com/qri-io/dataset \
golang.org/x/net/html \
go.starlark.net/starlark \
github.com/qri-io/dataset/dsio/replacecr \
github.com/paulmach/orb
endef

default: install-deps

list-deps:
	go list -f '{{.Deps}}' | tr "[" " " | tr "]" " " | xargs go list -f '{{if not .Standard}}{{.ImportPath}}{{end}}'

module-readmes:
	for doc in $$(find . | grep doc.go | tr '\n' ' '); do \
		outline template $$doc > $$(dirname $$doc)/README.md; \
	done

install-deps:
	go get -v $(GOPACKAGES)
