GO_MODULE := github.com/unknopu/proto

.PHONY = tidy
tidy:
	go mod tidy

.PHONY: clean
clean:
ifeq ($(OS), Windows_NT)
	if exist "protogen" rd /s /q protogen
else
	rm -fR ./protogen
endif

.PHONY: protoc
protoc:
	protoc --go_opt=module=${GO_MODULE} --go_out=. \
		--go-grpc_opt=module=${GO_MODULE}  --go-grpc_out=.\
		./proto/hello/*.proto 


.PHONY: build
build: clean protoc tidy

.PHONY: validate
validate:
	protoc --validate_out="lang=go:./generated" \
		--go_opt=module=${GO_MODULE} --go_out=. \
		./proto/car/*.proto

.PHONY: run
run:
	@go run .